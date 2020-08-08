import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            onChanged: (value) {
              if (value == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout'),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
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
