import 'package:banker_test_attempt/bloc/statement_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/statement_state.dart';
import '../graphql_api/graphql_service.dart';
import '../models/statement_response.dart';
import '../router/screen_router_constants.dart';

class Statements extends StatelessWidget {

  const Statements({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatementBloc(client: GraphQLService.client),
      child: _StatementsScreenState(),
    );
  }
}

class _StatementsScreenState extends StatefulWidget {
  @override
  __StatementsScreenState createState() => __StatementsScreenState();
}

class __StatementsScreenState extends State<_StatementsScreenState> {
  int selectedYear = 2023; // Initial year

  @override
  Widget build(BuildContext context) {
    context.read<StatementBloc>().fetchData();
    List<UserStatements> statements = [];
    return Scaffold(
      appBar: AppBar(
        title: Text('Statements'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          DropdownButton<int>(
            value: selectedYear,
            onChanged: (int? value) {
              setState(() {
                selectedYear = value!;
                // Handle statement filtering based on the selected year
              });
            },
            items: [2023, 2022, 2021, 2020, 2019].map((int year) {
              return DropdownMenuItem<int>(
                value: year,
                child: Text(year.toString()),
              );
            }).toList(),
          ),
          Expanded(
            child: BlocBuilder<StatementBloc, StatementState>(
              builder: (context, state) {
                if (state is StatementLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is StatementLoaded) {
                  final data = state.data;
                  int statementSize = data['statements']?.length ?? 0;
                  for (int i=0; i< statementSize; i++) {
                    if (data['statements'][i]['date'].toString().contains(selectedYear.toString())) {
                      statements.add(
                          UserStatements(
                            date: data['statements'][i]['date'].toString(),
                            description: data['statements'][i]['description']
                                .toString(),
                            amount: (data['statements'][i]['amount'] as num?)
                                ?.toDouble() ?? 0.0,
                          )
                      );
                    }
                  } // Use the filtered statements

                  if (statements.isEmpty) {
                    return Center(child: Text("No Statement for the selected year",
                      textAlign: TextAlign.center,
                    ),);
                  } else {
                    return ListView.builder(
                      itemCount: statements.length,
                      itemBuilder: (context, index) {
                        final statement = statements[index];
                        return ListTile(
                          title: Text('Date: ${statement.date ?? ""}'),
                          subtitle: Text('Description: ${statement.description ?? ""}, Amount: ${statement.amount ?? ""}'),
                          onTap: () {
                            // Handle statement tap, navigate to PDF viewer screen
                            navigateToPdfViewer(context);
                          },
                        );
                      },
                    );
                  }
                } else if (state is StatementError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else {
                  return Center(child: Text('Initial State'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void navigateToPdfViewer(BuildContext context) {
    // Use GoRouter to navigate to the PdfViewerScreen
    GoRouter.of(context).pushNamed(ScreenRouteConstants.pdfViewerScreenRouteName);
  }
}