import 'package:adam/database/databaseService.dart';
import 'package:adam/views/profile/phoneVerificationView.dart';
import 'package:adam/widgets/customTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      String city) async {
    try {
      User user = (await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;

      if (user == null) {
        return null;
      }
      await user.updateProfile(
        displayName: fullName,
      );

      firebaseFirestore.collection('user').doc(user.uid).set({
        "phoneNumber": phoneNumber,
        "dob": dob,
        "gender": gender,
        "country": country,
        "city": city,
      });

      if (!user.emailVerified) {
        await user.sendEmailVerification();
        print("EMAIL VERIFICATION SENT!");
      }

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "Email already in use, Try with different Email";
      } else if (e.code == "invalid-email") {
        return "Invalid email!";
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
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "Account does not exists!";
      } else if (e.code == "wrong-password") {
        return "Invalid Password!";
      } else if (e.code == "too-many-requests") {
        return "Too many requests. Please wait!";
      } else {
        return "Unidentified Error, Try again!";
      }
    }
  }

  Future updateData(
      User user, String newUserName, Map<String, Object> updatedInfo) async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(user.uid)
        .update(updatedInfo);
    await user.updateProfile(
      displayName: newUserName,
    );
  }

  Future updateEmail(
      User user, String updatedEmail, String userPassword) async {
    try {
      EmailAuthCredential credential = EmailAuthProvider.credential(
        email: user.email,
        password: userPassword,
      );

      await user.reauthenticateWithCredential(credential);

      await user.updateEmail(updatedEmail);
      await user.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        return "Invalid email!";
      } else if (e.code == "email-already-in-use") {
        return "Email already in use";
      } else if (e.code == "wrong-password") {
        return "Invalid Password";
      } else if (e.code == "requires-recent-login") {
        return "For updating the email your account needs to be logged in recently. Please re-login!";
      }
      return null;
    }
  }

  Future forgotPassword(String email) async {
    try {
      if (email.isEmpty) return "Email cannot be empty!";
      await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return "Account does not exists with this email!";
      }
      return null;
    }
  }

  Future changePassword(String newPassword) async {
    try {
      await _firebaseAuth.currentUser.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == "requires-recent-login") {
        return "For changing the password your account needs to be logged in recently. Please re-login!";
      } else {
        return "Unidentified error!";
      }
    }
  }

  Future deleteAccount(String email, String pass, String uid) async {
    try {
      EmailAuthCredential credential =
          EmailAuthProvider.credential(email: email, password: pass);
      print("AUTHENTICATION USER!");
      await _firebaseAuth.currentUser.reauthenticateWithCredential(credential);
      await DatabaseService(uid: uid).deleteUserData();
      await _firebaseAuth.currentUser.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == "requires-recent-login") {
        return "For changing the password your account needs to be logged in recently. Please re-login!";
      } else if (e.code == "user-mismatch") {
        return "Information missmatch!";
      } else if (e.code == "wrong-password") {
        return "Invalid Password!";
      } else {
        return "Unidentified error!";
      }
    }
  }
}
