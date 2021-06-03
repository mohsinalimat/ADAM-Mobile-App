import 'package:adam/constants.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FAQView extends StatefulWidget {
  @override
  _FAQViewState createState() => _FAQViewState();
}

class _FAQViewState extends State<FAQView> {
  int _currentIndex = 0;
  int _questionsLength = 4;

  @override
  void initState() {
    _questionsLength = _topQuestions.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            width > 650 ? Size.fromHeight(115.0) : Size.fromHeight(200.0),
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
              SizedBox(height: width > 650 ? 0.0 : 10.0),
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
                      children: List.generate(
                    4,
                    (i) => Padding(
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
                          switch (_currentIndex) {
                            case 0:
                              setState(() {
                                _questionsLength = _topQuestions.length;
                              });
                              break;
                            case 1:
                              setState(() {
                                _questionsLength = _paymentQuestions.length;
                              });
                              break;
                            case 2:
                              setState(() {
                                _questionsLength = _accountQuestions.length;
                              });
                              break;
                            case 3:
                              setState(() {
                                _questionsLength = _subscriptionAnswers.length;
                              });
                              break;
                            default:
                          }
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
                  )),
                ),
                // SvgPicture.asset(
                //   'assets/faq.svg',
                //   height: 100.0,
                // ),
                SizedBox(height: 20.0),
                for (int i = 0; i < _questionsLength; i++)
                  ExpansionTile(
                    backgroundColor: kLightBlueColor.withAlpha(50),
                    childrenPadding: const EdgeInsets.only(
                      left: 18.0,
                      bottom: 10.0,
                    ),
                    expandedAlignment: Alignment.centerLeft,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    iconColor: _themeProvider.darkTheme
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    title: Text(
                      _currentIndex == 0
                          ? _topQuestions[i]
                          : _currentIndex == 1
                              ? _paymentQuestions[i]
                              : _currentIndex == 2
                                  ? _accountQuestions[i]
                                  : _subscriptionQuestions[i],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _themeProvider.darkTheme
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      ),
                    ),
                    children: [
                      Text(
                        _currentIndex == 0
                            ? _topAnswers[i]
                            : _currentIndex == 1
                                ? _paymentAnswer[i]
                                : _currentIndex == 2
                                    ? _accountAnswers[i]
                                    : _subscriptionAnswers[i],
                      ),
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

  // top questions
  final _topQuestions = [
    "What is ADAM?",
    "How can I refund my money?",
    "Can I get a demo account?",
    "Any guide for using ADAM?",
    "Which social media platforms are available?",
  ];

  final _topAnswers = [
    "ADAM is a platform with marketing campaigns for various different social platforms using bots.",
    "For the time being there is no refund policy. Please headover to Settings > Help > Privacy Policy for more details.",
    "Yes, you may request to have a demo account. Headover to Main Screen > Button on bottom right > Live chat.",
    "Yes, you can watch a guide video or in-app walkthrough from Settings > Help.",
    "Facebook, Instagram, LinkedIn and Twitter marketing is available.",
  ];

  // payments questions
  final _paymentQuestions = [
    "How can I refund my money?",
    "Is the payment secure?",
    "How can I buy a service without debit/credit card?",
  ];

  final _paymentAnswer = [
    "For the time being there is no refund policy. Please headover to Settings > Help > Privacy Policy for more details.",
    "Payments are fully secured by Stripe.",
    "Payments are fully managed by Stripe due to which you need debit/credit cards like VISA, MasterCard etc.",
  ];

  // account questions
  final _accountQuestions = [
    "How to create an account?",
    "How can I delete my account?",
    "Is my account secure?",
  ];

  final _accountAnswers = [
    "Web: Headover to sign up screen by clicking 'sign up' button on top left of screen.\n\nMobile: Move to sign up screen in start of app.",
    "Settings > Accounts > Delete my account.",
    "Your account and account information is kept safe and sound. Read more about our policy at Settings > Help > Privacy Policy.",
  ];

  // subscription questions
  final _subscriptionQuestions = [
    "How many types of subscriptions are available?",
    "Can I customize my subscription plans?",
    "How to cancel on-going subscription?",
    "How can I get refund of my subscriptions?",
    "Can I switch between on-going subscriptions?"
  ];

  final _subscriptionAnswers = [
    "We have monthly and yearly subscriptions available",
    "Unfortunately, you cannot customize any plan.",
    "You can simply ask the ADAM team via live chat. Homescreen > More Button > Live chat.",
    "There is no refund policy. Read more at Settings > Help > Privacy Policy.",
    "Modification of on-going subscriptions are available by contacting the ADAM team. Homescreen > More Button > Live Chat."
  ];

  final _questionsType = [
    "Top Questions",
    "Payment",
    "Account",
    "Subscriptions"
  ];
}
