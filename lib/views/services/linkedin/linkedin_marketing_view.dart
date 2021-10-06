import 'package:adam/constants.dart';
import 'package:adam/controller/marketing/linkedin.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/utils/custom_snackbar.dart';
import 'package:adam/views/services/instagram/instagram_marketing_view.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:adam/widgets/customTextField.dart';
import 'package:adam/widgets/logoDisplay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LinkedinMarketingView extends StatefulWidget {
  @override
  _LinkedinMarketingViewState createState() => _LinkedinMarketingViewState();
}

class _LinkedinMarketingViewState extends State<LinkedinMarketingView> {
  bool _dataScraped = false;
  bool _isWorking = false;
  final _targetProfileController = TextEditingController();
  final _linkedinUserNameController = TextEditingController();
  final _linkedinPasswordController = TextEditingController();

  final _marketingMsg = TextEditingController();

  // marketing data
  List _scrapedUsersData = [];

  @override
  void initState() {
    _linkedinUserNameController.text = "mhamzadev@yahoo.com";
    _linkedinPasswordController.text = "Iamhamza..!@#6";
    _targetProfileController.text = "khaaadi456";
    super.initState();
  }

  @override
  void dispose() {
    _targetProfileController.dispose();
    _linkedinUserNameController.dispose();
    _linkedinPasswordController.dispose();
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
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BackButton(
                            onPressed: () => Navigator.pop(context),
                          ),
                          const LogoDisplay()
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      "LinkedIn Marketing",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                        "* Your data is kept private and never used for illegal purposes, read more at Settings > Help > Privacy Policy"),
                    const SizedBox(height: 15.0),
                    _dataScraped
                        ? Container()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CustomTextField(
                                textEditingController:
                                    _linkedinUserNameController,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.text,
                                hintText: "LinkedIn Username",
                                icon: Icons.person,
                                validatorFtn: (value) {
                                  if (value.isEmpty) {
                                    return "Username cannot be empty!";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15.0),
                              CustomTextField(
                                isPassword: true,
                                textEditingController:
                                    _linkedinPasswordController,
                                textInputAction: TextInputAction.done,
                                textInputType: TextInputType.text,
                                hintText: "LinkedIn Password",
                                icon: Icons.lock,
                                validatorFtn: (value) {
                                  if (value.isEmpty) {
                                    return "Pasword cannot be empty!";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 30.0),
                              const Text(
                                  "* You must be a connection with this account!"),
                              const SizedBox(height: 10.0),
                              CustomTextField(
                                validatorFtn: (value) {
                                  if (value.isEmpty) {
                                    return "Target profile cannot be empty!";
                                  }
                                  return null;
                                },
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
                                btnOnPressed: _scrapeData,
                                btnColor: kLightGreenColor,
                                btnText: _isWorking
                                    ? kLoaderWhite
                                    : Text(
                                        "Scrape Data",
                                        style: kBtnTextStyle,
                                      ),
                              ),
                            ],
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
                            btnOnPressed: () async {
                              if (_formKey.currentState.validate()) {}
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
                    !_dataScraped
                        ? Container()
                        : ListView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: List.generate(
                              _scrapedUsersData.length,
                              (index) => InstaScrapedUserDataCard(
                                instaScrapedUser: _scrapedUsersData[index],
                              ),
                            ),
                          )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // scrape the user data information
  void _scrapeData() async {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();

      setState(() {
        _isWorking = true;
      });

      var data = await LinkedInMarketing()
          .scrapeUserData(
        _linkedinUserNameController.text.trim(),
        _linkedinPasswordController.text.trim(),
        _targetProfileController.text.trim(),
      )
          .whenComplete(() {
        if (mounted) {
          setState(() {
            _isWorking = false;
          });
        }
      });

      print("FTN CALLED AT FRONT END!!");

      if (data is String) {
        print(data);
        customSnackBar(
            context,
            Colors.red,
            Row(
              children: [
                const Icon(Icons.info, color: Colors.white),
                const SizedBox(width: 8.0),
                Text(
                  'Please try again after 90 secs to avoid ban :)',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ));
      } else {
        print(data.scrapedUsers.length);
        setState(() {
          _dataScraped = true;
          _scrapedUsersData = data.scrapedUsers;
        });
        customSnackBar(
            context,
            kLightGreenColor,
            Row(
              children: [
                const Icon(Icons.check, color: Colors.white),
                const SizedBox(width: 8.0),
                const Text(
                  "Data scraped successfully!",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ));
      }
    }
  }
}
