import 'dart:async';
import 'dart:convert';
import 'dart:developer' as AppLogger;
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import 'package:story_hug/pages/login_screen.dart';
import 'package:story_hug/services/ApiClient.dart';
import 'package:story_hug/services/SecureStorageService.dart';
import 'package:story_hug/utils/color_constants.dart';
import 'package:story_hug/utils/media_query_helper.dart';
// import 'app_routes/router.dart';
import 'package:provider/provider.dart';

import 'StateInjector.dart';
import 'app_routes/router.dart';

//
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
//
// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//
// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel',
//   'High Importance Notifications',
//   description: 'This channel is used for important notifications.',
//
//   importance: Importance.high,
//   playSound: true,
// );
//
// // Background handler MUST be a top-level function and annotated.
// @pragma('vm:entry-point')
// // Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// //   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
// //   // optionally log/route background payloads
// // }
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Optional in dev: make zone mistakes fatal
  // BindingBase.debugZoneErrorsAreFatal = true;
  // runZonedGuarded(
  //   () async {
  //     // Everything below runs in the SAME zone as runApp()
  //     WidgetsFlutterBinding.ensureInitialized();
  //
  //     // await Firebase.initializeApp(
  //     //   options: DefaultFirebaseOptions.currentPlatform,
  //     // );
  //
  //     // Crashlytics hooks
  //     FlutterError.onError = (FlutterErrorDetails details) {
  //       FlutterError.presentError(details);
  //       FirebaseCrashlytics.instance.recordFlutterError(details);
  //     };
  //
  //     PlatformDispatcher.instance.onError = (error, stack) {
  //       FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //       return true;
  //     };
  //
  //     Isolate.current.addErrorListener(
  //       RawReceivePort((pair) async {
  //         final List<dynamic> errorAndStacktrace = pair;
  //         await FirebaseCrashlytics.instance.recordError(
  //           errorAndStacktrace.first,
  //           errorAndStacktrace.last,
  //           fatal: true,
  //         );
  //       }).sendPort,
  //     );
  //
  //     // Bloc observer (if you use BLoC/Cubit)
  //     // Bloc.observer = CrashlyticsBlocObserver();
  //
  //     // API interceptors
  //     ApiClient.setupInterceptors();
  //
  //     // Orientation
  //     await SystemChrome.setPreferredOrientations([
  //       DeviceOrientation.portraitUp,
  //     ]);
  //
  //     // FCM — register background handler BEFORE any onMessage listeners
  //     // FirebaseMessaging.onBackgroundMessage(
  //     //   _firebaseMessagingBackgroundHandler,
  //     // );
  //
  //     final messaging = FirebaseMessaging.instance;
  //
  //     // iOS permission request
  //     await messaging.requestPermission(alert: true, badge: true, sound: true);
  //
  //     if (Platform.isIOS) {
  //       final apnsToken = await messaging.getAPNSToken();
  //       AppLogger.log("APNs Token: $apnsToken");
  //     }
  //
  //     // Get FCM token
  //     final fcmToken = await messaging.getToken();
  //     AppLogger.log("FCM Token: $fcmToken");
  //     if (fcmToken != null) {
  //       await SecureStorageService.instance.setString("fb_token", fcmToken);
  //     }
  //
  //     // Foreground presentation (iOS)
  //     await FirebaseMessaging.instance
  //         .setForegroundNotificationPresentationOptions(
  //           alert: true,
  //           badge: true,
  //           sound: true,
  //         );
  //
  //     // Local notifications init
  //     const iosInit = DarwinInitializationSettings(
  //       requestAlertPermission: true,
  //       requestBadgePermission: true,
  //       requestSoundPermission: true,
  //     );
  //
  //     const initSettings = InitializationSettings(
  //       android: AndroidInitializationSettings('@mipmap/ic_launcher'),
  //       iOS: iosInit,
  //     );
  //
  //     await flutterLocalNotificationsPlugin.initialize(
  //       initSettings,
  //       onDidReceiveNotificationResponse:
  //           (NotificationResponse response) async {
  //             // Handle notification tap routing via navigatorKey / go_router
  //           },
  //     );
  //
  //     // Create Android notification channel (Android 8.0+)
  //     await flutterLocalNotificationsPlugin
  //         .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin
  //         >()
  //         ?.createNotificationChannel(channel);
  //
  //     // Foreground messages → show local notification
  //     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //       final notification = message.notification;
  //       final android = message.notification?.android;
  //       if (notification != null && android != null) {
  //         showNotification(notification, android, message.data);
  //       }
  //     });
  //
  //     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //       // Handle launches from tray taps
  //     });


  runApp(const MyApp()); // ✅ same zone as everything above
  //   },
  //   (error, stack) async {
  //     await FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   },
  // );
}

// Show a local notification for a foreground FCM
// void showNotification(
//   RemoteNotification notification,
//   AndroidNotification android,
//   Map<String, dynamic> data,
// ) async {
//   final androidDetails = AndroidNotificationDetails(
//     channel.id,
//     channel.name,
//     channelDescription: channel.description,
//     importance: Importance.max,
//     priority: Priority.high,
//     playSound: true,
//     icon: '@mipmap/ic_launcher',
//   );
//
//   final details = NotificationDetails(android: androidDetails);
//
//   await flutterLocalNotificationsPlugin.show(
//     notification.hashCode,
//     notification.title,
//     notification.body,
//     details,
//     payload: jsonEncode(data),
//   );
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GetMaterialApp(
      title: 'StoryHug',
    home: LoginScreen(),
    //  routeInformationParser: appRouter.routeInformationParser,
      //routeInformationProvider: appRouter.routeInformationProvider,
      //routerDelegate: appRouter.routerDelegate,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: primarycolor,
          selectionColor: primarycolor.withOpacity(0.3),
          selectionHandleColor: primarycolor,
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.white,
        dialogBackgroundColor: Colors.white,
        cardColor: Colors.white,
        searchBarTheme: const SearchBarThemeData(),
        tabBarTheme: const TabBarThemeData(),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
            color: hintColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: "Inter",
          ),
          labelStyle: TextStyle(
            color: labeltextColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: "Inter",
          ),
          filled: true,
          fillColor: Colors.black,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Color(0xff7C7C7C), width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Color(0xff7C7C7C), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Color(0xff7C7C7C), width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Color(0xff7C7C7C), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Color(0xff7C7C7C), width: 1),
          ),
          errorStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
        ),
        dialogTheme: const DialogThemeData(
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
        buttonTheme: const ButtonThemeData(),
        popupMenuTheme: const PopupMenuThemeData(
          color: Colors.white,
          shadowColor: Colors.white,
        ),
        appBarTheme: AppBarTheme(surfaceTintColor: Colors.white),
        cardTheme: CardThemeData(
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          color: Colors.white,
        ),
        textButtonTheme: TextButtonThemeData(style: ButtonStyle()),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle()),
        outlinedButtonTheme: OutlinedButtonThemeData(style: ButtonStyle()),
        bottomSheetTheme: const BottomSheetThemeData(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
        ),
        colorScheme: const ColorScheme.light(
          background: Colors.white,
        ).copyWith(background: Colors.white),
        fontFamily: 'segeo',
      ),
      debugShowCheckedModeBanner: false,
      // routerConfig: appRouter,
    );
  }
}
