import 'package:banker_test_attempt/graphql_api/query_constants.dart';
import 'package:bloc/bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'contact_bloc.dart';

class ContactBloc extends Cubit<ContactState> {
  final GraphQLClient client;

  ContactBloc({required this.client}) : super(ContactInitial());

  Future<void> fetchData() async {
    emit(ContactLoading());

    try {
      final result = await client.query(QueryOptions(
        document: gql(QueryConstants.contactQuery),
      )).timeout(const Duration(seconds: 10));

      if (result.hasException) {
        // print("Error : ${result.exception!.graphqlErrors.first.message}");
        emit(ContactError(
          result.exception!.graphqlErrors.isNotEmpty
              ? result.exception!.graphqlErrors.first.message
              : 'Unknown error occurred',
        ));
      } else {
        final data = result.data;
        emit(ContactLoaded(data));
      }
    } catch (e) {
      print(e);
      emit(ContactError('Failed to fetch data'));
    }
  }
}
