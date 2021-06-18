import 'package:adam/constants.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:adam/widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ReportProblemView extends StatefulWidget {
  @override
  _ReportProblemViewState createState() => _ReportProblemViewState();
}

class _ReportProblemViewState extends State<ReportProblemView> {
  final _subjectFieldController = TextEditingController();
  final _detailsFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _subjectFieldController.dispose();
    _detailsFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Report a problem"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20.0),
                  SvgPicture.asset(
                    'assets/problem.svg',
                    height: 130,
                  ),
                  const SizedBox(height: 35.0),
                  CustomTextField(
                    textEditingController: _subjectFieldController,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    hintText: "Problem title/subject",
                    icon: Icons.subject_rounded,
                    validatorFtn: (value) {
                      if (value == null) {
                        return "Subject cannot be empty!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.89,
                    child: TextFormField(
                      maxLines: 5,
                      controller: _detailsFieldController,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      decoration: InputDecoration(
                        hintText: "Describe your problem in details",
                        hintStyle: Theme.of(context).textTheme.caption,
                        fillColor: _themeProvider.darkTheme
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
                  const SizedBox(height: 30.0),
                  CustomButton(
                    btnWidth: 100.0,
                    btnHeight: 40.0,
                    btnOnPressed: () {},
                    btnColor: kPrimaryBlueColor,
                    btnText: Text(
                      "Submit",
                      style: kBtnTextStyle,
                    ),
                  ),
                  TextButton(
                      onPressed: () => Navigator.pushNamed(context, "/faq"),
                      child: Text("View FAQs"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
