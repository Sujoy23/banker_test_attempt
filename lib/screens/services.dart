import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/app_router.dart';
import '../router/screen_router_constants.dart';

class Services extends StatelessWidget {
  const Services({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage('assets/support_img.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showLoansSnackBar(context);
                  },
                  style: ElevatedButton.styleFrom( // Set the button color
                    fixedSize: Size.fromWidth(200.0), // Set the width of the button
                    padding: EdgeInsets.symmetric(vertical: 16.0), // Adjust vertical padding
                  ),
                  child: Text('Loans', style: TextStyle(fontSize: 18.0, color: Colors.blue)),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    navigateToStatements(context);
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromWidth(200.0),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: Text('Statements', style: TextStyle(fontSize: 18.0, color: Colors.blue)),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    navigateToContacts(context);
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromWidth(200.0),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: Text('Contacts', style: TextStyle(fontSize: 18.0, color: Colors.blue)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showLoansSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
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