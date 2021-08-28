import 'package:adam/constants.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:adam/widgets/customTextField.dart';
import 'package:adam/widgets/logoDisplay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InstagramView extends StatefulWidget {
  @override
  _InstagramViewState createState() => _InstagramViewState();
}

class _InstagramViewState extends State<InstagramView> {
  bool _dataScraped = false;
  bool _isWorking = false;
  final _targetProfileController = TextEditingController();
  final _instaUsernameController = TextEditingController();
  final _instaPasswordController = TextEditingController();

  final _marketingMsg = TextEditingController();

  @override
  void dispose() {
    _targetProfileController.dispose();
    _instaUsernameController.dispose();
    _instaPasswordController.dispose();
    _marketingMsg.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: _isWorking,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BackButton(
                            onPressed: () => Navigator.pop(context),
                          ),
                          const LogoDisplay()
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        "Instagram Marketing",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const SizedBox(height: 20.0),
                      const Text(
                          "* Your data is kept private and never used for illegal purposes, read more at Settings > Help > Privacy Policy"),
                      const SizedBox(height: 15.0),
                      CustomTextField(
                        textEditingController: _instaUsernameController,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        hintText: "Instagram Username",
                        icon: Icons.person,
                      ),
                      const SizedBox(height: 15.0),
                      CustomTextField(
                        isPassword: true,
                        textEditingController: _instaPasswordController,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.text,
                        hintText: "Instagram Password",
                        icon: Icons.lock,
                      ),
                      const SizedBox(height: 30.0),
                      const Text("* You must not be following this account!"),
                      const SizedBox(height: 10.0),
                      CustomTextField(
                        textEditingController: _targetProfileController,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.text,
                        hintText: "Target Username",
                        icon: Icons.person,
                      ),
                      const SizedBox(height: 10.0),
                      CustomButton(
                        btnWidth: 100.0,
                        btnHeight: 45.0,
                        btnOnPressed: () {
                          setState(() {
                            _dataScraped = !_dataScraped;
                          });
                        },
                        btnColor: kLightGreenColor,
                        btnText: Text(
                          "Scrape Data",
                          style: kBtnTextStyle,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 250),
                        height: _dataScraped ? 140.0 : 0.0,
                        child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          maxLines: 5,
                          controller: _marketingMsg,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please provide some content!";
                            } else if (value.length < 25) {
                              return "Content can't be less than 25 characters!";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Enter your marketing content here...",
                            hintStyle: Theme.of(context).textTheme.caption,
                            fillColor:
                                Provider.of<ThemeProvider>(context).darkTheme
                                    ? Colors.black12
                                    : Colors.grey[200],
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                      _dataScraped ? const SizedBox(height: 15.0) : Container(),
                      _dataScraped
                          ? CustomButton(
                              btnWidth: 100.0,
                              btnHeight: 45.0,
                              btnOnPressed: () {
                                if (_formKey.currentState.validate()) {
                                  print("Some content is entered!");
                                }
                              },
                              btnColor: kLightBlueColor,
                              btnText: Text(
                                "Start Marketing",
                                style: kBtnTextStyle,
                              ),
                            )
                          : Container(),
                      const SizedBox(height: 25.0),
                      Text(
                        "Follower's Data",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const SizedBox(height: 10.0),
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
