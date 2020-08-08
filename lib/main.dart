import 'package:flutter/material.dart';

import './screens/chat_page.dart';
import './screens/auth_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      theme: ThemeData(
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        primarySwatch: Colors.pink,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
      home: AuthScreen(),
    );
  }
}
