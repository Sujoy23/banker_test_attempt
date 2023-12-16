import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/contact_bloc.dart';
import '../bloc/contact_state.dart';
import '../graphql_api/graphql_service.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactBloc(client: GraphQLService.client),
      child: _ContactScreenState(),
    );
  }

}

class _ContactScreenState extends StatefulWidget {
  @override
  __ContactScreenState createState() => __ContactScreenState();
}

class __ContactScreenState extends State<_ContactScreenState> {
  int selectedYear = 2023; // Initial year

  @override
  Widget build(BuildContext context) {
    context.read<ContactBloc>().fetchData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Statements'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ContactBloc, ContactState>(
              builder: (context, state) {
                if (state is ContactLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ContactLoaded) {
                  final data = state.data;// Use the filtered statements
                  // final error  = state.errors;
                  if (data['contacts'] == null) {
                    return Center(child: Text("No Data",
                      textAlign: TextAlign.center,
                    ),);
                  } else {
                    return ListView.builder(
                      itemCount: data['contacts'].length,
                      itemBuilder: (context, index) {
                        final contacts = data['contacts'][index];
                        return ListTile(
                          title: Text('Data: ${contacts ?? ""}'),
                        );
                      },
                    );
                  }
                } else if (state is ContactError) {
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
}