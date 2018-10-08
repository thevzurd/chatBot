import 'package:flutter/material.dart';
import 'screens/chat_screen.dart';


class App extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(
      home: ChatScreen(),
      theme: ThemeData(
          primarySwatch: Colors.blue,
      ),
    );
  }
}


