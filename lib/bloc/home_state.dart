// blocs/home_bloc.dart
import 'dart:convert';

import 'package:banker_test_attempt/graphql_api/query_constants.dart';
import 'package:bloc/bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'home_bloc.dart';

class HomeBloc extends Cubit<HomeState> {
  final GraphQLClient client;

  HomeBloc({required this.client}) : super(HomeInitial());

  Future<void> fetchData() async {
    emit(HomeLoading());

    try {
      // Perform your GraphQL query here
      final result = await client.query(QueryOptions(
        document: gql(QueryConstants.homeQuery), // Replace with your GraphQL query
      ));

      // Handle the result and update state accordingly
      if (result.hasException) {
        // print(result.exception);
        emit(HomeError(
          result.exception!.graphqlErrors.isNotEmpty
              ? result.exception!.graphqlErrors.first.message
              : 'Unknown error occurred',
        ));
      } else {
        // Parse the result and update state with data


        final data = result.data;
        // final Map<String, dynamic> rawJson = result.source as Map<String, dynamic>;
        // print(result.data?['home']['name']);
        // print(jsonEncode(result.toString()));
        emit(HomeLoaded(data));
      }
    } catch (e) {
      print(e);
      emit(HomeError('Failed to fetch data'));
    }
  }
}
