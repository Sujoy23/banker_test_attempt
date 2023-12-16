import 'package:banker_test_attempt/graphql_api/query_constants.dart';
import 'package:bloc/bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'transaction_state.dart';

class TransactionBloc extends Cubit<TransactionState> {
  final GraphQLClient client;

  TransactionBloc({required this.client}) : super(TransactionInitial());

  Future<void> fetchData() async {
    emit(TransactionLoading());

    try {
      final result = await client.query(QueryOptions(
        document: gql(QueryConstants.transactionQuery),
      )).timeout(const Duration(seconds: 10));

      if (result.hasException) {
        emit(TransactionError(
          result.exception!.graphqlErrors.isNotEmpty
              ? result.exception!.graphqlErrors.first.message
              : 'Unknown error occurred',
        ));
      } else {
        final data = result.data;
        emit(TransactionLoaded(data));
      }
    } catch (e) {
      print(e);
      emit(TransactionError('Failed to fetch data'));
    }
  }
}
