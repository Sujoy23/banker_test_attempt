import 'dart:js';

import 'package:banker_test_attempt/router/screen_router_constants.dart';
import 'package:banker_test_attempt/screens/accounts.dart';
import 'package:banker_test_attempt/screens/contact.dart';
import 'package:banker_test_attempt/screens/error_page.dart';
import 'package:banker_test_attempt/screens/home.dart';
import 'package:banker_test_attempt/screens/loans.dart';
import 'package:banker_test_attempt/screens/services.dart';
import 'package:banker_test_attempt/screens/statements.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter returnRouter(bool isAuth) {
    GoRouter router =GoRouter(
        routes: [
          GoRoute(
            name: ScreenRouteConstants.homeRouteName,
            path: '/',
            pageBuilder: (context, state) {
              return const MaterialPage(child: Home());
            }
          ),
          GoRoute(
              name: ScreenRouteConstants.accountRouteName,
              path: '/about',
              pageBuilder: (context, state) {
                return const MaterialPage(child: Accounts());
              }
          ),
          GoRoute(
              name: ScreenRouteConstants.contactUsRouteName,
              path: '/contact_us',
              pageBuilder: (context, state) {
                return const MaterialPage(child: Contact());
              }
          ),
          GoRoute(
              name: ScreenRouteConstants.loanRouteName,
              path: '/loan',
              pageBuilder: (context, state) {
                return const MaterialPage(child: Loans());
              }
          ),
          GoRoute(
              name: ScreenRouteConstants.servicesRouteName,
              path: '/services',
              pageBuilder: (context, state) {
                return const MaterialPage(child: Services());
              }
          ),
          GoRoute(
              name: ScreenRouteConstants.statementsRouteName,
              path: '/statements',
              pageBuilder: (context, state) {
                return const MaterialPage(child: Statements());
              }
          ),
        ],
      errorPageBuilder: (context, state) {
        return MaterialPage(child: ErrorPage());
      },
    );
    return router;
  }
}