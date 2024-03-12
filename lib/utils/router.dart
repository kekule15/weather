import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/views/splash.dart';

final GoRouter goRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashView();
      },
      routes: <RouteBase>[
        // GoRoute(
        //   path: 'companydashboard',
        //   builder: (BuildContext context, GoRouterState state) {
        //     return  CompanyDashBoard();
        //   },
        // ),
        // GoRoute(
        //   path: 'ridersingup',
        //   builder: (BuildContext context, GoRouterState state) {
        //     return CompanyRiderSignUp();
        //   },
        // ),
      ],
    ),
  ],
);
