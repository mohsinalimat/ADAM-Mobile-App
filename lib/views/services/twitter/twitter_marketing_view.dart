import 'package:adam/constants.dart';
import 'package:adam/controller/marketing/twitter.dart';
import 'package:adam/controller/theme_controller/theme_provider.dart';
import 'package:adam/model/scraping/twitter/scraped_user.dart';
import 'package:adam/utils/audience_utils.dart';
import 'package:adam/utils/custom_snackbar.dart';
import 'package:adam/views/services/widgets/audience_chip.dart';
import 'package:adam/widgets/back_button.dart';
import 'package:adam/widgets/custom_button.dart';
import 'package:adam/widgets/custom_text_field.dart';
import 'package:adam/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TwitterMarketingView extends StatefulWidget {
  @override
  _TwitterMarketingViewState createState() => _TwitterMarketingViewState();
}

class _TwitterMarketingViewState extends State<TwitterMarketingView> {
  // progress checks
  bool _dataScraped = false;
  bool _isWorking = false;

  final _targetProfileController = TextEditingController();
  final _marketingMsg = TextEditingController();

  // marketing data
  List _scrapedUsersData = [];

  List<String> _usernames = [];

  // sorting
  int _sortIndex = 0;
  List<String> _sortBy = [
    "Default",
    "Followers",
    "Following",
  ];

  @override
  void initState() {
    _marketingMsg.text =
        "Hi there! Hope you are doing well. Would love to get in touch with you for sharing of valuable ideas :)\n\nSo, hit me up with that Follow button\nCheers :D";
    super.initState();
  }

  @override
  void dispose() {
    _targetProfileController.dispose();
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
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
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
                  const SizedBox(height: 10.0),
                  Text(
                    "Twitter Marketing",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                      "* Your data is kept private and never used for illegal purposes, read more at Settings > Help > Privacy Policy"),
                  const SizedBox(height: 30.0),
                  _dataScraped
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
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
                              : Text(
                                  "Start Marketing",
                                  style: kBtnTextStyle,
                                ),
                        )
                      : Container(),
                  const SizedBox(height: 15.0),
                  !_dataScraped
                      ? Container()
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Sort by:",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            const SizedBox(height: 7),
                            Row(
                              children: List.generate(
                                _sortBy.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 3.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _sortIndex = index;
                                        if (_sortIndex == 1) {
                                          _scrapedUsersData.sort(
                                            (a, b) => b.followers
                                                .compareTo(a.followers),
                                          );
                                        } else if (_sortIndex == 2) {
                                          _scrapedUsersData.sort(
                                            (a, b) => b.following
                                                .compareTo(a.following),
                                          );
                                        } else {
                                          _scrapedUsersData.sort(
                                            (a, b) => a.username
                                                .compareTo(b.username),
                                          );
                                        }
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: _sortIndex == index
                                            ? kPrimaryBlueColor
                                            : Colors.grey.withOpacity(0.65),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          _sortBy[index],
                                          style: kBtnTextStyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Target audience: ${_scrapedUsersData.length}",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              "Tap the profile picture to select individual target audience",
                            ),
                            const SizedBox(height: 5.0),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: _usernames
                                    .map(
                                      (e) => AudienceChip(
                                        username: e,
                                        onDelete: () {
                                          setState(() {
                                            _usernames.remove(e);
                                          });
                                          AudienceUtils.targetRemoved(
                                              e, context);
                                        },
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            ListView(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: List.generate(
                                _scrapedUsersData.length,
                                (index) => TwitterScrapedUserDataCard(
                                  twitterScrapedUser: _scrapedUsersData[index],
                                  usernames: _usernames,
                                  markForMessage: () {
                                    if (!_usernames.contains(
                                        _scrapedUsersData[index].username)) {
                                      setState(() {
                                        _usernames.add(
                                            _scrapedUsersData[index].username);
                                      });
                                      AudienceUtils.targetAdded(
                                          _scrapedUsersData[index].username,
                                          context);
                                    } else if (_usernames.contains(
                                        _scrapedUsersData[index].username)) {
                                      setState(() {
                                        _usernames.remove(
                                            _scrapedUsersData[index].username);
                                      });
                                      AudienceUtils.targetRemoved(
                                          _scrapedUsersData[index].username,
                                          context);
                                    }
                                    print(_usernames);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // scrape the user data information
  Future<void> _scrapeData() async {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();

      setState(() {
        _isWorking = true;
      });

      var data = await TwitterMarketing.scrapeUserData(
        _targetProfileController.text.trim(),
      ).whenComplete(() {
        if (mounted) {
          setState(() {
            _isWorking = false;
          });
        }
      });

      print("RESPONSE GENERATED!!");

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
                  data,
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
          ),
        );
      }
    }
  }

// start sending DMs to scraped users
  Future<void> _sendDMs() async {
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

      var data = await TwitterMarketing.sendDMs(
        _marketingMsg.text.trim(),
        _usernames,
      ).whenComplete(() {
        if (mounted) {
          setState(() {
            _isWorking = false;
          });
        }
      });

      if (data is String) {
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
            ));
      } else {
        setState(() {
          _usernames = [];
          _dataScraped = false;
        });
        _marketingMsg.clear();
        _targetProfileController.clear();
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

class TwitterScrapedUserDataCard extends StatelessWidget {
  final TwitterScrapedUser twitterScrapedUser;
  final Function markForMessage;
  final List<String> usernames;

  const TwitterScrapedUserDataCard({
    Key key,
    @required this.twitterScrapedUser,
    this.usernames,
    this.markForMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);
    return Card(
      child: ExpansionTile(
        leading: GestureDetector(
          onTap: markForMessage,
          child: CircleAvatar(
            backgroundImage: usernames.contains(twitterScrapedUser.username)
                ? null
                : twitterScrapedUser.photo ==
                        "http://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png"
                    ? AssetImage('assets/dp.png')
                    : NetworkImage(twitterScrapedUser.photo),
            child: usernames.contains(twitterScrapedUser.username)
                ? Icon(Icons.check)
                : Container(),
          ),
        ),
        title: Text(
          twitterScrapedUser.username,
          style: TextStyle(
            color: _themeProvider.darkTheme ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Text(
          twitterScrapedUser.profileUrl,
          style: TextStyle(
            color: _themeProvider.darkTheme ? Colors.white : Colors.black,
          ),
        ),
        children: [
          Text(
            "Bio:",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
          ),
          twitterScrapedUser.bio == ""
              ? Text('*No Bio Found*')
              : Text(twitterScrapedUser.bio),
          const SizedBox(height: 5.0),
          Text(
            "Followers:",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
          ),
          Text(twitterScrapedUser.followers.toString()),
          const SizedBox(height: 5.0),
          Text(
            "Following:",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
          ),
          Text(twitterScrapedUser.following.toString()),
          const SizedBox(height: 5.0),
          Text(
            "Location:",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
          ),
          Text(twitterScrapedUser.location),
        ],
        childrenPadding: const EdgeInsets.all(8.0),
        expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
      ),
    );
  }
}
