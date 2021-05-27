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
    String city,
  ) async {
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

  Future deleteAccount() async {
    try {
      await _firebaseAuth.currentUser.delete();
      await FirebaseFirestore.instance
          .collection("user")
          .doc(_firebaseAuth.currentUser.uid)
          .delete();
      await FirebaseStorage.instance
          .ref(_firebaseAuth.currentUser.uid)
          .delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == "requires-recent-login") {
        return "For changing the password your account needs to be logged in recently. Please re-login!";
      } else {
        return "Unidentified error!";
      }
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

  Future verifyPhoneNumber(
    String phoneNumber,
    BuildContext context,
    TextEditingController textEditingController,
  ) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential phoneCred) {},
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int resendToken) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Phone Verification"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  textEditingController: textEditingController,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.number,
                  hintText: "6-Digit Code",
                  icon: Icons.phone,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  String code = textEditingController.text.trim();

                  PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: code,
                  );
                },
                child: Text("Confirm"),
              ),
            ],
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      timeout: Duration(seconds: 60),
    );
  }
}
