import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
                // Handle Loans button press
                showLoansSnackBar(context);
              },
              child: Text('Loans'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle Statements button press
                navigateToStatements(context);
              },
              child: Text('Statements'),
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
    // Use GoRouter to navigate to the StatementsScreen
    GoRouter.of(context).pushNamed('/statements');
  }
}