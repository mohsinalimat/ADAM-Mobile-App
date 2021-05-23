import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future signUp(
    String fullName,
    String email,
    String password,
    String phoneNumber,
    String dob,
    String gender,
    String country,
    String city,
  ) async {
    try {
      User user = (await _firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;

      if (user == null) {
        return null;
      }

      firebaseFirestore.collection('user').doc(user.uid).set({
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "dob": dob,
        "gender": gender,
        "country": country,
        "city": city,
      });

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "Email already in use, Try with different Email";
      } else if (e.code == "account-exists-with-different-credential") {
        return "Account already logged in";
      } else if (e.code == "weak-password") {
        return "Password must be more than 6 characters";
      } else {
        return "Unidentified Error, Try again!";
      }
    }
  }

  Future login(String email, String password) async {
    try {
      User user = (await _firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user == null) {
        return null;
      }
      print("User login: " + user.email);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "Account does not exists!";
      } else if (e.code == "wrong-password") {
        return "Invalid Password!";
      } else {
        return "Unidentified Error, Try again!";
      }
    }
  }

  Future forgotPassword(String email) async {
    try {
      if (email.isEmpty) return "Email cannot be empty!";
      await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
    } catch (e) {
      if (e.code == "user-not-found") {
        return "Email does not exists!";
      }
      return null;
    }
  }
}
