import 'dart:io';

import 'package:adam/constants.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/views/profile/editProfileView.dart';
import 'package:adam/views/profile/verificationBadges.dart';
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

  // Profile Photo Buttons properties
  final _dpBtnColors = [Colors.red, Colors.purple, Colors.green];
  final _dpBtnIcons = [
    Icons.delete_rounded,
    Icons.photo_rounded,
    Icons.camera_alt_rounded
  ];
  final _dpBtnText = ["Remove", "Gallery", "Camera"];

  // Image Picker --> DP properties
  final imgPicker = ImagePicker();
  File image;
  String photoUrl = "";
  bool _uploading = false;

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
                                          " "
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
                                onPressed: _updateProfilePic,
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
                          VerificationBadge(isEmailType: true),
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
                              ? VerificationBadge(isEmailType: false)
                              : PhoneNotVerified(
                                  phoneNumber: snapshot.data['phoneNumber'])
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
            } else {
              return Center(
                child: Text("Network error!"),
              );
            }
          },
        ),
      ),
    );
  }

  void _updateProfilePic() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(360.0)),
              height: 7.0,
              width: 50.0,
            ),
            const SizedBox(height: 20.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                " Profile photo",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            const SizedBox(height: 15.0),
            Row(
                children: List.generate(
              3,
              (index) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MaterialButton(
                    color: _dpBtnColors.map((e) => e).elementAt(index),
                    shape: CircleBorder(),
                    onPressed: index == 0
                        ? () => _removePic()
                        : index == 1
                            ? () => _uploadPic()
                            : () => _takePic(),
                    child: Icon(
                      _dpBtnIcons.map((e) => e).elementAt(index),
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    _dpBtnText.map((e) => e).elementAt(index),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  void _removePic() async {
    try {
      Navigator.pop(context);

      await FirebaseAuth.instance.currentUser.updateProfile(photoURL: " ");
      await FirebaseAuth.instance.currentUser.reload();

      setState(() {});

      firebaseStorage.ref(_firebaseAuth.currentUser.uid).child("dp").delete();
    } on FirebaseException catch (e) {
      print(e.code);
    }
  }

  void _takePic() async {
    try {
      setState(() {
        _uploading = true;
      });

      // picking Image from Camera
      final file = await imgPicker.getImage(
        source: ImageSource.camera,
      );

      if (file != null) {
        image = File(file.path);
      } else {
        setState(() {
          _uploading = false;
        });
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
        _getUploadedPic();
      });
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  void _uploadPic() async {
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
      } else {
        setState(() {
          _uploading = false;
        });
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
        _getUploadedPic();
      });
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  void _getUploadedPic() async {
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
}
