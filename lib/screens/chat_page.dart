import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(8.0),
          child: Text("Hello Yash"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Firestore.instance
              .collection("chats/hAmBUARcwTktBy02yVNz/messages")
              .snapshots()
              .listen((event) {
            event.documents.forEach((element) {
              print(element['text']);
            });
          });
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
