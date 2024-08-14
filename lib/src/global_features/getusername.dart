import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Username {
  static Future<String?> getUsername() async {
    try {
      // Check if user is authenticated
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Retrieve user data directly using UID
        DocumentSnapshot<Map<String, dynamic>> userDataSnapshot =
            await FirebaseFirestore.instance
                .collection('Users')
                .doc(user.uid)
                .get();

        // Check if userDataSnapshot exists
        if (userDataSnapshot.exists) {
          // get username
          String? username = userDataSnapshot.get('username');
          return username;
        }
      }
      // when user is not authenticated
      return null;
    } catch (e) {
      // takes care of errors
      print("Error getting username: $e");
      return null;
    }
  }
}
