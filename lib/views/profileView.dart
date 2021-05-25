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

  uploadPic() async {
    try {
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
      });

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
    } catch (e) {
      print(e);
    }
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
                                backgroundImage: NetworkImage(
                                    FirebaseAuth.instance.currentUser.photoURL),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: FloatingActionButton(
                              heroTag: "profilePicBtn",
                              backgroundColor: Colors.white,
                              onPressed: () => uploadPic(),
                              mini: true,
                              child: Icon(
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
                    ProfileInfoWidget(
                      icon: Icons.email,
                      info: _firebaseAuth.currentUser.email,
                      infoTitle: "Email",
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
                      btnOnPressed: () {},
                      btnColor: kLightGreenColor,
                      btnText: Text(
                        "Change Password",
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
