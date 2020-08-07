import 'package:flutter/material.dart';

import './screens/chat_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      home: ChatScreen(),
    );
  }
}
