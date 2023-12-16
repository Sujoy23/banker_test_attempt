import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/app_router.dart';
import '../router/screen_router_constants.dart';

class Services extends StatelessWidget {
  const Services({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showLoansSnackBar(context);
              },
              child: Text('Loans'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                navigateToStatements(context);
              },
              child: Text('Statements'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                navigateToContacts(context);
              },
              child: Text('Contacts'),
            ),
          ],
        ),
      ),
    );
  }

  void showLoansSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('No Active Loans Found!!'),
      ),
    );
  }

  void navigateToStatements(BuildContext context) {
    GoRouter.of(context).pushNamed(ScreenRouteConstants.statementsRouteName);
  }

  void navigateToContacts(BuildContext context) {
    GoRouter.of(context).pushNamed(ScreenRouteConstants.contactUsRouteName);
  }
}