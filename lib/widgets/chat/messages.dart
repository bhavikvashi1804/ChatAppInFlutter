import 'dart:html';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            return Text(snapshot.data.documents[index]['text']);
          },
          itemCount: snapshot.data.documents.length,
        );
      },
    );
  }
}
