import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/views/home.dart';
import 'package:weather/views/splash.dart';

class AppRouter {
  static const root = '/';
  static const homeRoute = "/homeRoute";
  static const getStated = "/started";

  /// [_router] use this in [MaterialApp.router]
  static final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: root,
        name: 'splash',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashView();
        },
      ),
      GoRoute(
        path: homeRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeView();
        },
      ),
    ],
    // errorBuilder: errorWidget,
  );

  static GoRouter get router => _router;
}
