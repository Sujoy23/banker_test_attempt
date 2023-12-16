import 'package:banker_test_attempt/graphql_api/query_constants.dart';
import 'package:bloc/bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'account_state.dart';

class AccountBloc extends Cubit<AccountState> {
  final GraphQLClient client;

  AccountBloc({required this.client}) : super(AccountInitial());

  Future<void> fetchData() async {
    print('Emitting..1');
    emit(AccountLoading());
    print('Emitted..1');

    try {
      final result = await client.query(QueryOptions(
        document: gql(QueryConstants.accountQuery),
      )).timeout(const Duration(seconds: 10));

      if (result.hasException) {
        print('Emitting..2');
        emit(AccountError(
          result.exception!.graphqlErrors.isNotEmpty
              ? result.exception!.graphqlErrors.first.message
              : 'Unknown error occurred',
        ));
      } else {
        print('Emitting..3');
        final data = result.data;
        emit(AccountLoaded(data));
      }
    } catch (e) {
      print(e);
      print('Emitting..4');
      emit(AccountLoaded('null'));
    }
  }
}
