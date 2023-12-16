// blocs/home_bloc.dart
import 'dart:convert';

import 'package:banker_test_attempt/bloc/statement_bloc.dart';
import 'package:banker_test_attempt/graphql_api/query_constants.dart';
import 'package:bloc/bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


class StatementBloc extends Cubit<StatementState> {
  final GraphQLClient client;

  StatementBloc({required this.client}) : super(StatementInitial());

  Future<void> fetchData() async {
    emit(StatementLoading());

    try {
      final result = await client.query(QueryOptions(
        document: gql(QueryConstants.statementsQuery),
      )).timeout(const Duration(seconds: 10));

      if (result.hasException) {
        emit(StatementError(
          result.exception!.graphqlErrors.isNotEmpty
              ? result.exception!.graphqlErrors.first.message
              : 'Unknown error occurred',
        ));
      } else {
        final data = result.data;
        emit(StatementLoaded(data));
      }
    } catch (e) {
      print(e);
      emit(StatementError('Failed to fetch data'));
    }
  }
}
