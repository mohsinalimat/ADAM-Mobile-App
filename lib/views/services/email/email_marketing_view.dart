import 'package:adam/animations/bottomAnimation.dart';
import 'package:adam/constants.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:adam/widgets/logoDisplay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum EmailAction {
  Upload,
  DataBank,
  Scrape,
}

class EmailMarketingView extends StatefulWidget {
  @override
  _EmailMarketingViewState createState() => _EmailMarketingViewState();
}

class _EmailMarketingViewState extends State<EmailMarketingView> {
  EmailAction _currentAction = EmailAction.Upload;

  final TextEditingController _emailBodyController = TextEditingController();

  @override
  void dispose() {
    _emailBodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
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
                  Text(
                    "Email Marketing",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                      "* Your data is kept private and never used for illegal purposes, read more at Settings > Help > Privacy Policy"),
                  const SizedBox(height: 15.0),
                  const Text("Choose the action(s): *"),
                  Row(
                    children: [
                      Radio(
                        value: EmailAction.Upload,
                        groupValue: _currentAction,
                        onChanged: (value) {
                          setState(() {
                            _currentAction = value;
                          });
                        },
                      ),
                      const Text("Upload .csv File"),
                      const SizedBox(width: 30.0),
                      _currentAction == EmailAction.Upload
                          ? WidgetAnimator(
                              child: CustomButton(
                                btnWidth: 150.0,
                                btnHeight: 30.0,
                                btnOnPressed: () {},
                                btnColor: kPrimaryBlueColor,
                                btnText: const Text("Upload file",
                                    style: kBtnTextStyle),
                              ),
                            )
                          : Container()
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: EmailAction.DataBank,
                        groupValue: _currentAction,
                        onChanged: (value) {
                          setState(() {
                            _currentAction = value;
                          });
                        },
                      ),
                      const Text("Use our data bank"),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: EmailAction.Scrape,
                        groupValue: _currentAction,
                        onChanged: (value) {
                          setState(() {
                            _currentAction = value;
                          });
                        },
                      ),
                      const Text("Scrape Data"),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        maxLines: 5,
                        controller: _emailBodyController,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        decoration: InputDecoration(
                          hintText: "Enter Email content",
                          hintStyle: Theme.of(context).textTheme.caption,
                          fillColor: _themeProvider.darkTheme
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
                  ),
                  const SizedBox(height: 12.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: CustomButton(
                      btnWidth: 100.0,
                      btnHeight: 45.0,
                      btnOnPressed: () {},
                      btnColor: kLightBlueColor,
                      btnText: const Text(
                        "Start Marketing",
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
    );
  }
}
