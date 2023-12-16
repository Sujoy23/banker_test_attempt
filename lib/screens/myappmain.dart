import 'package:flutter/material.dart';

import 'accounts.dart';
import 'home.dart';
import 'services.dart';

class MyAppMain extends StatelessWidget {
  const MyAppMain({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const Home(),
    const Accounts(),
    const Services(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Banking Demo',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
              color: _currentIndex == 0 ? Colors.indigo : Colors.blue,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance,
              color: _currentIndex == 1 ? Colors.indigo : Colors.blue,
            ),
            label: 'Accounts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business,
              color: _currentIndex == 2 ? Colors.indigo : Colors.blue,
            ),
            label: 'Services',
          ),
        ],
      ),
    );
  }
}