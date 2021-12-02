import 'package:adam/app_routes.dart';
import 'package:adam/constants.dart';
import 'package:adam/controller/service_controller.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/utils/custom_snackbar.dart';
import 'package:adam/widgets/custom_button.dart';
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

  bool _reporting = false;

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
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.text,
                    hintText: "Problem title/subject",
                    icon: Icons.subject_rounded,
                    validatorFtn: (value) {
                      if (value.isEmpty) {
                        return "Subject cannot be empty!";
                      } else if (value.substring(0, 1) == " ") {
                        return "Empty spaces in start not allowed!";
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
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Details cannot be empty!";
                        } else if (value.length < 15) {
                          return "Detials cannot be less than 15 characters!";
                        } else if (value.substring(0, 1) == " ") {
                          return "Empty spaces in start not allowed!";
                        }
                        return null;
                      },
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
                    btnHeight: 45.0,
                    btnOnPressed: _reportProblem,
                    btnColor: kPrimaryBlueColor,
                    btnText: _reporting
                        ? kLoaderWhite
                        : const Text(
                            "Submit",
                            style: kBtnTextStyle,
                          ),
                  ),
                  TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRoutes.faq),
                      child: Text("View FAQs"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _reportProblem() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _reporting = true;
      });

      var value = await ServiceController()
          .reportAProblem(
        _subjectFieldController.text.trim(),
        _detailsFieldController.text.trim(),
      )
          .whenComplete(() {
        setState(() {
          _reporting = false;
        });
      });

      if (value is String) {
        customSnackBar(
          context,
          Colors.red,
          Row(
            children: [
              const Icon(
                Icons.info,
                color: Colors.white,
              ),
              const SizedBox(width: 8.0),
              const Text('Error submitting report. Try again!'),
            ],
          ),
        );
      } else {
        Navigator.pop(context);
        customSnackBar(
          context,
          kSecondaryBlueColor,
          Row(
            children: [
              const Icon(Icons.check, color: Colors.white),
              const SizedBox(width: 8.0),
              const Text('Submitted! We will get back to you soon.'),
            ],
          ),
        );
        _subjectFieldController.clear();
        _detailsFieldController.clear();
      }
    }
  }
}
