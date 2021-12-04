import 'package:adam/constants.dart';
import 'package:adam/controller/marketing/linkedin.dart';
import 'package:adam/controller/theme_controller/theme_provider.dart';
import 'package:adam/model/scraping/linkedin/scraped_user.dart';
import 'package:adam/utils/custom_snackbar.dart';
import 'package:adam/widgets/back_button.dart';
import 'package:adam/widgets/custom_button.dart';
import 'package:adam/widgets/custom_text_field.dart';
import 'package:adam/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LinkedinMarketingView extends StatefulWidget {
  @override
  _LinkedinMarketingViewState createState() => _LinkedinMarketingViewState();
}

class _LinkedinMarketingViewState extends State<LinkedinMarketingView> {
  // linkedin creds
  String _email = "";
  String _password = "";

  bool _dataScraped = false;
  bool _isWorking = false;
  final _keywordController = TextEditingController();
  final _linkedinUserNameController = TextEditingController();
  final _linkedinPasswordController = TextEditingController();

  final _marketingMsg = TextEditingController();

  // marketing data
  List _scrapedUsersData = [];

  @override
  void initState() {
    _linkedinUserNameController.text = "mhamzadev@yahoo.com";
    _linkedinPasswordController.text = "Iamhamza..!@#6";
    super.initState();
  }

  @override
  void dispose() {
    _keywordController.dispose();
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
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
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
                          CustomBackButton(
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
                                textInputAction: TextInputAction.done,
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
                                  "* Connections will be scraped based on your LinkedIn profile annotations"),
                              const SizedBox(height: 10.0),
                              CustomTextField(
                                validatorFtn: (value) {
                                  if (value.isEmpty) {
                                    return "Keyword cannot be empty!";
                                  }
                                  return null;
                                },
                                textEditingController: _keywordController,
                                textInputAction: TextInputAction.done,
                                textInputType: TextInputType.text,
                                hintText: "Keyword e.g Software Enginner",
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
                            btnOnPressed: _marketing,
                            btnColor: kLightBlueColor,
                            btnText: _isWorking
                                ? kLoaderWhite
                                : const Text(
                                    "Start Marketing",
                                    style: kBtnTextStyle,
                                  ),
                          )
                        : Container(),
                    const SizedBox(height: 25.0),
                    !_dataScraped
                        ? Container()
                        : Text(
                            "Target audience: ${_scrapedUsersData.length}",
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
                              (index) => LinkedInScrapedUserDataCard(
                                linkedinScrapedUser: _scrapedUsersData[index],
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
        _keywordController.text.trim(),
      )
          .whenComplete(() {
        if (mounted) {
          setState(() {
            _email = _linkedinUserNameController.text.trim();
            _password = _linkedinPasswordController.text.trim();
            _isWorking = false;
          });
        }
      });

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
          ),
        );
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

  // marketing
  void _marketing() async {
    if (_marketingMsg.text.trim().isNotEmpty) {
      var value = LinkedInMarketing().marketing(
        _email,
        _password,
        _marketingMsg.text.trim(),
      );

      if (value is String) {
        customSnackBar(
          context,
          Colors.red,
          Row(
            children: [
              const Icon(Icons.info, color: Colors.white),
              const SizedBox(width: 8.0),
              Text(
                'Some error occured!',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      } else {
        setState(() {
          _dataScraped = false;
          _email = "";
          _password = "";
        });
        customSnackBar(
          context,
          kSecondaryBlueColor,
          Row(
            children: [
              const Icon(Icons.check, color: Colors.white),
              const SizedBox(width: 8.0),
              const Text(
                "Messages are being sent!",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        );
      }
    } else {
      customSnackBar(
        context,
        Colors.red,
        Row(
          children: const [
            Icon(
              Icons.info,
              color: Colors.white,
            ),
            SizedBox(
              width: 8.0,
            ),
            Text('Cannot send empty message content!')
          ],
        ),
      );
    }
  }
}

class LinkedInScrapedUserDataCard extends StatelessWidget {
  final LinkedInScrapedUser linkedinScrapedUser;

  const LinkedInScrapedUserDataCard(
      {Key key, @required this.linkedinScrapedUser})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);
    return Card(
      child: ExpansionTile(
        leading: CircleAvatar(
          child: Text(
            linkedinScrapedUser.fullName.substring(0, 1),
          ),
        ),
        title: Text(
          linkedinScrapedUser.fullName,
          style: TextStyle(
            color: _themeProvider.darkTheme ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Text(
          linkedinScrapedUser.profileUrl,
          style: TextStyle(
            color: _themeProvider.darkTheme ? Colors.white : Colors.black,
          ),
        ),
        children: [
          Text(
            'Headline:',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
          ),
          linkedinScrapedUser.headline == ""
              ? Text('*No healine Found*')
              : Text(linkedinScrapedUser.summary),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            "Bio:",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
          ),
          linkedinScrapedUser.summary == ""
              ? Text('*No Summary Found*')
              : Text(linkedinScrapedUser.summary),
        ],
        childrenPadding: const EdgeInsets.all(8.0),
        expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
      ),
    );
  }
}
