import 'dart:io';

import 'package:adam/constants.dart';
import 'package:adam/controller/marketing/twitter.dart';
import 'package:adam/utils/custom_snackbar.dart';
import 'package:adam/utils/main_imports.dart';
import 'package:adam/utils/scroll_down_effect.dart';
import 'package:adam/views/services/widgets/scheduled_post_card.dart';
import 'package:adam/widgets/custom_text_field.dart';
import 'package:adam/widgets/custom_button.dart';
import 'package:adam/widgets/app_logo.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum MediaType {
  text,
  image,
}

class TwitterAccountScheduler extends StatefulWidget {
  @override
  _TwitterAccountSchedulerState createState() =>
      _TwitterAccountSchedulerState();
}

class _TwitterAccountSchedulerState extends State<TwitterAccountScheduler> {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  ScrollController _controller = ScrollController();

  MediaType _mediaType = MediaType.text;

  // date & time to be scheduled
  final format = DateFormat("dd-MM-yyyy");
  final formatTime = DateFormat("HH:mm");

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _autoReplyMsgController = TextEditingController();
  // greeting msg
  final TextEditingController _msgController = TextEditingController();

  bool _isUpdating = false; // updating tweets
  bool _isGreeted = false; // sending greeting msg flag
  bool _isCheckingNewFollowers = false;
  bool _newFollowersFound = false;
  List _newFollowersList = [];

  bool _autoReplying = false;

  // file/media picking
  FilePickerResult filePickerResult;
  PlatformFile platformFile;
  File someFile;
  bool _uploadingFile = false;
  bool _fileUploaded = false;
  String path = "";
  String _urlMedia = '';

  @override
  void dispose() {
    _contentController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _msgController.dispose();
    super.dispose();
  }

