import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/api_config.dart';
import '../utils/constants.dart';
import 'AuthService.dart';

class ApiClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {"Content-Type": "application/json"},
      // 2xx–4xx are treated as normal responses; 5xx become errors
      validateStatus: (status) => status != null && status < 500,
      // optional but handy:
      receiveDataWhenStatusError: true,
    ),
  );

  static void setupInterceptors() {
    _dio.interceptors.clear();

    // 1) Auth interceptor (token attach + refresh)
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          debugPrint('Interceptor triggered for: ${options.uri}');

          // 🧩 Skip token handling for refresh endpoint
          if (options.path.contains(ApiConfig.refreshToken)) {
            debugPrint('🔹 Skipping interceptor for refresh token API');
            return handler.next(options);
          }

          final isGuestUser = await AuthService.isGuest;
          if (isGuestUser) {
            debugPrint('Guest user → skipping token for ${options.uri}');
            options.headers.remove('Authorization');
            return handler.next(options);
          }

          // final isExpired = await AuthService.isTokenExpired();
          // if (isExpired) {
          //   debugPrint('Token expired → trying refresh...');
          //   final refreshed = await _refreshToken();
          //   if (!refreshed) {
          //     debugPrint('❌ Token refresh failed, logging out...');
          //     await AuthService.logout();
          //     return handler.reject(
          //       DioException(
          //         requestOptions: options,
          //         error: 'Token refresh failed, please log in again',
          //         type: DioExceptionType.cancel,
          //       ),
          //     );
          //   }
          // }

          final accessToken = await AuthService.getAccessToken();
          if (accessToken?.isNotEmpty == true) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          } else {
            debugPrint('⚠️ Non-guest but no token found');
          }

          return handler.next(options);
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) async {
          final status = response.statusCode ?? 0;

          // --- 1) success (2xx) -> forward as usual
          if (status >= 200 && status < 300) {
            return handler.next(response);
          }

          // --- 2) Accept 422 as a handled failure: forward response to caller
          //     (so repos/controllers can read response.data['message'] etc.)
          if (status == 422) {
            // treat 422 as non-exceptional, let the caller handle the payload
            debugPrint('422 response — forwarding to caller for handling');
            return handler.next(response);
          }
          if (status == 409) {
            // treat 422 as non-exceptional, let the caller handle the payload
            debugPrint('409 response — forwarding to caller for handling');
            return handler.next(response);
          }

          // --- 3) Unauthorized -> force logout + reject
          if (status == 401) {
            debugPrint('❌ 401 Unauthorized, logging out...');
            await AuthService.logout();
            return handler.reject(
              DioException(
                requestOptions: response.requestOptions,
                response: response,
                error: 'Unauthorized, please log in again',
                type: DioExceptionType.badResponse,
              ),
            );
          }

          // --- 4) Account blocked
          if (status == 403) {
            debugPrint('❌ 403 Account Blocked');
            final context = navigatorKey.currentContext;
            context?.go('/blocked_account');
            return handler.reject(
              DioException(
                requestOptions: response.requestOptions,
                response: response,
                error: 'Your account is blocked',
                type: DioExceptionType.badResponse,
              ),
            );
          }

          // --- 5) Other 4xx/4xx-like -> reject so onError handler runs
          return handler.reject(
            DioException(
              requestOptions: response.requestOptions,
              response: response,
              error: 'Request failed (${response.statusCode})',
              type: DioExceptionType.badResponse,
            ),
          );
        },

        // keep your existing onError...
        onError: (DioException e, handler) {
          // ...existing mapping for timeouts, connectionError, 401/403 fallback, etc.
          // (leave as-is)
          final code = e.response?.statusCode;

          if (code == 401) {
            AuthService.logout();
            return handler.next(
              DioException(
                requestOptions: e.requestOptions,
                response: e.response,
                error: 'Unauthorized, please log in again',
                type: DioExceptionType.badResponse,
              ),
            );
          }

          if (code == 403) {
            final context = navigatorKey.currentContext;
            context?.go('/blocked_account');
            return handler.next(
              DioException(
                requestOptions: e.requestOptions,
                response: e.response,
                error: 'Your account is blocked',
                type: DioExceptionType.badResponse,
              ),
            );
          }

          if (e.type == DioExceptionType.connectionTimeout ||
              e.type == DioExceptionType.receiveTimeout ||
              e.type == DioExceptionType.sendTimeout) {
            return handler.next(
              DioException(
                requestOptions: e.requestOptions,
                error: 'Network timeout, please try again',
                type: e.type,
                response: e.response,
              ),
            );
          }

          if (e.type == DioExceptionType.connectionError) {
            return handler.next(
              DioException(
                requestOptions: e.requestOptions,
                error: 'No internet connection',
                type: e.type,
                response: e.response,
              ),
            );
          }

          return handler.next(e);
        },
      ),
    );
    // _dio.interceptors.add(
    //   InterceptorsWrapper(
    //     onResponse: (response, handler) async {
    //       final status = response.statusCode ?? 0;
    //
    //       if (status >= 200 && status <= 400) {
    //         // success
    //         return handler.next(response);
    //       }
    //       // 4xx arrive here because validateStatus(<500) returns true
    //       if (status == 401) {
    //         debugPrint('❌ 401 Unauthorized, logging out...');
    //         await AuthService.logout();
    //         return handler.reject(
    //           DioException(
    //             requestOptions: response.requestOptions,
    //             response: response,
    //             error: 'Unauthorized, please log in again',
    //             type: DioExceptionType.badResponse,
    //           ),
    //         );
    //       }
    //
    //       if (status == 403) {
    //         debugPrint('❌ 403 Account Blocked');
    //         final context = navigatorKey.currentContext;
    //         context?.go('/blocked_account');
    //         return handler.reject(
    //           DioException(
    //             requestOptions: response.requestOptions,
    //             response: response,
    //             error: 'Your account is blocked',
    //             type: DioExceptionType.badResponse,
    //           ),
    //         );
    //       }
    //
    //       // Any other 4xx -> normalize as DioException so repos/cubits can handle uniformly
    //       return handler.reject(
    //         DioException(
    //           requestOptions: response.requestOptions,
    //           response: response,
    //           error: 'Request failed (${response.statusCode})',
    //           type: DioExceptionType.badResponse,
    //         ),
    //       );
    //     },
    //
    //     onError: (DioException e, handler) {
    //       // Only 5xx (and network/timeout/cancel) reach here due to validateStatus(<500)
    //       final code = e.response?.statusCode;
    //
    //       if (code == 401) {
    //         // defensive: if a 401 still ends up here
    //         AuthService.logout();
    //         return handler.next(
    //           DioException(
    //             requestOptions: e.requestOptions,
    //             response: e.response,
    //             error: 'Unauthorized, please log in again',
    //             type: DioExceptionType.badResponse,
    //           ),
    //         );
    //       }
    //
    //       if (code == 403) {
    //         final context = navigatorKey.currentContext;
    //         context?.go('/blocked_account');
    //         return handler.next(
    //           DioException(
    //             requestOptions: e.requestOptions,
    //             response: e.response,
    //             error: 'Your account is blocked',
    //             type: DioExceptionType.badResponse,
    //           ),
    //         );
    //       }
    //
    //       // Optionally map timeouts / no-internet to friendly errors
    //       if (e.type == DioExceptionType.connectionTimeout ||
    //           e.type == DioExceptionType.receiveTimeout ||
    //           e.type == DioExceptionType.sendTimeout) {
    //         return handler.next(
    //           DioException(
    //             requestOptions: e.requestOptions,
    //             error: 'Network timeout, please try again',
    //             type: e.type,
    //             response: e.response,
    //           ),
    //         );
    //       }
    //
    //       if (e.type == DioExceptionType.connectionError) {
    //         return handler.next(
    //           DioException(
    //             requestOptions: e.requestOptions,
    //             error: 'No internet connection',
    //             type: e.type,
    //             response: e.response,
    //           ),
    //         );
    //       }
    //
    //       // leave others as-is (includes 5xx)
    //       return handler.next(e);
    //     },
    //   ),
    // );
  }

  static Future<bool> _refreshToken() async {
    try {
      final newToken = await AuthService.refreshToken();
      if (newToken) {
        debugPrint("✅ Token refreshed successfully");
        return true;
      }
      debugPrint("❌ Token refresh returned false");
    } catch (e) {
      debugPrint("❌ Token refresh failed: $e");
    }
    return false;
  }

  static Future<Response> get(
      String path, {
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Future<Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } catch (e) {
      return _handleError(e);
    }
  }

  static Response _handleError(dynamic error) {
    if (error is DioException) {
      throw error;
    } else {
      throw Exception("Unexpected error occurred");
    }
  }

  // Placeholder for _handleNavigation (implement as needed)
  static void _handleNavigation(
      int? statusCode,
      GlobalKey<NavigatorState> navigatorKey,
      ) {}
}

