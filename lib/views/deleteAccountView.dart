import 'package:adam/auth/auth.dart';
import 'package:adam/constants.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:adam/widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeleteAccountView extends StatefulWidget {
  @override
  _DeleteAccountViewState createState() => _DeleteAccountViewState();
}

class _DeleteAccountViewState extends State<DeleteAccountView> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = Auth();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
            child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: BackButton(
                    color: Colors.red[700],
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                SvgPicture.asset(
                  'assets/delete.svg',
                  height: 100.0,
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Text(
                  "Delete Account!",
                  style: TextStyle(
                    color: Colors.red[700],
                    fontWeight: FontWeight.bold,
                    // fontSize: height * 0.04,
                    fontSize: 28.0,
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  "Enter your password for verfication purposes!",
                  style: TextStyle(
                    color: Colors.red[700],
                  ),
                ),
                SizedBox(height: height * 0.1),
                CustomTextField(
                  textEditingController: _passwordController,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.text,
                  hintText: "Enter Password",
                  icon: Icons.lock,
                  iconColor: Colors.red[700],
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                CustomButton(
                  btnWidth: width * 0.5,
                  btnHeight: 40.0,
                  btnOnPressed: () {},
                  btnColor: Colors.red[700],
                  btnText: Text(
                    "Confirm Password",
                    style: kBtnTextStyle,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  "* This process cannot be undon. All your data will be lost!",
                  style: TextStyle(color: Colors.red[700], fontSize: 12.0),
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
