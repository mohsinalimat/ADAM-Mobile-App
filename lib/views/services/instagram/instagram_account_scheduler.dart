import 'dart:io';

import 'package:adam/constants.dart';
import 'package:adam/controller/marketing/instagram.dart';
import 'package:adam/controller/theme_controller/theme_provider.dart';
import 'package:adam/utils/custom_snackbar.dart';
import 'package:adam/views/services/widgets/scheduled_post_card.dart';
import 'package:adam/widgets/custom_text_field.dart';
import 'package:adam/widgets/custom_button.dart';
import 'package:adam/widgets/app_logo.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

enum ScheduleType {
  postImage,
  postVideo,
  storyImage,
  storyVideo,
}

class InstagramAccountScheduler extends StatefulWidget {
  @override
  _InstagramAccountSchedulerState createState() =>
      _InstagramAccountSchedulerState();
}

class _InstagramAccountSchedulerState extends State<InstagramAccountScheduler> {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  final format = DateFormat("dd-MM-yyyy");
  final formatTime = DateFormat("HH:mm");

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  final _instaUsernameController = TextEditingController();
  final _instaPasswordController = TextEditingController();

  bool _isUpdating = false;
  ScheduleType _scheduleType = ScheduleType.postImage;

  // file/media picking
  FilePickerResult filePickerResult;
  PlatformFile platformFile;
  File someFile;
  bool _fileUploaded = false;
  bool _uploadingFile = false;
  String path = "";
  String _urlMedia = "";

  List scheduledPosts = [
    ScheduledPostCard(
      caption: "Testing post here!",
      date: "01-09-2021",
      time: "02:23 PM",
    ),
    ScheduledPostCard(
      caption: "Hey there i'm ADAM :)",
      date: "02-09-2021",
      time: "04:12 PM",
    ),
    ScheduledPostCard(
      caption: "Hey there i'm ADAM :)",
      date: "02-09-2021",
      time: "04:12 PM",
    ),
  ];

  @override
  void initState() {
    _instaUsernameController.text = "khaadi.pk.7";
    _instaPasswordController.text = "Test123@";
    super.initState();
  }