  List scheduledPosts = [
    ScheduledPostCard(
      caption: "Testing tweet from Flutter app",
      date: "01-09-2021",
      time: "02:23 PM",
    ),
    ScheduledPostCard(
      caption: "Testing tweet!",
      date: "02-09-2021",
      time: "04:12 PM",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);
    return AbsorbPointer(
      absorbing: _isUpdating || _uploadingFile,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          controller: _controller,
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
                    "Twitter Account Scheduler",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 20.0),
                  const Text('Add Image/Video:'),
                  Row(children: [
                    Radio(
                      value: MediaType.text,
                      groupValue: _mediaType,
                      onChanged: (value) {
                        setState(() {
                          _fileUploaded = false;
                          _urlMedia = "";
                          someFile = null;
                          _mediaType = value;
                        });
                      },
                    ),
                    const Text('Text'),
                    Radio(
                      value: MediaType.image,
                      groupValue: _mediaType,
                      onChanged: (value) {
                        setState(() {
                          _fileUploaded = false;
                          _urlMedia = "";
                          someFile = null;
                          _mediaType = value;
                        });
                      },
                    ),
                    const Text('Media'),
                  ]),
                  _fileUploaded
                      ? Container(
                          height: 250.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(someFile),
                            ),
                          ),
                        )
                      : Text(''),
                  const SizedBox(height: 10.0),
                  CustomButton(
                    btnWidth: MediaQuery.of(context).size.width,
                    btnHeight: 45.0,
                    btnOnPressed: _mediaType == MediaType.text
                        ? null
                        : _mediaType == MediaType.image
                            ? () => _addAttachment(true)
                            : () => _addAttachment(false),
                    btnColor: Colors.white,
                    btnText: _uploadingFile
                        ? kLoader
                        : Text(
                            'Upload Media',
                            style: TextStyle(
                              color: _mediaType == MediaType.text
                                  ? Colors.grey
                                  : kPrimaryBlueColor,
                            ),
                          ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text('Tweet caption: *'),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.89,
                    child: TextFormField(
                      maxLines: 5,
                      controller: _contentController,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      decoration: InputDecoration(
                        hintText: "Caption...",
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
                          return "Caption is empty!";
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
                      TimeOfDay time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now(),
                        ),
                      );
                      return DateTimeField.convert(time);
                    },
                  ),
                  const SizedBox(height: 20.0),
                  CustomButton(
                    btnWidth: MediaQuery.of(context).size.width,
                    btnHeight: 45.0,
                    btnOnPressed: _mediaType != MediaType.text
                        ? _tweetImage
                        : _tweetTextOnly,
                    btnColor: kPrimaryBlueColor,
                    btnText: _isUpdating
                        ? kLoaderWhite
                        : const Text('Schedule Tweet', style: kBtnTextStyle),
                  ),
                  Divider(
                    color: Colors.grey.withAlpha(150),
                    height: 30.0,
                  ),
                  Text(
                    "Scheduled Tweets",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 8.0),
                  for (int i = 0; i < scheduledPosts.length - 1; i++)
                    scheduledPosts[i],
                  const Divider(
                    height: 50.0,
                    thickness: 0.2,
                    color: Colors.grey,
                  ),
                  Text(
                    "Check Mentions",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 5.0),
                  const Text(
                      "Check if someone has mentioned you in a tweet & reply them."),
                  const SizedBox(height: 8.0),
                  CustomTextField(
                    textEditingController: _autoReplyMsgController,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.text,
                    hintText: 'Auto reply message...',
                    icon: Icons.message,
                  ),
                  const SizedBox(height: 8.0),
                  CustomButton(
                    btnWidth: MediaQuery.of(context).size.width,
                    btnHeight: 45.0,
                    btnOnPressed: _autoReply,
                    btnColor: kPrimaryBlueColor,
                    btnText: _autoReplying
                        ? kLoaderWhite
                        : const Text('Check', style: kBtnTextStyle),
                  ),
                  const Divider(
                    height: 50.0,
                    thickness: 0.2,
                    color: Colors.grey,
                  ),
                  Text(
                    "Greet New Followers",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 5.0),
                  const Text("Send a greeting message to your new followers"),
                  const SizedBox(height: 10.0),
                  !_newFollowersFound
                      ? Container()
                      : SizedBox(
                          width: MediaQuery.of(context).size.width * 0.89,
                          child: TextFormField(
                            maxLines: 5,
                            controller: _msgController,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            decoration: InputDecoration(
                              hintText: "Greeting Message...",
                              hintStyle: Theme.of(context).textTheme.caption,
                              fillColor: _themeProvider.darkTheme
                                  ? Colors.black12
                                  : Colors.grey[200],
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
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
                  const SizedBox(height: 10.0),
                  !_newFollowersFound
                      ? CustomButton(
                          btnWidth: MediaQuery.of(context).size.width,
                          btnHeight: 45.0,
                          btnOnPressed: _checkNewFollowers,
                          btnColor: kPrimaryBlueColor,
                          btnText: _isCheckingNewFollowers
                              ? kLoaderWhite
                              : const Text('Check New Followers',
                                  style: kBtnTextStyle),
                        )
                      : CustomButton(
                          btnWidth: MediaQuery.of(context).size.width,
                          btnHeight: 45.0,
                          btnOnPressed: _newFollowersFound
                              ? _sendGreetingMessage
                              : _checkNewFollowers,
                          btnColor: kPrimaryBlueColor,
                          btnText: _isGreeted
                              ? kLoaderWhite
                              : const Text('Send Greeting Message',
                                  style: kBtnTextStyle),
                        ),
                  const SizedBox(height: 20.0),
                  !_newFollowersFound
                      ? Container()
                      : Text(
                          "New Followers",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                  const SizedBox(height: 5.0),
                  !_newFollowersFound
                      ? Container()
                      : ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                            _newFollowersList.length,
                            (index) => TwitterScrapedUserDataCard(
                              twitterScrapedUser: _newFollowersList[index],
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

  // post a text based tweet
  Future<void> _tweetTextOnly() async {
    if (_formKey.currentState.validate()) {
      print("VALID!");
      setState(() {
        _isUpdating = true;
      });
      var value = await TwitterMarketing.tweetText(
        _contentController.text.trim(),
        "${_dateController.text.trim()} ${_timeController.text.trim()}",
      ).whenComplete(() {
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
              const Icon(Icons.info, color: Colors.white),
              const SizedBox(width: 8.0),
              Text(value),
            ],
          ),
        );
      } else {
        customSnackBar(
          context,
          kSecondaryBlueColor,
          Row(
            children: [
              const Icon(Icons.check, color: Colors.white),
              const SizedBox(width: 8.0),
              const Text("Tweet has been scheduled!"),
            ],
          ),
        );
        scheduledPosts.insert(
            0,
            ScheduledPostCard(
              date: _dateController.text.trim(),
              time: _timeController.text.trim(),
              caption: _contentController.text.trim(),
            ));
        _contentController.clear();
        _dateController.clear();
        _timeController.clear();
      }
    }
  }

  // pickingFile
  Future<void> _addAttachment(bool isImage) async {
    filePickerResult = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: isImage ? ['png', 'jpg', 'jpeg'] : ['mp4']);

    if (filePickerResult != null) {
      someFile = File(filePickerResult.files.single.path);
      platformFile = filePickerResult.files.first;

      setState(() {
        _fileUploaded = true;
        path = platformFile.path;
      });

      if (isImage) {
        _imageToFirebase();
      } else {
        _videoToFirebase();
      }
    }
  }

  // tweet with Media + caption (optional)
  Future<void> _tweetImage() async {
    if (someFile == null && _mediaType == MediaType.image) {
      customSnackBar(
        context,
        Colors.red,
        Row(
          children: [
            const Icon(Icons.image, color: Colors.white),
            const SizedBox(width: 8.0),
            const Text('Please select image file!'),
          ],
        ),
      );
    } else if (_formKey.currentState.validate()) {
      print("VALID!");
      setState(() {
        _isUpdating = true;
      });
      var value = await TwitterMarketing.tweetImage(
        _contentController.text.trim(),
        _urlMedia,
        "${_dateController.text.trim()} ${_timeController.text.trim()}",
      ).whenComplete(() {
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
              const Icon(Icons.info, color: Colors.white),
              const SizedBox(width: 8.0),
              Flexible(child: Text(value)),
            ],
          ),
        );
      } else {
        setState(() {
          _fileUploaded = false;
        });
        customSnackBar(
          context,
          kSecondaryBlueColor,
          Row(
            children: [
              const Icon(Icons.check, color: Colors.white),
              const SizedBox(width: 8.0),
              const Text("Image Tweet has been scheduled!"),
            ],
          ),
        );
        scheduledPosts.insert(
            0,
            ScheduledPostCard(
              date: _dateController.text.trim(),
              time: _timeController.text.trim(),
              caption: _contentController.text.trim(),
            ));
        _contentController.clear();
        _dateController.clear();
        _timeController.clear();
      }
    }
  }

  // upload and get URL from firestorage
  // IMAGE
  Future<void> _imageToFirebase() async {
    setState(() {
      _uploadingFile = true;
    });
    print(path);
    Reference ref = _firebaseStorage.ref('twitter').child('image');

    ref
        .putFile(someFile)
        .whenComplete(() async => _getImageURL().whenComplete(() {
              setState(() {
                _uploadingFile = false;
              });
            }));
  }

  Future<void> _getImageURL() async {
    // getting dp URL link
    String _url = await _firebaseStorage
        .ref("twitter/image")
        .getDownloadURL()
        .whenComplete(() {
      print("URL UPLOADED AT: $_urlMedia");
    });
    setState(() {
      _urlMedia = _url;
    });

    print("FILE UPLOADED $_urlMedia");
  }

  // VIDEO
  Future<void> _videoToFirebase() async {
    setState(() {
      _uploadingFile = true;
    });
    print(path);
    Reference ref = _firebaseStorage.ref('twitter').child('video');

    ref
        .putFile(someFile)
        .whenComplete(() async => _getVideoURL().whenComplete(() {
              setState(() {
                _uploadingFile = false;
              });
            }));
  }

  Future<void> _getVideoURL() async {
    // getting dp URL link
    String _url = await _firebaseStorage
        .ref("twitter/video")
        .getDownloadURL()
        .whenComplete(() {
      print("URL UPLOADED AT: $_urlMedia");
    });
    setState(() {
      _urlMedia = _url;
    });

    print("FILE UPLOADED $_urlMedia");
  }

  // auto reply to mentions
  Future<void> _autoReply() async {
    if (_autoReplyMsgController.text.isNotEmpty) {
      setState(() {
        _autoReplying = true;
      });
      var value =
          await TwitterMarketing.autoReply(_autoReplyMsgController.text.trim())
              .whenComplete(() {
        setState(() {
          _autoReplying = false;
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
              Text(
                value,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      } else {
        customSnackBar(
          context,
          kSecondaryBlueColor,
          Row(
            children: [
              const Icon(Icons.reply, color: Colors.white),
              const SizedBox(width: 8.0),
              Text(
                "Replied to all mentions (if any)",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      }
    } else {
      customSnackBar(
        context,
        Colors.red,
        Row(
          children: [
            const Icon(Icons.info, color: Colors.white),
            const SizedBox(width: 8.0),
            Text(
              'Cannot send an empty auto reply message!',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    }
  }

  // check new followers
  Future<void> _checkNewFollowers() async {
    setState(() {
      _isCheckingNewFollowers = true;
    });
    var value = await TwitterMarketing.checkNewFollowers().whenComplete(() {
      setState(() {
        _isCheckingNewFollowers = false;
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
            Text(
              value,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    } else {
      setState(() {
        _newFollowersFound = true;
        _newFollowersList = value.scrapedUsers;
      });
      customSnackBar(
        context,
        kSecondaryBlueColor,
        Row(
          children: [
            const Icon(Icons.person, color: Colors.white),
            const SizedBox(width: 8.0),
            Text(
              "New followers found!",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
      _msgController.clear();
      animateToIndex(9.2, _controller);
    }
  }

  // sending greeting msg
  Future<void> _sendGreetingMessage() async {
    if (_msgController.text.isNotEmpty) {
      FocusScope.of(context).unfocus();
      setState(() {
        _isGreeted = true;
      });
      var value =
          await TwitterMarketing.sendGreetingMsg(_msgController.text.trim())
              .whenComplete(() {
        setState(() {
          _isGreeted = false;
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
              Text(
                value,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      } else {
        customSnackBar(
          context,
          kSecondaryBlueColor,
          Row(
            children: [
              const Icon(Icons.check, color: Colors.white),
              const SizedBox(width: 8.0),
              Text(
                "Message sent to new followers!",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
        _msgController.clear();
        setState(() {
          _newFollowersFound = false;
          _newFollowersList = [];
        });
      }
    } else {
      customSnackBar(
        context,
        Colors.red,
        Row(
          children: [
            const Icon(Icons.info, color: Colors.white),
            const SizedBox(width: 8.0),
            Text(
              'Cannot send an empty message!',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    }
  }
}
