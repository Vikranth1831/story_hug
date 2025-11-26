import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/pages/Passwordchange/passwordchange.dart';
import 'package:story_hug/pages/Reminder/reminders.dart';
import 'package:story_hug/pages/SuccesspageClass/successpage.dart';
import 'package:story_hug/pages/creating_profile_for_kids/entering_fields.dart';
import 'package:story_hug/pages/creating_profile_for_kids/manage_kids.dart';
import 'package:story_hug/pages/Authentication/login_screen.dart';
import 'package:story_hug/pages/lets-begin.dart';

import 'package:story_hug/pages/profile.dart';
import 'package:story_hug/pages/recording_voice/recording_voice.dart';
import 'package:story_hug/pages/recording_voice/save_voice.dart';
import 'package:story_hug/pages/recording_voice/start_recording_voice.dart';
import 'package:story_hug/pages/Section1/card-parts.dart';
import 'package:story_hug/pages/Section1/card-view.dart';
import 'package:story_hug/pages/Section1/Home.dart';

import 'package:story_hug/pages/splash_screen.dart';
import 'package:story_hug/pages/verify_email.dart';
import 'package:story_hug/pages/Section1/playicard.dart';
import 'package:story_hug/pages/Subscriptions%20page/subscriptions.dart';
import 'package:story_hug/pages/favorites/favorites.dart';
import '../pages/Authentication/otp-screen.dart';
import '../pages/Authentication/sign_up_screen.dart';
import '../pages/creating_profile_for_kids/create_profile_forkids.dart';

import '../utils/CrashlyticsNavObserver.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  // debugLogDiagnostics: false,
  // observers: [CrashlyticsNavObserver()],
  // overridePlatformDefaultLocation: false,
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(SplashScreen(), state);
      },
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(LoginScreen(), state);
      },
    ),

    GoRoute(

      path: '/homepage',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(HomeScreen(), state);
      },
    ),
    GoRoute(
      path: '/profile_screen',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(ProfileScreen(), state);
      },
    ),
    GoRoute(
      path: '/verify_email',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(VerifyEmail(), state);
      },
    ),
    GoRoute(
      path: '/sign_up',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(SignUpScreen(), state);
      },
    ),
    GoRoute(
      path: '/select',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(SelectedCardView(), state);
      },
    ),
    GoRoute(
      path: '/start_recording_voice',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(StartRecordingVoice(), state);
      },
    ),
    GoRoute(
      path: '/profile_for_kids',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(CreateProfileForkids(), state);
      },
    ),
    GoRoute(
      path: '/entering_fields_for_kids',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(EnteringFieldsForKid(), state);
      },
    ),
    GoRoute(
      path: '/manage_kids',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(ManageKids(), state);
      },
    ),
    GoRoute(
      path: '/start_recording_voice',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(StartRecordingVoice(), state);
      },
    ),
    GoRoute(
      path: '/recording_voice',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(RecordingVoice(), state);
      },
    ),
    GoRoute(
      path: '/save_voice',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(SaveVoice(), state);

      },
    ),
    GoRoute(
      path: '/view_cards',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(ViewCardParts(), state);
      },
    ),
    GoRoute(
      path: '/play-story',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(PlayStory(), state);
      },
    ),
    GoRoute(
      path: '/favorites',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(Favorites(), state);
      },
    ),
    GoRoute(
      path: '/subscribe',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(Subscribepage(), state);
      },
    ),
    GoRoute(
      path: '/reminders',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(RemindersPage(), state);
      },
    ),
    GoRoute(
      path: '/otp-screen',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(OtpScreen(), state);
      },
    ),

    GoRoute(
      path: '/password-change',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(Passwordchange(), state);
      },
    ),

    GoRoute(
      path: '/home',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(HomeScreen(), state);
      },
    ),
    GoRoute(
      path: '/success',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(
          SuccessPage(
            titleText: state.extra != null ? (state.extra as Map)['title'] : '',
            buttonText: state.extra != null ? (state.extra as Map)['button'] : '',
          ),
          state,
        );
      },
    ),
    GoRoute(
      path: '/lets-begin',
      pageBuilder: (context, state) {
        return buildSlideTransitionPage(LetsBegin(), state);
      },
    ),

],
  // errorBuilder: (context, state) {
  //   final err = state.error ?? 'Unknown router error';
  //   FirebaseCrashlytics.instance.recordError(
  //     err,
  //     StackTrace.current,
  //     fatal: false,
  //     information: [
  //       DiagnosticsNode.message('matchedLocation: ${state.matchedLocation}'),
  //       DiagnosticsNode.message('uri: ${state.uri}'),
  //       DiagnosticsNode.message('pathParams: ${state.pathParameters}'),
  //       DiagnosticsNode.message('queryParams: ${state.uri.queryParameters}'),
  //     ],
  //   );
  //
  //   return const Scaffold(body: Center(child: Text('Something went wrong')));
  // },
);

Page<dynamic> buildSlideTransitionPage(Widget child, GoRouterState state) {
  // if (Platform.isIOS) {
  //   // Use default Cupertino transition on iOS
  //   return CupertinoPage(key: state.pageKey, child: child);
  // }

  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}
