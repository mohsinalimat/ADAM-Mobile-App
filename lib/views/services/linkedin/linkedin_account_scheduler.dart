import 'package:adam/constants.dart';
import 'package:adam/controller/marketing/linkedin.dart';
import 'package:adam/utils/custom_snackbar.dart';
import 'package:adam/utils/main_imports.dart';
import 'package:adam/views/services/instagram/instagram_account_scheduler.dart';
import 'package:adam/widgets/custom_text_field.dart';
import 'package:adam/widgets/custom_button.dart';
import 'package:adam/widgets/app_logo.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LinkedinAccountScheduler extends StatefulWidget {
  @override
  _LinkedinAccountSchedulerState createState() =>
      _LinkedinAccountSchedulerState();
}

class _LinkedinAccountSchedulerState extends State<LinkedinAccountScheduler> {
  // date & time to be scheduled
  final format = DateFormat("dd-MM-yyyy");
  final formatTime = DateFormat("HH:mm");

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  final _linkedinEmailController = TextEditingController();
  final _linkedinPassController = TextEditingController();

  bool _isUpdating = false; // updating posts

  List scheduledPosts = [
    ScheduledPostCard(
      caption: "Testing LinkedIn Post from Flutter app",
      date: "23-05-2021",
      time: "01:10 PM",
    ),
    ScheduledPostCard(
      caption: "Testing tweet!",
      date: "02-09-2021",
      time: "04:12 PM",
    ),
  ];

  @override
  void initState() {
    _linkedinEmailController.text = "mhamzadev@yahoo.com";
    _linkedinPassController.text = "Iamhamza..!@#6";
    super.initState();
  }

  @override
  void dispose() {
    _contentController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _linkedinEmailController.dispose();
    _linkedinPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);
    return AbsorbPointer(
      absorbing: _isUpdating,
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
                    "LinkedIn Account Scheduler",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 10.0),
                  CustomTextField(
                    textEditingController: _linkedinEmailController,
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
                    textEditingController: _linkedinPassController,
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
                  const SizedBox(height: 10.0),
                  const Text('Post body:'),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.89,
                    child: TextFormField(
                      maxLines: 5,
                      controller: _contentController,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      decoration: InputDecoration(
                        hintText: "Type something...",
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
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Cannot send empty post body";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text('Choose Date/Time: *'),
                  const SizedBox(height: 10.0),
                  DateTimeField(
                    controller: _dateController,
                    validator: (value) {
                      if (value == null) {
                        return "Date cannot be empty!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
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
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.date_range,
                        color: _themeProvider.darkTheme
                            ? Colors.white
                            : kPrimaryBlueColor,
                      ),
                      contentPadding: const EdgeInsets.all(5.0),
                      hintText: "Date",
                      hintStyle: Theme.of(context).textTheme.caption,
                    ),
                    format: format,
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                    },
                  ),
                  const SizedBox(height: 10.0),
                  DateTimeField(
                    controller: _timeController,
                    validator: (value) {
                      if (value == null) {
                        return "Time cannot be empty!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
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
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.watch_later,
                        color: _themeProvider.darkTheme
                            ? Colors.white
                            : kPrimaryBlueColor,
                      ),
                      contentPadding: const EdgeInsets.all(5.0),
                      hintText: "Time",
                      hintStyle: Theme.of(context).textTheme.caption,
                    ),
                    format: formatTime,
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                            currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                  ),
                  const SizedBox(height: 20.0),
                  CustomButton(
                    btnWidth: MediaQuery.of(context).size.width,
                    btnHeight: 45.0,
                    btnOnPressed: _post,
                    btnColor: kPrimaryBlueColor,
                    btnText: _isUpdating
                        ? kLoaderWhite
                        : const Text('Schedule Post', style: kBtnTextStyle),
                  ),
                  const SizedBox(height: 5.0),
                  TextButton(
                      onPressed: () {}, child: const Text("Save as Draft")),
                  Text(
                    "Scheduled Posts",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 8.0),
                  for (int i = 0; i < scheduledPosts.length - 1; i++)
                    scheduledPosts[i],
                  const Divider(
                    height: 40.0,
                    thickness: 0.2,
                    color: Colors.grey,
                  ),
                  Text(
                    "Get more connection",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                      '* Requests will be sent to 2nd degree connections'),
                  const SizedBox(
                    height: 8.0,
                  ),
                  CustomButton(
                    btnWidth: MediaQuery.of(context).size.width,
                    btnHeight: 45.0,
                    btnOnPressed: _sendConnectionRequest,
                    btnColor: kPrimaryBlueColor,
                    btnText: const Text(
                      "Send connection requests",
                      style: kBtnTextStyle,
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

  // post
  void _post() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isUpdating = true;
      });

      var value = await LinkedInMarketing()
          .postTextOnly(
        _linkedinEmailController.text.trim(),
        _linkedinPassController.text.trim(),
        _contentController.text.trim(),
      )
          .whenComplete(() {
        setState(() {
          _isUpdating = false;
        });
      });

      if (value is String) {
        customSnackBar(
          context,
          Colors.red,
          Row(
            children: [
              Icon(
                Icons.info,
                color: Colors.white,
              ),
              SizedBox(width: 8.0),
              Text(
                "Post schedule failed!",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        );
      } else {
        setState(() {
          scheduledPosts.insert(
              0,
              ScheduledPostCard(
                date: _dateController.text.trim(),
                time: _timeController.text.trim(),
                caption: _contentController.text.trim(),
              ));
        });

        customSnackBar(
          context,
          kSecondaryBlueColor,
          Row(
            children: [
              Icon(Icons.check, color: Colors.white),
              SizedBox(width: 8.0),
              Text(
                "Post scheduled succesfully!",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        );

        _contentController.clear();
        _dateController.clear();
        _timeController.clear();
      }
    }
  }

  // add connection
  void _sendConnectionRequest() async {
    var value = await LinkedInMarketing().addConnection(
      _linkedinEmailController.text.trim(),
      _linkedinPassController.text.trim(),
    );

    if (value is String) {
      customSnackBar(
        context,
        Colors.red,
        Row(
          children: [
            Icon(
              Icons.info,
              color: Colors.white,
            ),
            SizedBox(width: 8.0),
            Text(
              "Adding connection failed!",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      );
    } else {
      customSnackBar(
        context,
        kSecondaryBlueColor,
        Row(
          children: [
            Icon(Icons.check, color: Colors.white),
            SizedBox(width: 8.0),
            Text(
              "Connection requests being sent!",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      );
    }
  }
}
