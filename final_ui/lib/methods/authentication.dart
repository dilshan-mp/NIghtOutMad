import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String district,
  }) async {
    String res = "Some error Occurred";
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(cred.user!.uid);

      // Storing user data in Firestore
      await _firestore.collection('users').doc(cred.user!.uid).set({
        'username': username,
        'district': district,
        'uid': cred.user!.uid,
        'email': email,
      });

      res = "Success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
