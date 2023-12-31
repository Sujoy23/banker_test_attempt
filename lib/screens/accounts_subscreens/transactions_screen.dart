import 'package:banker_test_attempt/models/account_response.dart';
import 'package:banker_test_attempt/screens/accounts_subscreens/transactions_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../bloc/transaction_bloc.dart';
import 'details_tab.dart';

class TransactionsScreen extends StatelessWidget {
  final AccountsDetails accountsDetails;

  const TransactionsScreen({required this.accountsDetails});

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('Transactions',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Transactions'),
              Tab(text: 'Details'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Transactions Tab
            TransactionsTab(),

            // Details Tab
            DetailsTab(account: accountsDetails),
          ],
        ),
      ),
    );
  }
}