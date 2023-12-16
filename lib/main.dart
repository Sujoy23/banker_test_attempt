import 'package:banker_test_attempt/router/app_router.dart';
import 'package:banker_test_attempt/screens/accounts.dart';
import 'package:banker_test_attempt/screens/home.dart';
import 'package:banker_test_attempt/screens/services.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    GoRouter router = AppRouter().router;
    return MaterialApp.router(
      title: 'Banking Demo',
      debugShowCheckedModeBanner: false,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(),
    );
  }
}


