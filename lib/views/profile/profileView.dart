import 'dart:io';

import 'package:adam/constants.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/views/profile/editProfileView.dart';
import 'package:adam/views/profile/phoneVerificationView.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:adam/widgets/customLoader.dart';
import 'package:adam/widgets/profileInfoWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final imgPicker = ImagePicker();
  File image;
  String photoUrl = "";
  bool _uploading = false;

  uploadPic() async {
    try {
      setState(() {
        _uploading = true;
      });

      // picking Image from local storage
      final file = await imgPicker.getImage(
        source: ImageSource.gallery,
      );

      if (file != null) {
        image = File(file.path);
      }

      // creating ref at Firebase Storage with userID
      Reference ref =
          firebaseStorage.ref(_firebaseAuth.currentUser.uid).child("dp");

      ref.putFile(image).whenComplete(() {
        print("Pic Uploaded Successfully!");
        setState(() {
          _uploading = false;
        });
        // refreshing the UI when photo updated
        getUploadedPic();
      });
    } catch (e) {
      print(e);
    }
  }

  getUploadedPic() async {
    // getting dp URL link
    photoUrl = await firebaseStorage
        .ref("${_firebaseAuth.currentUser.uid}/dp")
        .getDownloadURL()
        .whenComplete(() => print("URL UPLOADED AT: $photoUrl"));

    // updating user profile photo at Firebase
    await _firebaseAuth.currentUser
        .updateProfile(
      photoURL: photoUrl,
    )
        .whenComplete(() {
      print("PHOTO URL SET FOR THE CURRENT USER $photoUrl");
      setState(() {});
    });
  }

  // callBack to refresh the screen after updating the data
  bool refreshProfile = false;
  callBack(boolVar) {
    setState(() {
      refreshProfile = boolVar;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    final _themeProvider = Provider.of<ThemeProvider>(context);
    return AbsorbPointer(
      absorbing: _uploading,
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text("Profile"),
        // ),
        body: StreamBuilder(
          stream: firebaseFirestore
              .collection('user')
              .doc(_firebaseAuth.currentUser.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            print(snapshot.hasData);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CustomLoader(),
              );
            } else if (snapshot.connectionState == ConnectionState.active &&
                snapshot.hasData) {
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LogoDisplay(),
                      SizedBox(
                        height: 25.0,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 90.0,
                              backgroundColor: _themeProvider.darkTheme
                                  ? kMediumGreenColor
                                  : kLightGreenColor,
                              child: CircleAvatar(
                                radius: 88,
                                backgroundColor: _themeProvider.darkTheme
                                    ? Colors.grey[800]
                                    : Colors.white,
                                child: CircleAvatar(
                                  radius: 85.0,
                                  backgroundImage: _firebaseAuth
                                              .currentUser.photoURL ==
                                          null
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
                                backgroundColor: _themeProvider.darkTheme
                                    ? Colors.grey[900]
                                    : Colors.white,
                                onPressed: () =>
                                    _uploading ? null : uploadPic(),
                                mini: true,
                                child: _uploading
                                    ? kLoader
                                    : Icon(
                                        Icons.camera_alt,
                                        color: _themeProvider.darkTheme
                                            ? Colors.white
                                            : kPrimaryBlueColor,
                                      ),
                              ),
                            )
                          ],
                        )),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(_firebaseAuth.currentUser.displayName,
                                style: _textTheme.headline6),
                            CustomEditBtn(
                              heroTag: "editBtn",
                              onBtnPress: () => Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 750),
                                  reverseTransitionDuration:
                                      Duration(milliseconds: 750),
                                  transitionsBuilder:
                                      (context, ani1, ani2, child) {
                                    return FadeTransition(
                                      child: child,
                                      opacity: ani1,
                                    );
                                  },
                                  pageBuilder: (context, a1, a2) =>
                                      EditProfileView(
                                    user: _firebaseAuth.currentUser,
                                    snapshot: snapshot.data,
                                    refreshCallBack: callBack,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
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
                                            Text(
                                              "Email Verification",
                                              style: TextStyle(
                                                fontSize: Theme.of(context)
                                                    .textTheme
                                                    .headline2
                                                    .fontSize,
                                                color:
                                                    Provider.of<ThemeProvider>(
                                                                context)
                                                            .darkTheme
                                                        ? Colors.white
                                                        : Colors.black,
                                              ),
                                            ),
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
                                            Text(
                                              "Email Verification",
                                              style: TextStyle(
                                                fontSize: Theme.of(context)
                                                    .textTheme
                                                    .headline2
                                                    .fontSize,
                                                color:
                                                    Provider.of<ThemeProvider>(
                                                                context)
                                                            .darkTheme
                                                        ? Colors.white
                                                        : Colors.black,
                                              ),
                                            ),
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
                                                builder: (context) =>
                                                    AlertDialog(
                                                  title: Row(
                                                    children: [
                                                      Icon(Icons.email),
                                                      SizedBox(
                                                        width: 8.0,
                                                      ),
                                                      Text(
                                                        "Email Sent!",
                                                        style: TextStyle(
                                                          fontSize:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline2
                                                                  .fontSize,
                                                          color: Provider.of<
                                                                          ThemeProvider>(
                                                                      context)
                                                                  .darkTheme
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  content: Text(
                                                      "Please re-login after verification of your new email."),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: ProfileInfoWidget(
                              icon: Icons.phone,
                              info: snapshot.data["phoneNumber"],
                              infoTitle: "Phone",
                            ),
                          ),
                          snapshot.data['phoneVerify']
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
                                            Text(
                                              "Phone Verification",
                                              style: TextStyle(
                                                fontSize: Theme.of(context)
                                                    .textTheme
                                                    .headline2
                                                    .fontSize,
                                                color:
                                                    Provider.of<ThemeProvider>(
                                                                context)
                                                            .darkTheme
                                                        ? Colors.white
                                                        : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        content: Text(
                                            "Congratulations!\nYour phone number is verified."),
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
                                            Text(
                                              "Phone Verification",
                                              style: TextStyle(
                                                fontSize: Theme.of(context)
                                                    .textTheme
                                                    .headline2
                                                    .fontSize,
                                                color:
                                                    Provider.of<ThemeProvider>(
                                                                context)
                                                            .darkTheme
                                                        ? Colors.white
                                                        : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        content: Text(
                                            "Opss!\nYour phone is not verified!"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      PhoneVerificationView(
                                                    phoneNumber: snapshot
                                                        .data['phoneNumber'],
                                                  ),
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
                                )
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
                    ],
                  ),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: Text("Something went wrong!"),
              );
            } else {
              return Center(
                child: Text("Check internet please!"),
              );
            }
          },
        ),
      ),
    );
  }
}
