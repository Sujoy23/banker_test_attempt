import 'package:banker_test_attempt/bloc/account_state.dart';
import 'package:banker_test_attempt/bloc/account_bloc.dart';
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
  final List<AccountsDetails> accountsList = [];
  void insertAccountsDetails(final data) {
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
  }

  @override
  Widget build(BuildContext context) {
    context.read<AccountBloc>().fetchData();
    return Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            if (state is AccountLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AccountLoaded) {
              final data = state.data;
              insertAccountsDetails(data);
              return  ListView.builder(
                  itemCount: accountsList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(' Acc. No : ${accountsList[index].accountNumber ?? ''}'),
                        subtitle: Text('Account holder : ${accountsList[index].accountHolder ?? ''}'),
                        onTap: () {
                          // Using Navigator here to push account details easily.
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
              return const Center(child: Text('Initial State'));
            }
          },
        )
    );
  }}