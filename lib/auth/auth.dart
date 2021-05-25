import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    String city,
  ) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      User user = (await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;

      if (user == null) {
        return null;
      }
      pref.setString("userId", user.uid);
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
      SharedPreferences pref = await SharedPreferences.getInstance();
      User user = (await _firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user == null) {
        return null;
      }
      pref.setString("userId: ", user.uid);
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

  Future updateUserProfile(
      User user, String userName, Map<String, Object> data) async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(user.uid)
        .update(data);
    await user.updateProfile(displayName: userName);
    // await updateEmail(data["newEmail"], user);
  }

  updateEmail(String updatedEmail, User user) async {
    try {
      await user.updateEmail(updatedEmail);
      AuthCredential credential = EmailAuthProvider.credential(
        email: updatedEmail,
        password: "Hamza@6",
      );
      await user
          .reauthenticateWithCredential(credential)
          .then((value) => print("Updated email"))
          .catchError((err) => print(err));
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        return "Invalid email!";
      } else if (e.code == "email-already-in-use") {
        return "Email already in use";
      }
      return null;
    }
  }

  Future forgotPassword(String email) async {
    try {
      if (email.isEmpty) return "Email cannot be empty!";
      await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
    } catch (e) {
      if (e.code == "user-not-found") {
        return "Account does not exists with this email!";
      }
      return null;
    }
  }
}
