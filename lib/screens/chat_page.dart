import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection("chats/hAmBUARcwTktBy02yVNz/messages")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final documents = snapshot.data.documents;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.all(8.0),
                child: Text(documents[index]['text']),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Firestore.instance
              .collection("chats/hAmBUARcwTktBy02yVNz/messages")
              .add({
            'text': 'This is new message',
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
