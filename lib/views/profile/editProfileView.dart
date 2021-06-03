import 'package:adam/auth/auth.dart';
import 'package:adam/constants.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/validators/validators.dart';
import 'package:adam/views/profile/changeEmailView.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:adam/widgets/editableCustomTextField.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditProfileView extends StatefulWidget {
  final User user;
  final snapshot;
  final Function(bool) refreshCallBack;

  const EditProfileView({
    Key key,
    this.user,
    this.snapshot,
    this.refreshCallBack,
  }) : super(key: key);
  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _auth = Auth();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final dobController = TextEditingController();

  final format = DateFormat("dd-MM-yyyy");

  String _gender = "";
  String _country = "";
  String _city = "";

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  String _oldName = "";
  String _oldPhone = "";
  String _oldEmail = "";
  String _oldDob = "";

  void fetchingInfo() {
    _oldName = fullNameController.text = widget.user.displayName;
    _oldPhone = phoneNumberController.text = widget.snapshot["phoneNumber"];
    _oldDob = dobController.text = widget.snapshot['dob'];
    _oldEmail = emailController.text = widget.user.email;
    _gender = widget.snapshot["gender"];
    _city = widget.snapshot['city'];
    _country = widget.snapshot['country'];
  }

  bool _isDataUpdated() {
    if (_oldName != fullNameController.text.trim() ||
        _oldPhone != phoneNumberController.text.trim() ||
        _oldDob != dobController.text ||
        _oldEmail != emailController.text.trim()) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    fetchingInfo();
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final _themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AbsorbPointer(
        absorbing: _isLoading,
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            // elevation: 2.0,
                            // heroTag: "backBtn",
                            onPressed: () => Navigator.pop(context),
                            // backgroundColor: Colors.white,
                            icon: Icon(
                              Icons.arrow_back,
                              // color: kPrimaryBlueColor,
                              // size: 17.0,
                            ),
                          ),
                          Text(
                            "Edit Profile ",
                            style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                              // color: kPrimaryBlueColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 35.0,
                      ),
                      EditableCustomTextField(
                        labelText: "Full Name",
                        textEditingController: fullNameController,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.name,
                        icon: Icons.person,
                        validatorFtn: (value) {
                          if (value.isEmpty) {
                            return "Name cannot be empty!";
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      EditableCustomTextField(
                        labelText: "Email Address",
                        textEditingController: emailController,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.emailAddress,
                        icon: Icons.email,
                        validatorFtn: Validators.emailValidator,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      EditableCustomTextField(
                          labelText: "Phone Number",
                          textEditingController: phoneNumberController,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.phone,
                          icon: Icons.phone,
                          validatorFtn: Validators.phoneNumberValidator),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "Date of Birth",
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                      SizedBox(height: 10.0),
                      DateTimeField(
                        controller: dobController,
                        decoration: InputDecoration(
                          fillColor: _themeProvider.darkTheme
                              ? Colors.black12
                              : Colors.grey[100],
                          filled: true,
                          prefixIcon: Hero(
                            tag: Icons.date_range.toString(),
                            child: Icon(
                              Icons.date_range,
                              color: _themeProvider.darkTheme
                                  ? Colors.grey
                                  : kPrimaryBlueColor,
                            ),
                          ),
                          contentPadding: const EdgeInsets.all(5.0),
                          // hintStyle: kHintTextStyle,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        format: format,
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1980),
                            lastDate: DateTime(2100),
                          );
                        },
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "Gender",
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Male"),
                              Radio(
                                value: "Male",
                                groupValue: _gender,
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value;
                                  });
                                  print(_gender);
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Female"),
                              Radio(
                                value: "Female",
                                groupValue: _gender,
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value;
                                  });
                                  print(_gender);
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Custom"),
                              Radio(
                                value: "Custom",
                                groupValue: _gender,
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value;
                                  });
                                  print(_gender);
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                      Text(
                        "Address",
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: screenSize.width * 0.42,
                            height: 40.0,
                            // height: height * 0.055,
                            child: Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              elevation: 4.0,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    isExpanded: true,
                                    value: _country,
                                    items: ["Pakistan", "USA", "Canada"]
                                        .map(
                                          (e) => DropdownMenuItem(
                                            child: Text(e),
                                            value: e,
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _country = value;
                                      });
                                      print(_country);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.42,
                            // height: height * 0.055,
                            height: 40.0,
                            child: Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              elevation: 4.0,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    isExpanded: true,
                                    value: _city,
                                    items: ["Islamabad", "Lahore", "Karachi"]
                                        .map(
                                          (e) => DropdownMenuItem(
                                            child: Text(e),
                                            value: e,
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _city = value;
                                      });
                                      print(_city);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: CustomButton(
                          btnWidth: screenSize.width * 0.9,
                          btnHeight: 40.0,
                          btnOnPressed: () async {
                            if (_isDataUpdated()) {
                              if (_formKey.currentState.validate()) {
                                // data updated
                                Map<String, Object> newData = {
                                  "phoneNumber":
                                      phoneNumberController.text.trim(),
                                  "gender": _gender,
                                  "country": _country,
                                  "city": _city,
                                  "dob": dobController.text.trim(),
                                  "phoneVerify": _oldPhone !=
                                          phoneNumberController.text.trim()
                                      ? false
                                      : widget.snapshot['phoneVerify'],
                                };

                                // in case email is updated then move to password verification
                                if (_oldEmail != emailController.text.trim()) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ChangeEmailView(
                                        refreshEmailCallBack:
                                            widget.refreshCallBack,
                                        fullName:
                                            fullNameController.text.trim(),
                                        updatedData: newData,
                                        updatedEmail:
                                            emailController.text.trim(),
                                      ),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  var value = await _auth
                                      .updateData(
                                    widget.user,
                                    fullNameController.text.trim(),
                                    newData,
                                  )
                                      .whenComplete(() {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  });
                                  print("VALUE: $value");

                                  if (value is String) {
                                    var snackBar = SnackBar(
                                      content: Row(
                                        children: [
                                          Icon(
                                            Icons.info,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 8.0),
                                          Text(
                                            value,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      backgroundColor: Colors.red[900],
                                      behavior: SnackBarBehavior.floating,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    var snackBar = SnackBar(
                                      content: Row(
                                        children: [
                                          Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 8.0),
                                          Text(
                                            "Profile Updated!",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      backgroundColor: kSecondaryBlueColor,
                                      behavior: SnackBarBehavior.floating,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    Future.delayed(Duration(seconds: 3), () {
                                      Navigator.pop(context);
                                    });
                                    widget.refreshCallBack(true);
                                  }
                                }
                              }
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          btnColor: kLightGreenColor,
                          btnText: _isLoading
                              ? SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  "Save Profile",
                                  style: kBtnTextStyle,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
