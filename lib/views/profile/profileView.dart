import 'dart:convert';
import 'dart:io';

import 'package:adam/auth/userAuth.dart';
import 'package:adam/constants.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/model/userData.dart';
import 'package:adam/views/profile/editProfileView.dart';
import 'package:adam/views/profile/verificationBadges.dart';
import 'package:adam/widgets/customLoader.dart';
import 'package:adam/widgets/profileInfoWidget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _userAuth = UserAuth();
  // final _firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  // FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

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

  // getting user data from local storege
  UserData userData;
  void _getUserDataLocally() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String stringfyJson = pref.getString("userData");
    Map userDataObject = jsonDecode(stringfyJson);

    setState(() {
      userData = UserData.fromJSON(userDataObject);
    });
  }

  @override
  void initState() {
    _getUserDataLocally();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    final _themeProvider = Provider.of<ThemeProvider>(context);
    return AbsorbPointer(
      absorbing: _uploading,
      child: userData == null
          ? CustomLoader()
          : Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 10.0),
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
                                  backgroundImage: userData.photo == " "
                                      ? AssetImage('assets/dp.png')
                                      : NetworkImage(userData.photo),
                                  // backgroundImage:
                                  //     _firebaseAuth.currentUser.photoURL == " "
                                  //         ? AssetImage('assets/dp.png')
                                  //         : NetworkImage(
                                  //             _firebaseAuth.currentUser.photoURL),
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
                      const SizedBox(height: 10.0),
                      Center(
                        child: Text(userData.fullName,
                            style: _textTheme.headline6),
                      ),
                      const SizedBox(height: 15.0),
                      SizedBox(
                        height: 42.0,
                        child: ElevatedButton(
                            onPressed: () async {
                              var value = await Navigator.push(
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
                                    // user: _firebaseAuth.currentUser,
                                    userData: userData,
                                    refreshCallBack: callBack,
                                  ),
                                ),
                              );
                              if (value == null) value = false;
                              if (value) {
                                _getUserDataLocally();
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 8.0),
                                const Text("Edit Profile",
                                    style: kBtnTextStyle),
                              ],
                            )),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: ProfileInfoWidget(
                              icon: Icons.email,
                              info: userData.email,
                              infoTitle: "Email",
                            ),
                          ),
                          VerificationBadge(isEmailType: true),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: ProfileInfoWidget(
                              icon: Icons.phone,
                              info: userData.phoneNumber,
                              infoTitle: "Phone",
                            ),
                          ),
                          userData.isPhoneVerified
                              ? VerificationBadge(isEmailType: false)
                              : PhoneNotVerified(
                                  phoneNumber: userData.phoneNumber,
                                )
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ProfileInfoWidget(
                        icon: Icons.person,
                        info: userData.gender,
                        infoTitle: "Gender",
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ProfileInfoWidget(
                        icon: Icons.date_range,
                        info: userData.dob,
                        infoTitle: "Date of Birth",
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ProfileInfoWidget(
                        icon: Icons.location_city,
                        info: "${userData.city}, ${userData.country}",
                        infoTitle: "Address",
                      ),
                    ],
                  ),
                ),
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String _userId = prefs.getString('userId');

      setState(() {
        photoUrl = " ";
        _uploading = true;
      });

      Navigator.pop(context);

      // await FirebaseAuth.instance.currentUser.updateProfile(photoURL: " ");
      // await FirebaseAuth.instance.currentUser.reload();
      await firebaseStorage.ref(_userId).child("dp").delete();
      int result = await _userAuth.updateProfilePic(photoUrl).whenComplete(() {
        setState(() {
          _uploading = false;
        });
        _getUserDataLocally();
      });

      if (result == 200) {
        var snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Row(
            children: [
              const Icon(Icons.person, color: Colors.white),
              const SizedBox(width: 8.0),
              const Text(
                "Picture Removed Successful!",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        var snackBar = SnackBar(
          backgroundColor: Colors.blue,
          content: Row(
            children: [
              const Icon(Icons.info, color: Colors.white),
              const SizedBox(width: 8.0),
              const Text(
                "Error! Try again later.",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } on FirebaseException catch (e) {
      print(e.code);
    }
  }

  void _takePic() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String _userId = prefs.getString('userId');

      setState(() {
        _uploading = true;
      });

      // picking Image from Camera
      final file = await imgPicker.getImage(
        source: ImageSource.camera,
      );

      if (file != null) {
        image = File(file.path);
        
      // creating ref at Firebase Storage with userID
      Reference ref = firebaseStorage.ref(_userId).child("dp");

      ref.putFile(image).whenComplete(() {
        print("Pic Uploaded Successfully!");
        setState(() {
          _uploading = false;
        });
        // refreshing the UI when photo updated
        _getUploadedPic();
      });
      } else {
        setState(() {
          _uploading = false;
        });
      }

      Navigator.pop(context);

    } on FirebaseException catch (e) {
      print(e);
    }
  }

  void _uploadPic() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String _userId = prefs.getString('userId');

      setState(() {
        _uploading = true;
      });

      // picking Image from local storage
      final file = await imgPicker.getImage(
        source: ImageSource.gallery,
      );

      if (file != null) {
        image = File(file.path);
        // creating ref at Firebase Storage with userID
        Reference ref = firebaseStorage.ref(_userId).child("dp");

        ref.putFile(image).whenComplete(() {
          print("Pic Uploaded Successfully!");
          setState(() {
            _uploading = false;
          });
          // refreshing the UI when photo updated
          _getUploadedPic();
        });
      } else {
        setState(() {
          _uploading = false;
        });
      }

      Navigator.pop(context);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  void _getUploadedPic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _userId = prefs.getString('userId');

    // getting dp URL link
    photoUrl = await firebaseStorage
        .ref("$_userId/dp")
        .getDownloadURL()
        .whenComplete(() {
      setState(() {
        print("URL FIREBASE AT: $photoUrl");
      });
    });

    int result = await _userAuth.updateProfilePic(photoUrl).whenComplete(() {
      setState(() {
        _getUserDataLocally();
      });
    });

    if (result == 200) {
      var snackBar = SnackBar(
        backgroundColor: Colors.green,
        content: Row(
          children: [
            const Icon(Icons.person, color: Colors.white),
            const SizedBox(width: 8.0),
            const Text(
              "Picture Uploaded Successful!",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      var snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Row(
          children: [
            const Icon(Icons.info, color: Colors.white),
            const SizedBox(width: 8.0),
            const Text(
              "Error! Try again later.",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
