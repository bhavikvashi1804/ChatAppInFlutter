import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import './message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, ss) {
          if (ss.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder(
              stream: Firestore.instance
                  .collection('chat')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  reverse: true,
                  itemBuilder: (context, index) {
                    return MessageBubble(
                      snapshot.data.documents[index]['text'],
                      snapshot.data.documents[index]['userId'] == ss.data.uid,
                      snapshot.data.documents[index]['username'],
                      key: ValueKey(snapshot.data.documents[index].documentID),
                    );
                  },
                  itemCount: snapshot.data.documents.length,
                );
              });
        });
  }
}
