import 'dart:convert';
import 'dart:io';
import 'package:adam/animations/bottomAnimation.dart';
import 'package:adam/constants.dart';
import 'package:adam/controller/marketing/email.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/utils/custom_snackbar.dart';
import 'package:adam/widgets/custom_button.dart';
import 'package:adam/widgets/customTextField.dart';
import 'package:adam/widgets/logoDisplay.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

enum EmailAction { Upload, DataBank, Custom }

class EmailMarketingView extends StatefulWidget {
  @override
  _EmailMarketingViewState createState() => _EmailMarketingViewState();
}

class _EmailMarketingViewState extends State<EmailMarketingView> {
  final _formkey = GlobalKey<FormState>();
  EmailAction _currentAction = EmailAction.Upload;

  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _emailBodyController = TextEditingController();
  final TextEditingController _customEmailController = TextEditingController();

  // picking .csv file
  FilePickerResult filePickerResult;
  PlatformFile platformFile;
  File csvFile;
  bool _uploadingFile = false;

  // getting emails out of .csv file
  List<String> _emailData = [];
  bool _sendingEmail = false;

  // getting .csv file from system
  void _pickCSVFile() async {
    setState(() {
      _uploadingFile = true;
    });
    filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['csv'],
    ).whenComplete(() {
      setState(() {
        _uploadingFile = false;
      });
    });

