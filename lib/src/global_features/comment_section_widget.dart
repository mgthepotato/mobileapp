import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CommentSection extends StatefulWidget {
  final String articleId;

  const CommentSection({super.key, required this.articleId});

  @override
  CommentSectionState createState() => CommentSectionState();
}

class CommentSectionState extends State<CommentSection> {
  final _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Articles')
                .doc(widget.articleId)
                .collection('comments')
                .orderBy('time_stamp_of_comment', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              return ListView.builder(
                itemCount: snapshot.data?.docs.length ?? 0,
                itemBuilder: (context, index) {
                  DocumentSnapshot comment = snapshot.data!.docs[index];

                  return ListTile(
                    title: Text(comment['username']),
                    subtitle: Text(comment['comment_text']),
                  );
                },
              );
            },
          ),
        ),
        TextField(
          controller: _commentController,
          decoration: const InputDecoration(labelText: 'Enter your comment'),
        ),
        ElevatedButton(
          onPressed: () async {
            User? currentUser = FirebaseAuth.instance.currentUser;
            String? userId = currentUser?.uid;
            String? profilePicture;

            if (currentUser != null) {
              DocumentSnapshot userDoc = await FirebaseFirestore.instance
                  .collection('Users')
                  .doc(currentUser.uid)
                  .get();
             // username = userDoc['username'];
              profilePicture = userDoc['profile'];
            }
            //gets username from database and puts into a variable to check in conditional
            String? username = currentUser != null
                ? await FirebaseFirestore.instance
                    .collection('Users')
                    .doc(currentUser.uid)
                    .get()
                    .then((doc) => doc['username'])
                : null;

            if (userId != null && username != null) {
              await FirebaseFirestore.instance
                  .collection('Articles')
                  .doc(widget.articleId)
                  .collection('comments')
                  .add({
                'username': username,
                'userId': userId,
                'comment_text': _commentController.text,
                'time_stamp_of_comment': Timestamp.now(),
                'profile_picture':
                    profilePicture, // add profile picture to the comment
              });
              _commentController.clear();
            } else {
              // Handle the case where the user is not logged in or the username is not available
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
