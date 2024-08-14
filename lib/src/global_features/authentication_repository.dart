// auth_service.dart 
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //final FirebaseAuth _auth = FirebaseAuth.instance; // Using a singleton for simplicity

  Future<void> registerUser(String email, String password) async {
 try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  } on FirebaseAuthException catch (e) {
    // Handle errors (weak password, email in use, etc.)
    // Example:
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e); // For other errors 
  }  }
/*
  Future<void> signInUser(String email, String password) async {


  }
*/
  // ... other authentication methods
}
