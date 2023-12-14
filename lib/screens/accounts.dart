import 'package:banker_test_attempt/bloc/account_bloc.dart';
import 'package:banker_test_attempt/bloc/account_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../graphql_api/graphql_service.dart';
import '../models/account_response.dart';
import 'accounts_subscreens/transactions_screen.dart';

class Accounts extends StatelessWidget {

  const Accounts({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountBloc(client: GraphQLService.client),
      child: AccountsScreenContent(),
    );

  }

}

class AccountsScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<AccountBloc>().fetchData();
    return Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            final List<AccountsDetails> accountsList = [];
            if (state is AccountLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AccountLoaded) {
              final data = state.data;
              // return Center(child: Text('Data: ${state.data['home']['recentTransactions'][0]['amount']}'));
              int accounts = data['accounts']?.length ?? 0;
              for (int i=0; i< accounts; i++) {
                accountsList.add(
                    AccountsDetails(
                      id : data['accounts'][i]['id'],
                      accountNumber : data['accounts'][i]['accountNumber'].toString(),
                      accountType : data['accounts'][i]['accountType'].toString(),
                      balance : (data['accounts'][i]['balance'] as num?)?.toDouble() ?? 0.0,
                      accountHolder : data['accounts'][i]['accountHolder'].toString(),
                    )
                );
              }
              return  ListView.builder(
                  itemCount: accountsList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(accountsList[index].accountNumber ?? ''),
                        subtitle: Text(accountsList[index].accountType ?? ''),
                        onTap: () {
                          // Navigate to Transactions screen when an account is tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TransactionsScreen(
                                accountsDetails: accountsList[index],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
            } else if (state is AccountError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Center(child: Text('Initial State'));
            }
          },
        )
    );
  }}