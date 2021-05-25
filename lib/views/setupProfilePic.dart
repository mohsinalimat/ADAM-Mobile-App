import 'dart:io';

import 'package:adam/constants.dart';
import 'package:adam/views/homeView.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SetupProfilePic extends StatefulWidget {
  @override
  _SetupProfilePicState createState() => _SetupProfilePicState();
}

class _SetupProfilePicState extends State<SetupProfilePic> {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final imgPicker = ImagePicker();
  File image;
  String photoUrl = "";

  bool _photoSet = false;

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
        setState(() {
          _photoSet = true;
        });
      });

      photoUrl = await firebaseStorage
          .ref("${_firebaseAuth.currentUser.uid}/dp")
          .getDownloadURL()
          .whenComplete(() => print("URL UPLOADED AT: $photoUrl"));

      await _firebaseAuth.currentUser
          .updateProfile(photoURL: photoUrl)
          .whenComplete(() => print("PHOTO URL SET FOR THE CURRENT USER"));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
              ),
              LogoDisplay(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Text(
                "Upload Profile Photo",
                style: TextStyle(
                  color: kPrimaryBlueColor,
                  fontSize: 24.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              CircleAvatar(
                radius: 70.0,
                backgroundColor: kLightGreenColor,
                child: CircleAvatar(
                  radius: 68,
                  backgroundColor: Colors.white,
                  child: _photoSet
                      ? CircleAvatar(
                          radius: 65.0,
                          backgroundImage: NetworkImage(
                            photoUrl,
                          ),
                        )
                      : CircleAvatar(
                          radius: 65.0,
                          backgroundImage: AssetImage('assets/dp.png'),
                        ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              CustomButton(
                btnWidth: 200.0,
                btnHeight: 40.0,
                btnOnPressed: () {
                  uploadPic();
                },
                btnColor: kPrimaryBlueColor,
                btnText: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                      size: 20.0,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      _photoSet ? "Upload Again" : "Uplaod Photo",
                      style: kBtnTextStyle,
                    ),
                  ],
                ),
              ),
              _photoSet
                  ? TextButton(
                      onPressed: () {
                        print("URL: $photoUrl");
                      },
                      child: Text("Next"),
                    )
                  : TextButton(
                      onPressed: () {},
                      child: Text("Skip"),
                    )
            ],
          ),
        )),
      ),
    );
  }
}