  @override
  void dispose() {
    _contentController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _instaUsernameController.dispose();
    _instaPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);
    return AbsorbPointer(
      absorbing: _isUpdating || _uploadingFile,
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
                    "Instagram Account Scheduler",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 10.0),
                  CustomTextField(
                    textEditingController: _instaUsernameController,
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
                    textEditingController: _instaPasswordController,
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
                  const Text("Schedule:"),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      Radio(
                        value: ScheduleType.postImage,
                        groupValue: _scheduleType,
                        onChanged: (value) {
                          setState(() {
                            _fileUploaded = false;
                            someFile = null;
                            _urlMedia = "";
                            path = "";
                            _scheduleType = value;
                          });
                        },
                      ),
                      const Text('Post Image'),
                      Radio(
                        value: ScheduleType.postVideo,
                        groupValue: _scheduleType,
                        onChanged: (value) {
                          setState(() {
                            _fileUploaded = false;
                            someFile = null;
                            _urlMedia = "";
                            path = "";
                            _scheduleType = value;
                          });
                        },
                      ),
                      const Text('Post Video'),
                      Radio(
                        value: ScheduleType.storyImage,
                        groupValue: _scheduleType,
                        onChanged: (value) {
                          setState(() {
                            _fileUploaded = false;
                            someFile = null;
                            _urlMedia = "";
                            path = "";
                            _scheduleType = value;
                          });
                        },
                      ),
                      const Text('Story Image'),
                      const SizedBox(width: 15.0),
                      Radio(
                        value: ScheduleType.storyVideo,
                        groupValue: _scheduleType,
                        onChanged: (value) {
                          setState(() {
                            _fileUploaded = false;
                            someFile = null;
                            _urlMedia = "";
                            path = "";
                            _scheduleType = value;
                          });
                        },
                      ),
                      const Text('Story Video'),
                    ]),
                  ),
                  const SizedBox(height: 20.0),
                  const Text('Add Image/Video: *'),
                  const SizedBox(height: 5.0),
                  _fileUploaded
                      ? Container(
                          height: 250.0,
                          decoration: _scheduleType == ScheduleType.postVideo ||
                                  _scheduleType == ScheduleType.storyVideo
                              ? BoxDecoration()
                              : BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(someFile),
                                  ),
                                ),
                          child: _scheduleType == ScheduleType.postVideo ||
                                  _scheduleType == ScheduleType.storyVideo
                              ? Center(
                                  child: Icon(
                                    Icons.videocam,
                                    size: 100,
                                  ),
                                )
                              : Container(),
                        )
                      : Text(''),
                  const SizedBox(height: 5.0),
                  CustomButton(
                    btnWidth: MediaQuery.of(context).size.width,
                    btnHeight: 45.0,
                    btnOnPressed: _scheduleType == ScheduleType.postImage ||
                            _scheduleType == ScheduleType.storyImage
                        ? () => _addAttachment(true)
                        : () => _addAttachment(false),
                    btnColor: Colors.white,
                    btnText: _uploadingFile
                        ? kLoader
                        : const Text(
                            'Upload Media',
                            style: TextStyle(
                              color: kPrimaryBlueColor,
                            ),
                          ),
                  ),
                  _scheduleType == ScheduleType.postImage ||
                          _scheduleType == ScheduleType.postVideo
                      ? const SizedBox(height: 20.0)
                      : Container(),
                  _scheduleType == ScheduleType.postImage ||
                          _scheduleType == ScheduleType.postVideo
                      ? Text("Post Caption: *")
                      : Container(),
                  const SizedBox(height: 10.0),
                  _scheduleType == ScheduleType.postImage ||
                          _scheduleType == ScheduleType.postVideo
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width * 0.89,
                          child: TextFormField(
                            maxLines: 5,
                            controller: _contentController,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Caption cannot be empty!";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Caption...",
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
                        )
                      : Container(),
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
                    btnOnPressed: _scheduleType == ScheduleType.postImage
                        ? _postImage
                        : _scheduleType == ScheduleType.postVideo
                            ? _postVideo
                            : _scheduleType == ScheduleType.storyImage
                                ? _storyImage
                                : _storyVideo,
                    btnColor: kPrimaryBlueColor,
                    btnText: _isUpdating
                        ? kLoaderWhite
                        : Text(
                            _scheduleType == ScheduleType.postImage ||
                                    _scheduleType == ScheduleType.postVideo
                                ? "Scheduled Post"
                                : "Scheduled Story",
                            style: kBtnTextStyle),
                  ),
                  Divider(
                    color: Colors.grey.withAlpha(150),
                    height: 30.0,
                  ),
                  Text(
                    _scheduleType == ScheduleType.postImage ||
                            _scheduleType == ScheduleType.postVideo
                        ? "Scheduled Post"
                        : "Scheduled Story",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 8.0),
                  for (int i = 0; i < scheduledPosts.length - 1; i++)
                    scheduledPosts[i],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // pickingFile
  Future<void> _addAttachment(bool isImage) async {
    filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: isImage ? ['png', 'jpg', 'jpeg'] : ['mp4'],
    );

    if (filePickerResult != null) {
      someFile = File(filePickerResult.files.single.path);
      platformFile = filePickerResult.files.first;

      // sending the file in chat
      setState(() {
        _uploadingFile = true;
        _fileUploaded = true;
        path = platformFile.path;
      });

      if (isImage) {
        await _imageToFirebase();
      } else {
        await _videoToFirebase();
      }
    }
  }

  // post image method
  Future<void> _postImage() async {
    if (someFile == null) {
      customSnackBar(
        context,
        Colors.red,
        Row(
          children: [
            const Icon(Icons.file_copy, color: Colors.white),
            const SizedBox(width: 8.0),
            const Text('Please upload some media file!'),
          ],
        ),
      );
    } else if (_formKey.currentState.validate()) {
      setState(() {
        _isUpdating = true;
      });
      var value = await InstagramMarketing.postImageStatus(
        _instaUsernameController.text.trim(),
        _instaPasswordController.text.trim(),
        _contentController.text.trim(),
        _urlMedia,
      ).whenComplete(() {
        setState(() {
          _isUpdating = false;
        });
      });

      if (value == 200) {
        customSnackBar(
          context,
          kSecondaryBlueColor,
          Row(
            children: [
              const Icon(Icons.update, color: Colors.white),
              const SizedBox(width: 8),
              const Text("Status has been scheduled successfully!")
            ],
          ),
        );
        setState(() {
          someFile = null;
          _fileUploaded = false;
          scheduledPosts.insert(
              0,
              ScheduledPostCard(
                date: _dateController.text.trim(),
                time: _timeController.text.trim(),
                caption: _contentController.text.trim(),
              ));
        });
        _contentController.clear();
        _dateController.clear();
        _timeController.clear();
      } else {
        customSnackBar(
          context,
          Colors.red,
          Row(
            children: [
              const Icon(Icons.info, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Some error, Image aspect ratio not valid'),
              ),
            ],
          ),
        );
      }
    }
  }

  // post video method
  Future<void> _postVideo() async {
    print('Posting Video!');
    if (someFile == null) {
      customSnackBar(
        context,
        Colors.red,
        Row(
          children: [
            const Icon(Icons.file_copy, color: Colors.white),
            const SizedBox(width: 8.0),
            const Text('Please upload some media file!'),
          ],
        ),
      );
    } else if (_formKey.currentState.validate()) {
      setState(() {
        _isUpdating = true;
      });
      var value = await InstagramMarketing.postVideoStatus(
        _instaUsernameController.text.trim(),
        _instaPasswordController.text.trim(),
        _contentController.text.trim(),
        _urlMedia,
      ).whenComplete(() {
        setState(() {
          _isUpdating = false;
        });
      });

      if (value == 200) {
        customSnackBar(
          context,
          kSecondaryBlueColor,
          Row(
            children: [
              const Icon(Icons.update, color: Colors.white),
              const SizedBox(width: 8),
              const Text("Status has been scheduled successfully!")
            ],
          ),
        );
        setState(() {
          someFile = null;
          _fileUploaded = false;
          scheduledPosts.insert(
              0,
              ScheduledPostCard(
                date: _dateController.text.trim(),
                time: _timeController.text.trim(),
                caption: _contentController.text.trim(),
              ));
        });
        _contentController.clear();
        _dateController.clear();
        _timeController.clear();
      } else {
        customSnackBar(
          context,
          Colors.red,
          Row(
            children: [
              const Icon(Icons.info, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(child: Text(value)),
            ],
          ),
        );
      }
    }
  }

  // story image method
  Future<void> _storyImage() async {
    print('Posting Story Image!');
    setState(() {
      _isUpdating = true;
    });
    var value = await InstagramMarketing.postImageStory(
      _instaUsernameController.text.trim(),
      _instaPasswordController.text.trim(),
      _urlMedia,
    ).whenComplete(() {
      setState(() {
        _isUpdating = false;
      });
    });

    if (value == 200) {
      customSnackBar(
        context,
        kSecondaryBlueColor,
        Row(
          children: [
            const Icon(Icons.update, color: Colors.white),
            const SizedBox(width: 8),
            const Text("Story has been scheduled successfully!")
          ],
        ),
      );
      setState(() {
        _fileUploaded = false;
        someFile = null;
        scheduledPosts.insert(
            0,
            ScheduledPostCard(
              date: _dateController.text.trim(),
              time: _timeController.text.trim(),
              caption: _contentController.text.trim(),
            ));
      });
      _contentController.clear();
      _dateController.clear();
      _timeController.clear();
    } else {
      customSnackBar(
        context,
        Colors.red,
        Row(
          children: [
            const Icon(Icons.info, color: Colors.white),
            const SizedBox(width: 8),
            Text(value),
          ],
        ),
      );
    }
  }

  // story video method
  Future<void> _storyVideo() async {
    print('Posting Story Video!');
    setState(() {
      _isUpdating = true;
    });
    var value = await InstagramMarketing.postVideoStory(
      _instaUsernameController.text.trim(),
      _instaPasswordController.text.trim(),
      _urlMedia,
    ).whenComplete(() {
      setState(() {
        _isUpdating = false;
      });
    });

    if (value == 200) {
      customSnackBar(
        context,
        kSecondaryBlueColor,
        Row(
          children: [
            const Icon(Icons.update, color: Colors.white),
            const SizedBox(width: 8),
            const Text("Story has been scheduled successfully!")
          ],
        ),
      );
      setState(() {
        _fileUploaded = false;
        someFile = null;
        scheduledPosts.insert(
            0,
            ScheduledPostCard(
              date: _dateController.text.trim(),
              time: _timeController.text.trim(),
              caption: _contentController.text.trim(),
            ));
      });
      _contentController.clear();
      _dateController.clear();
      _timeController.clear();
    } else {
      customSnackBar(
        context,
        Colors.red,
        Row(
          children: [
            const Icon(Icons.info, color: Colors.white),
            const SizedBox(width: 8),
            Text(value),
          ],
        ),
      );
    }
  }

  // upload and get URL from firestorage
  // IMAGE
  Future<void> _imageToFirebase() async {
    print(path);
    Reference ref = _firebaseStorage.ref('instagram').child('image');

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
        .ref("instagram/image")
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
    print(path);
    Reference ref = _firebaseStorage.ref('instagram').child('video');

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
        .ref("instagram/video")
        .getDownloadURL()
        .whenComplete(() {
      print("URL UPLOADED AT: $_urlMedia");
    });
    setState(() {
      _urlMedia = _url;
    });

    print("FILE UPLOADED $_urlMedia");
  }
}