// class ApiClient {
//   static final Dio _dio = Dio(
//     BaseOptions(
//       baseUrl: ApiConfig.baseUrl,
//       connectTimeout: const Duration(seconds: 60),
//       receiveTimeout: const Duration(seconds: 60),
//       // We accept all statuses so responses reach onResponse; we’ll log 4xx/5xx ourselves.
//       validateStatus: (_) => true,
//     ),
//   );
//
//   static const List<String> _unauthenticatedEndpoints = [
//     '/api/app/user-login',
//     '/api/app/user-register',
//     '/api/app/get-active-carousel',
//     '/api/app/get-featured-categories',
//     '/api/app/get-all-products',
//     '/api/app/get-product/',
//   ];
//
//   static void setupInterceptors() {
//     try {
//       _dio.interceptors.clear();
//
//       _dio.interceptors.add(
//         LogInterceptor(
//           request: kDebugMode,
//           requestHeader: kDebugMode,
//           requestBody: kDebugMode,
//           responseHeader: kDebugMode,
//           responseBody: kDebugMode,
//           error: true,
//         ),
//       );
//
//       // // 2) Crashlytics
//       // _dio.interceptors.add(CrashlyticsDioInterceptor());
//
//       // 3) Auth & navigation wrapper
//       _dio.interceptors.add(
//         InterceptorsWrapper(
//           onRequest: (options, handler) async {
//             final isUnauthenticated = _unauthenticatedEndpoints.any(
//               (endpoint) => options.uri.path.startsWith(endpoint),
//             );
//
//             // Attach feature name optionally: options.extra['feature'] = 'profile_update';
//             // Allow opt-out per call: options.extra['skipCrashlytics'] = true;
//
//             // if (isUnauthenticated) {
//             //   return handler.next(options);
//             // }
//             if (isUnauthenticated) {
//               // For guest-accessible endpoints, attach token if available but don't reject if missing
//               final accessToken = await AuthService.getAccessToken();
//               AppLogger.info("accesstoken: $accessToken");
//
//               if (accessToken != null && accessToken.isNotEmpty) {
//                 options.headers['Authorization'] = 'Bearer $accessToken';
//               }
//               // Proceed with the request even if no token is present
//               return handler.next(options);
//             }
//
//             final accessToken = await AuthService.getAccessToken();
//             AppLogger.info("accesstoken: $accessToken");
//
//             if (accessToken == null || accessToken.isEmpty) {
//               await AuthService.logout();
//               return handler.reject(
//                 DioException(
//                   requestOptions: options,
//                   error: 'No access token, please log in again',
//                   type: DioExceptionType.cancel,
//                 ),
//               );
//             } else {
//               options.headers['Authorization'] = 'Bearer $accessToken';
//             }
//
//             return handler.next(options);
//           },
//
//           onResponse: (response, handler) async {
//             // Backend-driven token expiry (business status)
//             if (response.data is Map<String,dynamic>) {
//               final data = response.data as Map<String, dynamic>;
//               if (data['status'] == false &&
//                   data['message'] == 'Token is expired') {
//                 await AuthService.logout();
//                 return handler.reject(
//                   DioException(
//                     requestOptions: response.requestOptions,
//                     error: 'Token expired',
//                     response: response,
//                     type: DioExceptionType.badResponse,
//                   ),
//                 );
//               }
//             }
//
//             // Optional: central navigation on certain status codes
//             _handleNavigation(response.statusCode, navigatorKey);
//
//             return handler.next(response);
//           },
//
//           onError: (DioException e, handler) async {
//             final isUnauthenticated = _unauthenticatedEndpoints.any(
//               (endpoint) => e.requestOptions.uri.path.startsWith(endpoint),
//             );
//
//             if (!isUnauthenticated && e.response?.statusCode == 401) {
//               await AuthService.logout();
//               // Let the UI catch this rejection and route to login
//               return handler.reject(
//                 DioException(
//                   requestOptions: e.requestOptions,
//                   error: 'Unauthorized, please log in again',
//                   type: DioExceptionType.badResponse,
//                   response: e.response,
//                 ),
//               );
//             }
//
//             return handler.next(e);
//           },
//         ),
//       );
//     } catch (e, stackTrace) {
//       // Record unexpected setup failures
//       // FirebaseCrashlytics.instance.recordError(e, stackTrace, fatal: false);
//     }
//   }
//
//   // --- HTTP verbs (unchanged except passing options through) ---
//
//   static Future<Response> get(
//     String path, {
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//   }) async {
//     try {
//       AppLogger.log("called get method");
//       return await _dio.get(
//         path,
//         queryParameters: queryParameters,
//         options: options,
//       );
//     } catch (e) {
//       return _handleError(e);
//     }
//   }
//
//   static Future<Response> post(
//     String path, {
//     dynamic data,
//     Options? options,
//   }) async {
//     try {
//       return await _dio.post(path, data: data, options: options);
//     } catch (e) {
//       return _handleError(e);
//     }
//   }
//
//   static Future<Response> put(
//     String path, {
//     dynamic data,
//     Options? options,
//   }) async {
//     try {
//       return await _dio.put(path, data: data, options: options);
//     } catch (e) {
//       return _handleError(e);
//     }
//   }
//
//   static Future<Response> delete(String path, {Options? options}) async {
//     try {
//       return await _dio.delete(path, options: options);
//     } catch (e) {
//       return _handleError(e);
//     }
//   }
//
//   static Never _handleError(dynamic error) {
//     if (error is DioException) {
//       throw error; // already captured by interceptor
//     } else {
//       final ex = Exception("Unexpected error occurred");
//       // FirebaseCrashlytics.instance.recordError(error, StackTrace.current, fatal: false);
//       throw ex;
//     }
//   }
//
//   static void _handleNavigation(
//     int? statusCode,
//     GlobalKey<NavigatorState> navigatorKey,
//   ) {
//     // Example: if (statusCode == 403) navigatorKey.currentState?.pushNamed('/no-access');
//   }
// }
