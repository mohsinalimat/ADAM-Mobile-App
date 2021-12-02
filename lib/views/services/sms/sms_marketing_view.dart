import 'dart:convert';
import 'dart:io';

import 'package:adam/animations/bottomAnimation.dart';
import 'package:adam/constants.dart';
import 'package:adam/controller/marketing/sms.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/utils/custom_snackbar.dart';
import 'package:adam/widgets/custom_button.dart';
import 'package:adam/widgets/logoDisplay.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

enum SMSAction {
  Upload,
  DataBank,
}

class SMSMarketingView extends StatefulWidget {
  @override
  _SMSMarketingViewState createState() => _SMSMarketingViewState();
}

class _SMSMarketingViewState extends State<SMSMarketingView> {
  final _formkey = GlobalKey<FormState>();
  SMSAction _currentAction = SMSAction.Upload;

  final TextEditingController _messageContentController =
      TextEditingController();

  // picking .csv file
  FilePickerResult filePickerResult;
  PlatformFile platformFile;
  File csvFile;
  bool _uploadingFile = false;

  // getting emails out of .csv file
  List<String> _phoneNumbersData = [];
  bool _sendingSMS = false;

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
      for (int j = 0; j < fields.length - 1; j++) {
        _data = List.from(fields[j]);
        _phoneNumbersData.add("+${_data[0]}");
      }
    }
    print(_phoneNumbersData);
  }

  @override
  void initState() {
    _messageContentController.text =
        "Hi there!\n\n*edit your message*\n\nRegards,\n~Branding Team";
    super.initState();
  }

  @override
  void dispose() {
    _messageContentController.dispose();
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
                      "SMS Marketing",
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
                          value: SMSAction.Upload,
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
                        _currentAction == SMSAction.Upload
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
                          value: SMSAction.DataBank,
                          groupValue: _currentAction,
                          onChanged: (value) {
                            setState(() {
                              _currentAction = value;
                              csvFile = null;
                            });
                          },
                        ),
                        const Text("Use our data bank"),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFormField(
                          maxLines: 5,
                          controller: _messageContentController,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Message body cannot be empty!";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Enter message content",
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
                        btnOnPressed: _currentAction == SMSAction.Upload
                            ? _sendSMSFromCSV
                            : _sendSMSFromDataBank,
                        btnColor: kLightBlueColor,
                        btnText: _sendingSMS
                            ? kLoaderWhite
                            : const Text(
                                "Start Marketing",
                                style: kBtnTextStyle,
                              ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(color: Colors.red),
                        children: [
                          TextSpan(text: '* You will be charged '),
                          TextSpan(
                              text: '\$1/SMS',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: ' in addition to subscription payment.'),
                        ],
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

  // sms marketing from .csv file
  void _sendSMSFromCSV() async {
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
      print(_phoneNumbersData);
      FocusScope.of(context).unfocus();

      setState(() {
        _sendingSMS = true;
      });

      var value = await SMSMarketing()
          .smsFromCSV(_phoneNumbersData, _messageContentController.text.trim())
          .whenComplete(() {
        setState(() {
          _sendingSMS = false;
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
              Text('Some error occured!'),
            ],
          ),
        );
      } else if (value == 204) {
        customSnackBar(
          context,
          Colors.red,
          Row(
            children: [
              const Icon(Icons.info, color: Colors.white),
              const SizedBox(width: 8.0),
              Text("Cannot send empty text!"),
            ],
          ),
        );
      } else {
        customSnackBar(
          context,
          kSecondaryBlueColor,
          Row(
            children: [
              const Icon(Icons.message, color: Colors.white),
              const SizedBox(width: 8.0),
              const Text("SMS has been sent successfully!"),
            ],
          ),
        );
        _messageContentController.clear();
        setState(() {
          csvFile = null;
        });
      }
    }
  }

  // marketing via Data bank from DB
  void _sendSMSFromDataBank() async {
    if (_formkey.currentState.validate()) {
      FocusScope.of(context).unfocus();

      setState(() {
        _sendingSMS = true;
      });

      var value = await SMSMarketing()
          .smsFromDataBank(_messageContentController.text.trim())
          .whenComplete(() {
        setState(() {
          _sendingSMS = false;
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
              Text('Some error occured!'),
            ],
          ),
        );
      } else if (value == 204) {
        customSnackBar(
          context,
          Colors.red,
          Row(
            children: [
              const Icon(Icons.info, color: Colors.white),
              const SizedBox(width: 8.0),
              Text("Cannot send empty text!"),
            ],
          ),
        );
      } else {
        customSnackBar(
          context,
          kSecondaryBlueColor,
          Row(
            children: [
              const Icon(Icons.message, color: Colors.white),
              const SizedBox(width: 8.0),
              const Text("SMS has been sent successfully!"),
            ],
          ),
        );
        _messageContentController.clear();
      }
    }
  }
}
