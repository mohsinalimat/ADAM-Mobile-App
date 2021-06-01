import 'package:adam/constants.dart';
import 'package:adam/controller/darkModeController/themeProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class FAQView extends StatefulWidget {
  @override
  _FAQViewState createState() => _FAQViewState();
}

class _FAQViewState extends State<FAQView> {
  int _currentIndex = 0;
  final _questions = [
    "What is ADAM?",
    "How can I refund my money?",
    "Can I get a demo account?",
    "Any guide for using ADAM?",
    "Which social media platforms are available?",
  ];

  final _answers = [
    "ADAM is a platform with marketing campaigns for various different social platforms using bots.",
    "For the time being there is no refund policy. Please headover to Settings > Help > Privacy Policy for more details.",
    "Yes, you may request to have a demo account. Headover to Main Screen > Button on bottom right > Live chat.",
    "Yes, you can watch a guide video or in-app walkthrough from Settings > Help.",
    "Facebook, Instagram, LinkedIn and Twitter marketing is available.",
  ];

  final _questionsType = [
    "Top Questions",
    "Payment",
    "Account",
    "Subscriptions"
  ];

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: Container(
          padding: const EdgeInsets.only(top: 32.0, left: 4.0, right: 4.0),
          decoration: BoxDecoration(
            color: _themeProvider.darkTheme ? Colors.white : kPrimaryBlueColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: BackButton(
                  color: _themeProvider.darkTheme ? Colors.black : Colors.white,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                "Frequently Asked Questions!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 34.0,
                  color: _themeProvider.darkTheme ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    " ${_questionsType[_currentIndex]}",
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headline1.fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0; i < _questionsType.length; i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: MaterialButton(
                            elevation: 0.0,
                            color: _currentIndex == i
                                ? kMediumBlueColor
                                : Colors.white,
                            shape: StadiumBorder(
                                side: BorderSide(
                              color: Theme.of(context).primaryColor,
                            )),
                            onPressed: () {
                              setState(() {
                                _currentIndex = i;
                              });
                            },
                            child: Text(
                              _questionsType[i],
                              style: TextStyle(
                                color: _currentIndex == i
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                // SvgPicture.asset(
                //   'assets/faq.svg',
                //   height: 100.0,
                // ),
                SizedBox(height: 20.0),
                for (int i = 0; i < _questions.length; i++)
                  ExpansionTile(
                    backgroundColor: kLightBlueColor.withAlpha(50),
                    childrenPadding: const EdgeInsets.only(
                      left: 18.0,
                      bottom: 10.0,
                    ),
                    expandedAlignment: Alignment.centerLeft,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    title: Text(
                      _questions[i],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    children: [
                      Text(_answers[i]),
                      SizedBox(height: 15.0),
                      Row(
                        children: [
                          Text(
                            "Was this question helpful?",
                          ),
                          Expanded(child: Container()),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text("Yes"),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text("No"),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
