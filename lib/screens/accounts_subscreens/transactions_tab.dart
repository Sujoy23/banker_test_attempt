import 'package:banker_test_attempt/graphql_api/graphql_service.dart';
import 'package:banker_test_attempt/models/transaction_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/transaction_bloc.dart';
import '../../bloc/transaction_state.dart';
import '../../models/account_response.dart';
import '../accounts.dart';

class TransactionsTab extends StatelessWidget {

  const TransactionsTab({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (context) => TransactionBloc(client: GraphQLService.client),
      child: AccountsScreenContent(),
    );
  }
}

class AccountsScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<TransactionBloc>().fetchData();
    return Scaffold(
        body: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            final List<Transactions> transactions = [];
            if (state is TransactionLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TransactionLoaded) {
              final data = state.data;
              // return Center(child: Text('Data: ${state.data['home']['recentTransactions'][0]['amount']}'));
              int accounts = data['transactions']?.length ?? 0;
              for (int i=0; i< accounts; i++) {
                transactions.add(
                    Transactions(
                      date : data['transactions'][i]['date'],
                      description : data['transactions'][i]['description'].toString(),
                      fromAccount : data['transactions'][i]['fromAccount'].toString(),
                      amount : (data['transactions'][i]['amount'] as num?)?.toDouble() ?? 0.0,
                      toAccount : data['transactions'][i]['toAccount'].toString(),
                    )
                );
              }
              return  ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text('${transactions[index].date ?? ""} - ${transactions[index].description ?? ""}'),
                      subtitle: Text('Amount: ${transactions[index].amount ?? ""}, From: ${transactions[index].fromAccount ?? ""}, To: ${transactions[index].toAccount ?? ""}'),
                    ),
                  );
                },
              );
            } else if (state is TransactionError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Center(child: Text('Initial State'));
            }
          },
        )
    );
  }
}