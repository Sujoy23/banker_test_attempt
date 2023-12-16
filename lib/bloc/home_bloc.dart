// blocs/home_state.dart
import 'dart:convert';

import 'package:banker_test_attempt/graphql_api/query_constants.dart';
import 'package:bloc/bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  final GraphQLClient client;

  HomeBloc({required this.client}) : super(HomeInitial());

  Future<void> fetchData() async {
    emit(HomeLoading());

    try {
      final result = await client.query(QueryOptions(
        document: gql(QueryConstants.homeQuery),
      )).timeout(const Duration(seconds: 10));

      if (result.hasException) {
        emit(HomeError(
          result.exception!.graphqlErrors.isNotEmpty
              ? result.exception!.graphqlErrors.first.message
              : 'Unknown error occurred',
        ));
      } else {
        final data = result.data;
        emit(HomeLoaded(data));
      }
    } catch (e) {
      print(e);
      emit(HomeError('Failed to fetch data'));
    }
  }
}
