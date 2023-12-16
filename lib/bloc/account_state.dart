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
      final result = await client.query(QueryOptions(
        document: gql(QueryConstants.accountQuery),
      )).timeout(const Duration(seconds: 10));

      if (result.hasException) {
        emit(AccountError(
          result.exception!.graphqlErrors.isNotEmpty
              ? result.exception!.graphqlErrors.first.message
              : 'Unknown error occurred',
        ));
      } else {
        final data = result.data;
        emit(AccountLoaded(data));
      }
    } catch (e) {
      print(e);
      emit(AccountError('Failed to fetch data'));
    }
  }
}
