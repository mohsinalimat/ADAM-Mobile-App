import 'dart:io';

import 'package:adam/constants.dart';
import 'package:adam/views/editProfileView.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:adam/widgets/profileInfoWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final imgPicker = ImagePicker();
  File image;
  String photoUrl = "";
  bool _uploading = false;
  uploadPic() async {
    try {
      setState(() {
        _uploading = true;
      });
      final file = await imgPicker.getImage(
        source: ImageSource.gallery,
      );

      if (file != null) {
        image = File(file.path);
      }

      Reference ref =
          firebaseStorage.ref(_firebaseAuth.currentUser.uid).child("dp");

      ref.putFile(image).whenComplete(() {
        print("Pic Uploaded Successfully!");
        setState(() {
          _uploading = false;
        });
        getUploadedPic();
      });
    } catch (e) {
      print(e);
    }
  }

  getUploadedPic() async {
    photoUrl = await firebaseStorage
        .ref("${_firebaseAuth.currentUser.uid}/dp")
        .getDownloadURL()
        .whenComplete(() => print("URL UPLOADED AT: $photoUrl"));

    await _firebaseAuth.currentUser
        .updateProfile(
      photoURL: photoUrl,
    )
        .whenComplete(() {
      print("PHOTO URL SET FOR THE CURRENT USER $photoUrl");
      setState(() {});
    });
  }

  bool refreshProfile = false;
  callBack(boolVar) {
    setState(() {
      refreshProfile = boolVar;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('user')
            .doc(_firebaseAuth.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: LogoDisplay(),
                    // ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                          child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 70.0,
                            backgroundColor: kLightGreenColor,
                            child: CircleAvatar(
                              radius: 68,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 65.0,
                                backgroundImage:
                                    _firebaseAuth.currentUser.photoURL == null
                                        ? AssetImage('assets/dp.png')
                                        : NetworkImage(
                                            _firebaseAuth.currentUser.photoURL),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: FloatingActionButton(
                              heroTag: "profilePicBtn",
                              backgroundColor: Colors.white,
                              onPressed: () => _uploading ? null : uploadPic(),
                              mini: true,
                              child: _uploading
                                  ? kLoader
                                  : Icon(
                                      Icons.camera_alt,
                                      color: kPrimaryBlueColor,
                                    ),
                            ),
                          )
                        ],
                      )),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _firebaseAuth.currentUser.displayName,
                            style: TextStyle(
                                color: kPrimaryBlueColor,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5),
                          ),
                          FloatingActionButton(
                            heroTag: "editButton",
                            elevation: 2.0,
                            backgroundColor: Colors.white,
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditProfileView(
                                    user: _firebaseAuth.currentUser,
                                    snapshot: snapshot.data,
                                    refreshCallBack: callBack),
                              ),
                            ),
                            mini: true,
                            child: Icon(
                              Icons.edit,
                              color: kPrimaryBlueColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    ProfileInfoWidget(
                      icon: Icons.phone,
                      info: snapshot.data["phoneNumber"],
                      infoTitle: "Phone",
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: ProfileInfoWidget(
                            icon: Icons.email,
                            info: _firebaseAuth.currentUser.email,
                            infoTitle: "Email",
                          ),
                        ),
                        _firebaseAuth.currentUser.emailVerified
                            ? InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Row(
                                        children: [
                                          Icon(Icons.verified,
                                              color: kLightBlueColor),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          Text("Email Verification"),
                                        ],
                                      ),
                                      content: Text(
                                          "Congratulations!\nYour email is verified."),
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.verified,
                                  color: kLightBlueColor,
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Row(
                                        children: [
                                          Icon(Icons.verified,
                                              color: Colors.grey),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          Text("Email Verification"),
                                        ],
                                      ),
                                      content: Text(
                                          "Opss!\nYour email is not verified!"),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            await _firebaseAuth.currentUser
                                                .sendEmailVerification();
                                            Navigator.pop(context);
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text("Email Sent!"),
                                                content: Text(
                                                    "Please login again after verification :)"),
                                              ),
                                            );
                                          },
                                          child: Text("Verify Now!"),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.info,
                                  color: Colors.yellow[600],
                                ),
                              ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ProfileInfoWidget(
                      icon: Icons.person,
                      info: snapshot.data["gender"],
                      infoTitle: "Gender",
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ProfileInfoWidget(
                      icon: Icons.date_range,
                      info: snapshot.data["dob"],
                      infoTitle: "Date of Birth",
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ProfileInfoWidget(
                      icon: Icons.location_city,
                      info:
                          "${snapshot.data["city"]}, ${snapshot.data["country"]}",
                      infoTitle: "Address",
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ProfileInfoWidget(
                      icon: Icons.lock,
                      infoTitle: "Password",
                    ),
                    CustomButton(
                      btnWidth: 170,
                      btnHeight: 35,
                      btnOnPressed: () =>
                          Navigator.pushNamed(context, '/changePassword'),
                      btnColor: kLightGreenColor,
                      btnText: Text(
                        "Change Password",
                        style: kBtnTextStyle,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ProfileInfoWidget(
                      icon: Icons.person,
                      infoTitle: "Account",
                    ),
                    CustomButton(
                      btnWidth: 170,
                      btnHeight: 35,
                      btnOnPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Row(
                              children: [
                                Icon(
                                  Icons.info,
                                  color: Colors.red[900],
                                ),
                                SizedBox(width: 8.0),
                                Text("Delete Account!"),
                              ],
                            ),
                            content: Text(
                              "You are about to delete your account. Please note that this process is irreversible and all your data will be lost!\n\nDo you want to continue?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(
                                      context, "/deleteAccount");
                                },
                                child: Text(
                                  "Yes, I'm sure",
                                  style: TextStyle(color: Colors.red[900]),
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("No, Cancel it"),
                              ),
                            ],
                          ),
                        );
                      },
                      btnColor: Colors.red[700],
                      btnText: Text(
                        "Delete Account",
                        style: kBtnTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
