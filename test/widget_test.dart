import 'package:banker_test_attempt/bloc/account_state.dart';
import 'package:banker_test_attempt/graphql_api/graphql_service.dart';
import 'package:banker_test_attempt/graphql_api/query_constants.dart';
import 'package:banker_test_attempt/screens/accounts.dart';
import 'package:banker_test_attempt/screens/home.dart';
import 'package:banker_test_attempt/screens/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:banker_test_attempt/bloc/account_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {

  test('insertAccountsDetails should add details to accountsList', () {
    // Arrange
    final accountsScreenContent = AccountsScreenContent();
    final testData = {
      'accounts': [
        {
          'id': '1',
          'accountNumber': '1234567890',
          'accountType': 'Savings',
          'balance': 2500.5,
          'accountHolder': 'John Doe',
        },
        // Add more account data as needed
      ],
    };

    // Act
    accountsScreenContent.insertAccountsDetails(testData);

    // Assert
    expect(accountsScreenContent.accountsList.length, 1);
    expect(accountsScreenContent.accountsList[0].id, '1');
    expect(accountsScreenContent.accountsList[0].accountNumber, '1234567890');
    expect(accountsScreenContent.accountsList[0].accountType, 'Savings');
    expect(accountsScreenContent.accountsList[0].balance, 2500.5);
    expect(accountsScreenContent.accountsList[0].accountHolder, 'John Doe');
  });


  group('AccountBloc', () {
    late AccountBloc accountBloc;
    late MockGraphQLClient mockClient;

    setUp(() {
      mockClient = MockGraphQLClient();
      accountBloc = AccountBloc(client: GraphQLService.client);
    });

    tearDown(() {
      accountBloc.close();
    });

    test('emits AccountLoading and AccountLoaded on successful fetch', () async {
      // Arrange
      final mockResult = QueryResult(
        source: QueryResultSource.network,
        options: QueryOptions(
          document: gql(QueryConstants.accountQuery), // Replace with your actual query
        ),
        data: {'accounts': []}, // Add your sample data here
      );
      // final client = GraphQLService.client;
      registerFallbackValue(QueryOptions(document: gql(QueryConstants.accountQuery), variables: {}));

      when(() => mockClient.query(any())).thenAnswer((_) async => mockResult);

      // Act
      accountBloc.fetchData();

      // Assert
      await expectLater(
        accountBloc.stream,
        emitsInOrder([isA<AccountLoading>(), isA<AccountLoaded>()]),
      );
    });

    test('emits AccountLoading and AccountError on fetch failure', () async {
      registerFallbackValue(QueryOptions(document: gql(QueryConstants.accountQuery), variables: {}));
      // Arrange
      when(() => mockClient.query(any())).thenThrow(Exception('Failed'));

      // Act
      accountBloc.fetchData();

      // Assert
      await expectLater(
        accountBloc.stream,
        emitsInOrder([isA<AccountLoading>(), isA<AccountError>()]),
      );
    });
  });

  group('Home Screen', () {
    testWidgets('Renders loading state', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MaterialApp(
        home: Home(),
      ));

      // Verify the loading state is displayed.
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    // Add more test cases for Home Screen as needed
  });

  group('Services Screen', () {
    testWidgets('Renders buttons', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MaterialApp(
        home: Services(),
      ));

      // Verify the presence of 'Loans' button.
      expect(find.text('Loans'), findsOneWidget);

      // Verify the presence of 'Statements' button.
      expect(find.text('Statements'), findsOneWidget);

      // Verify the presence of 'Contacts' button.
      expect(find.text('Contacts'), findsOneWidget);
    });

    // Add more test cases for Services Screen as needed
  });
}

class MockGraphQLClient extends Mock implements GraphQLClient {}