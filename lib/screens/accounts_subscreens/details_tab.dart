import 'package:flutter/material.dart';

import '../../models/account_response.dart';
import '../accounts.dart';

class DetailsTab extends StatelessWidget {
  final AccountsDetails account;

  const DetailsTab({required this.account});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Account Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Account Number: ${account.accountNumber}'),
                    Text('Account Holder: ${account.accountHolder}'),
                    Text('Account Type: ${account.accountType}'),
                    Text('Balance: ${account.balance}'),
                  ],
                ),
              ),
            ),
            // Add more Card widgets or sections for additional details if needed
          ],
        ),
      ),
    );
  }
}