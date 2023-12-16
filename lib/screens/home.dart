import 'package:banker_test_attempt/models/home_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../graphql_api/graphql_service.dart';
import '../bloc/home_state.dart';
import '../bloc/home_bloc.dart';
import 'dart:convert';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(client: GraphQLService.client),
      child: HomeScreenContent(),
    );
  }
}

class HomeScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().fetchData();
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoaded) {
            final data = state.data;
            // return Center(child: Text('Data: ${state.data['home']['recentTransactions'][0]['amount']}'));
            int transCount = data['home']['recentTransactions']?.length ?? 0;
            final List<RecentTransactions> transactionList = [];
            for (int i=0; i<transCount; i++) {
              transactionList.add(
                  RecentTransactions(
                date : data['home']['recentTransactions'][i]['date'].toString(),
                description : data['home']['recentTransactions'][i]['description'].toString(),
                amount : data['home']['recentTransactions'][i]['amount'],
                fromAccount : data['home']['recentTransactions'][i]['fromAccount'].toString(),
                toAccount : data['home']['recentTransactions'][i]['toAccount'].toString(),
              ));
            }
            int billCount = data['home']['upcomingBills']?.length ?? 0;;
            final List<UpcomingBills> upcomingBillsList = [];
            for (int i=0; i<billCount; i++) {
              upcomingBillsList.add(
                  UpcomingBills(
                    date : data['home']['upcomingBills'][i]['date'].toString(),
                    description : data['home']['upcomingBills'][i]['description'].toString(),
                    amount : (data['home']['upcomingBills'][i]['amount'] as num?)?.toDouble() ?? 0.0,
                    fromAccount : data['home']['upcomingBills'][i]['fromAccount'].toString(),
                    toAccount : data['home']['upcomingBills'][i]['toAccount'].toString(),
                  ));
            }
            return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${data['home']['name'] ?? ""}'),
                  Text('Account Number: ${data['home']['accountNumber'] ?? ""}'),
                  Text('Balance: ${data['home']['balance'] ?? ""} ${data['home']['currency'] ?? ""}'),
                  Text('Address: ${data['home']['address']['streetName'] ?? ""}, ${data['home']['address']['townName'] ?? ""}, ${data['home']['address']['country'] ?? ""}'),
                  SizedBox(height: 16),
                  Text('Recent Transactions:'),
                  _buildTransactionList(transCount, transactionList),
                  SizedBox(height: 16),
                  Text('Upcoming Bills:'),
                  _buildUpcomingTransactionList(billCount, upcomingBillsList),
                ],
              ),
            );
          } else if (state is HomeError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Center(child: Text('Initial State'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Trigger the fetch data action
          context.read<HomeBloc>().fetchData();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildTransactionList(int count , List<RecentTransactions>? transactions) {
    if (transactions == null || transactions.isEmpty) {
      return Text('No transactions available.');
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text('${transaction.date ?? ""} - ${transaction.description ?? ""}'),
            subtitle: Text('Amount: ${transaction.amount ?? ""}, From: ${transaction.fromAccount ?? ""}, To: ${transaction.toAccount ?? ""}'),
          ),
        );
      },
    );
  }

  Widget _buildUpcomingTransactionList(int count , List<UpcomingBills>? transactions) {
    if (transactions == null || transactions.isEmpty) {
      return Text('No transactions available.');
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text('${transaction.date ?? ""} - ${transaction.description ?? ""}'),
            subtitle: Text('Amount: ${transaction.amount ?? ""}, From: ${transaction.fromAccount ?? ""}, To: ${transaction.toAccount ?? ""}'),
          ),
        );
      },
    );
  }
}