import 'package:banker_test_attempt/graphql_api/query_constants.dart';
import 'package:bloc/bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'transaction_bloc.dart';

class TransactionBloc extends Cubit<TransactionState> {
  final GraphQLClient client;

  TransactionBloc({required this.client}) : super(TransactionInitial());

  Future<void> fetchData() async {
    emit(TransactionLoading());

    try {
      // Perform your GraphQL query here
      final result = await client.query(QueryOptions(
        document: gql(QueryConstants.transactionQuery), // Replace with your GraphQL query
      ));

      // Handle the result and update state accordingly
      if (result.hasException) {
        // print(result.exception);
        emit(TransactionError(
          result.exception!.graphqlErrors.isNotEmpty
              ? result.exception!.graphqlErrors.first.message
              : 'Unknown error occurred',
        ));
      } else {
        final data = result.data;
        // final Map<String, dynamic> rawJson = result.source as Map<String, dynamic>;
        // print(result.data?['home']['name']);
        // print(jsonEncode(result.toString()));
        emit(TransactionLoaded(data));
      }
    } catch (e) {
      print(e);
      emit(TransactionError('Failed to fetch data'));
    }
  }
}
