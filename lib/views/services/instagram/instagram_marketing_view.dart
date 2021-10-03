import 'package:adam/constants.dart';
import 'package:adam/controller/marketing/instagram.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/model/scraping/instagram/scraped_user.dart';
import 'package:adam/utils/custom_snackbar.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:adam/widgets/customTextField.dart';
import 'package:adam/widgets/logoDisplay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

bool instaMarketingRunning = false;

class InstagramMarketingView extends StatefulWidget {
  @override
  _InstagramMarketingViewState createState() => _InstagramMarketingViewState();
}

class _InstagramMarketingViewState extends State<InstagramMarketingView> {
  bool _dataScraped = false;
  bool _isWorking = false;
  final _targetProfileController = TextEditingController();
  final _instaUsernameController = TextEditingController();
  final _instaPasswordController = TextEditingController();
  final _marketingMsg = TextEditingController();

  // marketing data
  List _scrapedUsersData = [];

  // placeholding data
  void _placeholdingData() {
    _instaUsernameController.text = "nameishaiderali";
    _instaPasswordController.text = "hamza1998";
    _targetProfileController.text = 'bareera099';
    _marketingMsg.text =
        "Hi there! Hope you are doing well. Would love to connect with you for valuable content :)\n\nSo, hit me up with that Follow button\nCheers :D";
  }

  @override
  void initState() {
    _placeholdingData();
    super.initState();
  }

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
                  const SizedBox(height: 10.0),
                  Text(
                    "Instagram Marketing",
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
                              textEditingController: _instaUsernameController,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.text,
                              hintText: "Instagram Username",
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
                              textEditingController: _instaPasswordController,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.text,
                              hintText: "Instagram Password",
                              icon: Icons.lock,
                              validatorFtn: (value) {
                                if (value.isEmpty) {
                                  return "Pasword cannot be empty!";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20.0),
                            const Text("* You must be following this account!"),
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
                            const SizedBox(height: 15.0),
                          ],
                        ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    height: _dataScraped ? 140.0 : 0.0,
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      maxLines: 5,
                      controller: _marketingMsg,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      decoration: InputDecoration(
                        hintText: "Enter your marketing content here...",
                        hintStyle: Theme.of(context).textTheme.caption,
                        fillColor: Provider.of<ThemeProvider>(context).darkTheme
                            ? Colors.black12
                            : Colors.grey[200],
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
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
                          btnOnPressed: _sendDMs,
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
    );
  }

  // scrape the user data information
  void _scrapeData() async {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();

      setState(() {
        _isWorking = true;
      });

      var data = await InstagramMarketing()
          .scrapeUserData(
        _instaUsernameController.text.trim(),
        _instaPasswordController.text.trim(),
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

  // start sending DMs to scraped users
  void _sendDMs() async {
    if (_marketingMsg.text.isEmpty) {
      customSnackBar(
          context,
          Colors.red,
          Row(
            children: [
              const Icon(Icons.info, color: Colors.white),
              const SizedBox(width: 8.0),
              const Text("Enter some messaging content please!!")
            ],
          ));
    } else {
      FocusScope.of(context).unfocus();

      setState(() {
        _isWorking = true;
      });

      print("FTN CALLED AT FRONT END!!");

      var data = await InstagramMarketing()
          .sendDM(
        _marketingMsg.text.trim(),
        _instaUsernameController.text.trim(),
        _instaPasswordController.text.trim(),
      )
          .whenComplete(() {
        if (mounted) {
          setState(() {
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
            ));
      } else {
        setState(() {
          _dataScraped = false;
        });
        _marketingMsg.clear();
        customSnackBar(
          context,
          kLightGreenColor,
          Row(
            children: [
              const Icon(Icons.check, color: Colors.white),
              const SizedBox(width: 8.0),
              const Text(
                "Messages has been sent successfully!",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        );
      }
    }
  }
}

class InstaScrapedUserDataCard extends StatelessWidget {
  final InstaScrapedUser instaScrapedUser;

  const InstaScrapedUserDataCard({Key key, @required this.instaScrapedUser})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);
    return Card(
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(instaScrapedUser.photoUrl),
        ),
        title: Text(
          instaScrapedUser.username,
          style: TextStyle(
            color: _themeProvider.darkTheme ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Text(
          instaScrapedUser.profileUrl,
          style: TextStyle(
            color: _themeProvider.darkTheme ? Colors.white : Colors.black,
          ),
        ),
        children: [
          Text(
            "Bio:",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
          ),
          instaScrapedUser.bio == ""
              ? Text('*No Bio Found*')
              : Text(instaScrapedUser.bio),
          const SizedBox(height: 5.0),
          Text(
            "Followers:",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
          ),
          Text(instaScrapedUser.followers.toString()),
          const SizedBox(height: 5.0),
          Text(
            "Following:",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
          ),
          Text(instaScrapedUser.following.toString()),
          const SizedBox(height: 5.0),
          Text(
            "Posts:",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
          ),
          Text(instaScrapedUser.mediaCount.toString()),
        ],
        childrenPadding: const EdgeInsets.all(8.0),
        expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
      ),
    );
  }
}
