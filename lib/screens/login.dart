import 'package:banker_test_attempt/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/screen_router_constants.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Welcome to Banking Demo App',
          style: TextStyle(
          fontSize: 25,
            color: Colors.white,
        ),
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/banking2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          // margin: const EdgeInsets.symmetric(
          //   horizontal: 20.0, // Set horizontal margin
          //   vertical: 200.0,   // Set vertical margin
          // ),

          height: 500,
          width: 370,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.8),
            borderRadius: BorderRadius.circular(15.0), // Set the radius here
          ),
          child: loginContent(),
        ),
      ),
    );
  }

}

class loginContent extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Please Login To Continue..',
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 50.0),
          TextField(
            controller: usernameController,
            decoration: const InputDecoration(labelText: 'Username',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white), // Set color of the underline border
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white), // Set color of the focused underline border
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Password',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white), // Set color of the underline border
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white), // Set color of the focused underline border
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: () {
              if (usernameController.text == 'Joe' &&
                  passwordController.text == 'abcd') {
                print('Logged In');
                try {
                  GoRouter.of(context).pushNamed(ScreenRouteConstants.myAppRouteName);
                } catch (e) {
                  print(e.toString());
                }
              } else {
                print('Invalid username or password');
              }
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