    if (filePickerResult != null) {
      setState(() {
        csvFile = File(filePickerResult.files.single.name);
      });
      final csv = File(filePickerResult.files.single.path).openRead();
      final fields = await csv
          .transform(utf8.decoder)
          .transform(CsvToListConverter())
          .toList();
      List _data = [];
      for (int j = 0; j < fields.length; j++) {
        _data = List.from(fields[j]);
        _emailData.add(_data[0]);
      }
      print(_emailData);
    }
  }

  @override
  void initState() {
    _emailBodyController.text =
        "Hi there!\n\n**write something here**\n\nCheckout out site below for more details:\nhttps://somebrandingsite.com\n\nRegards,\nBranding Team";
    super.initState();
  }

  @override
  void dispose() {
    _brandNameController.dispose();
    _subjectController.dispose();
    _emailBodyController.dispose();
    _customEmailController.dispose();
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
              child: Form(
                key: _formkey,
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
                        csvFile == null
                            ? Text("Upload .csv File")
                            : Text(
                                csvFile.path,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                        const SizedBox(width: 30.0),
                        _currentAction == EmailAction.Upload
                            ? WidgetAnimator(
                                child: CustomButton(
                                  btnWidth: 150.0,
                                  btnHeight: 30.0,
                                  btnOnPressed: _pickCSVFile,
                                  btnColor: kPrimaryBlueColor,
                                  btnText: _uploadingFile
                                      ? JumpingDotsProgressIndicator(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                        )
                                      : const Text("Upload file",
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
                              csvFile = null;
                              _emailData = [];
                            });
                          },
                        ),
                        const Text("Use our data bank"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: EmailAction.Custom,
                          groupValue: _currentAction,
                          onChanged: (value) {
                            setState(() {
                              _currentAction = value;
                              csvFile = null;
                              _emailData = [];
                            });
                          },
                        ),
                        const Text("Enter Custom emails"),
                      ],
                    ),
                    _currentAction == EmailAction.Custom
                        ? WidgetAnimator(
                            child: CustomTextField(
                              textEditingController: _customEmailController,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.emailAddress,
                              hintText: 'Enter email address',
                              icon: Icons.email,
                              trailing: Icons.add,
                              trailingCallBack: () {
                                if (_customEmailController.text.isNotEmpty) {
                                  setState(() {
                                    _emailData.insert(
                                        0, _customEmailController.text.trim());
                                  });
                                  _customEmailController.clear();
                                }
                              },
                            ),
                          )
                        : Container(),
                    const SizedBox(height: 10.0),
                    _currentAction == EmailAction.Custom
                        ? WidgetAnimator(
                            child: Text("Custom Emails:",
                                style: Theme.of(context).textTheme.headline2),
                          )
                        : Container(),
                    const SizedBox(height: 5.0),
                    _currentAction == EmailAction.Custom
                        ? ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: _emailData
                                .map(
                                  (email) => ListTile(
                                    contentPadding: const EdgeInsets.all(0.0),
                                    minVerticalPadding: 0.0,
                                    title: Text(
                                      email,
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                    trailing: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _emailData.remove(email);
                                        });
                                      },
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: 20,
                                          )),
                                    ),
                                  ),
                                )
                                .toList(),
                          )
                        : Container(),
                    const SizedBox(height: 10.0),
                    CustomTextField(
                      textEditingController: _brandNameController,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.text,
                      hintText: 'Brand Name',
                      icon: Icons.branding_watermark,
                      validatorFtn: (value) {
                        if (value.isEmpty) {
                          return "Brand name cannot be empty!";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    CustomTextField(
                      textEditingController: _subjectController,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.text,
                      hintText: 'Subject',
                      icon: Icons.alternate_email_rounded,
                      validatorFtn: (value) {
                        if (value.isEmpty) {
                          return "Subject cannot be empty!";
                        } else if (value.length < 6) {
                          return "Subject cannot be less than 6 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFormField(
                          maxLines: 6,
                          controller: _emailBodyController,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Body cannot be empty!";
                            } else if (value.length < 6) {
                              return "Body cannot be less than 6 characters";
                            }
                            return null;
                          },
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
                        btnOnPressed: _currentAction == EmailAction.Upload
                            ? _sendEmailsFromCSV
                            : _currentAction == EmailAction.DataBank
                                ? _sendEmailsFromDataBank
                                : _sendEmailsCustomList,
                        btnColor: kLightBlueColor,
                        btnText: _sendingEmail
                            ? kLoaderWhite
                            : const Text(
                                "Start Marketing",
                                style: kBtnTextStyle,
                              ),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // email marketing
  void _sendEmailsFromCSV() async {
    if (csvFile == null) {
      customSnackBar(
        context,
        Colors.red,
        Row(
          children: [
            const Icon(Icons.file_copy, color: Colors.white),
            const SizedBox(width: 8.0),
            const Text('Please select .csv file!'),
          ],
        ),
      );
    } else if (_formkey.currentState.validate()) {
      print(_emailData);
      FocusScope.of(context).unfocus();

      setState(() {
        _sendingEmail = true;
      });

      var value = await EmailMarketing()
          .emailFromCSV(
              _emailData,
              _subjectController.text.trim(),
              _emailBodyController.text.trim(),
              _brandNameController.text.trim())
          .whenComplete(() {
        setState(() {
          _sendingEmail = false;
        });
      });

      if (value is String) {
        customSnackBar(
          context,
          Colors.red,
          Row(
            children: [
              const Icon(Icons.info, color: Colors.white),
              const SizedBox(width: 8.0),
              Text(value.toString()),
            ],
          ),
        );
      } else {
        customSnackBar(
          context,
          kSecondaryBlueColor,
          Row(
            children: [
              const Icon(Icons.mark_email_read, color: Colors.white),
              const SizedBox(width: 8.0),
              const Text("Email has been sent successfully!"),
            ],
          ),
        );
        _brandNameController.clear();
        _subjectController.clear();
        _emailBodyController.clear();
        setState(() {
          csvFile = null;
          _emailData = [];
        });
      }
    }
  }

  // marketing via Data bank from DB
  void _sendEmailsFromDataBank() async {
    if (_formkey.currentState.validate()) {
      FocusScope.of(context).unfocus();

      setState(() {
        _sendingEmail = true;
      });

      var value = await EmailMarketing()
          .emailFromDataBank(
              _subjectController.text.trim(),
              _emailBodyController.text.trim(),
              _brandNameController.text.trim())
          .whenComplete(() {
        setState(() {
          _sendingEmail = false;
        });
      });

      if (value is String) {
        customSnackBar(
          context,
          Colors.red,
          Row(
            children: [
              const Icon(Icons.info, color: Colors.white),
              const SizedBox(width: 8.0),
              Text(value.toString()),
            ],
          ),
        );
      } else {
        customSnackBar(
          context,
          kSecondaryBlueColor,
          Row(
            children: [
              const Icon(Icons.mark_email_read, color: Colors.white),
              const SizedBox(width: 8.0),
              const Text("Email has been sent successfully!"),
            ],
          ),
        );
        _brandNameController.clear();
        _subjectController.clear();
        _emailBodyController.clear();
      }
    }
  }

  // send custom emails
  void _sendEmailsCustomList() async {
    if (_formkey.currentState.validate()) {
      print(_emailData);
      FocusScope.of(context).unfocus();

      setState(() {
        _sendingEmail = true;
      });

      var value = await EmailMarketing()
          .emailFromCSV(
              _emailData,
              _subjectController.text.trim(),
              _emailBodyController.text.trim(),
              _brandNameController.text.trim())
          .whenComplete(() {
        setState(() {
          _sendingEmail = false;
        });
      });

      if (value is String) {
        customSnackBar(
          context,
          Colors.red,
          Row(
            children: [
              const Icon(Icons.info, color: Colors.white),
              const SizedBox(width: 8.0),
              Text(value.toString()),
            ],
          ),
        );
      } else {
        customSnackBar(
          context,
          kSecondaryBlueColor,
          Row(
            children: [
              const Icon(Icons.mark_email_read, color: Colors.white),
              const SizedBox(width: 8.0),
              const Text("Email has been sent successfully!"),
            ],
          ),
        );
        _brandNameController.clear();
        _subjectController.clear();
        _emailBodyController.clear();
        setState(() {
          _emailData = [];
        });
      }
    }
  }
}
