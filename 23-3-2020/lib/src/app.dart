import 'package:flutter/material.dart';
import 'screens/login_screens.dart';
import 'bloc/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Loged Me In',
        home: Scaffold(
          body: LoginScreen(),
        ),
      ),
    );
  }
}
