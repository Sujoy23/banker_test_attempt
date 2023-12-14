import 'package:banker_test_attempt/graphql_api/query_constants.dart';
import 'package:bloc/bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'account_bloc.dart';

class AccountBloc extends Cubit<AccountState> {
  final GraphQLClient client;

  AccountBloc({required this.client}) : super(AccountInitial());

  Future<void> fetchData() async {
    emit(AccountLoading());

    try {
      // Perform your GraphQL query here
      final result = await client.query(QueryOptions(
        document: gql(QueryConstants.accountQuery), // Replace with your GraphQL query
      ));

      // Handle the result and update state accordingly
      if (result.hasException) {
        // print(result.exception);
        emit(AccountError(
          result.exception!.graphqlErrors.isNotEmpty
              ? result.exception!.graphqlErrors.first.message
              : 'Unknown error occurred',
        ));
      } else {
        final data = result.data;
        // final Map<String, dynamic> rawJson = result.source as Map<String, dynamic>;
        // print(result.data?['home']['name']);
        // print(jsonEncode(result.toString()));
        emit(AccountLoaded(data));
      }
    } catch (e) {
      print(e);
      emit(AccountError('Failed to fetch data'));
    }
  }
}
