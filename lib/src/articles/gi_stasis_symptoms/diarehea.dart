// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Define the StatefulWidget
class DiareheaPage extends StatefulWidget {
  const DiareheaPage({super.key});

  @override
  State<DiareheaPage> createState() => DiareheaPageState();
}

// Define the State for the StatefulWidget
class DiareheaPageState extends State<DiareheaPage> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: const ColorScheme.light(
          background: Color.fromARGB(
              255, 255, 255, 255), // Replace with your RGB values
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 26, 71, 27),
          title: const Text('Diarrhea'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            // Title
            Text(
              ' Multiple Examples of Diarrhea',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Images
            Image(
              image: AssetImage(
                  'lib/assets/images/articles_images/blurred-caca-1.png'),
            ),
            Image(
              image: AssetImage(
                  'lib/assets/images/articles_images/blurred-caca-2.png'),
            ),
            // More info title
            Text(
              'More Info on Diahrrea',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // More info content
            Text(
              'Diarrhea is often seen in rabbits, and it can be life threatening if not managed properly...',
              style: TextStyle(fontSize: 18, height: 1.5),
            ),
            // Comments section
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Articles')
                  .doc('diarehea')
                  .collection('comments')
                  .orderBy('time_stamp_of_comment', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return Column(
                  children: List.generate(
                    snapshot.data?.docs.length ?? 0,
                    (index) {
                      DocumentSnapshot comment = snapshot.data!.docs[index];
                      return ListTile(
                        title: Text(comment['username']),
                        subtitle: Text(comment['comment_text']),
                      );
                    },
                  ),
                );
              },
            ),
            // Comment input field

            TextField(
              controller: _commentController,
              decoration:
                  const InputDecoration(labelText: 'Enter your comment'),
            ),
            // Submit button
            ElevatedButton(
              onPressed: () async {
                User? currentUser = FirebaseAuth.instance.currentUser;
                String? userId = currentUser?.uid;

                DocumentSnapshot userDoc = await FirebaseFirestore.instance
                    .collection('Users')
                    .doc(userId)
                    .get();
                String? username = userDoc['username'];

                await FirebaseFirestore.instance
                    .collection('Articles')
                    .doc('diarehea')
                    .collection('comments')
                    .add({
                  'username': username,
                  'userId': userId,
                  'comment_text': _commentController.text,
                  'time_stamp_of_comment': Timestamp.now(),
                });
                _commentController.clear();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 26, 71, 27),
                ),
              ),
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
             
            ),
          ],
        ),
      ),
    );
  }
}
