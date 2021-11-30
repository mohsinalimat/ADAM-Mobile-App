import 'dart:io';

import 'package:adam/constants.dart';
import 'package:adam/controller/marketing/reddit.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/utils/custom_snackbar.dart';
import 'package:adam/widgets/customTextField.dart';
import 'package:adam/widgets/custom_button.dart';
import 'package:adam/widgets/logoDisplay.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

enum ScheduleType {
  text,
  image,
  video,
}

class RedditAccountScheduler extends StatefulWidget {
  @override
  _RedditAccountSchedulerState createState() => _RedditAccountSchedulerState();
}

class _RedditAccountSchedulerState extends State<RedditAccountScheduler> {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  final format = DateFormat("dd-MM-yyyy");
  final formatTime = DateFormat("HH:mm");

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  bool _isUpdating = false;
  ScheduleType _scheduleType = ScheduleType.text;

  // file/media picking
  FilePickerResult filePickerResult;
  PlatformFile platformFile;
  File someFile;
  bool _uploadingFile = false;
  bool _fileUploaded = false;
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
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _dateController.dispose();
    _timeController.dispose();
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
                    "Reddit Account Scheduler",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 20.0),
                  const Text("Schedule:"),
                  Row(children: [
                    Radio(
                      value: ScheduleType.text,
                      groupValue: _scheduleType,
                      onChanged: (value) {
                        setState(() {
                          _fileUploaded = false;
                          _urlMedia = "";
                          someFile = null;
                          _scheduleType = value;
                        });
                      },
                    ),
                    const Text('Text'),
                    const SizedBox(width: 30.0),
                    Radio(
                      value: ScheduleType.image,
                      groupValue: _scheduleType,
                      onChanged: (value) {
                        setState(() {
                          _fileUploaded = false;
                          _urlMedia = "";
                          someFile = null;
                          _scheduleType = value;
                        });
                      },
                    ),
                    const Text('Image'),
                    const SizedBox(width: 30.0),
                    Radio(
                      value: ScheduleType.video,
                      groupValue: _scheduleType,
                      onChanged: (value) {
                        setState(() {
                          _fileUploaded = false;
                          _urlMedia = "";
                          someFile = null;
                          _scheduleType = value;
                        });
                      },
                    ),
                    const Text('Video'),
                  ]),
                  const SizedBox(height: 20.0),
                  const Text('Post title: *'),
                  const SizedBox(height: 10.0),
                  CustomTextField(
                    textEditingController: _titleController,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.text,
                    hintText: 'Post title',
                    icon: Icons.subject,
                    validatorFtn: (value) {
                      if (value.isEmpty) {
                        return "Title cannot be empty!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  _scheduleType == ScheduleType.image ||
                          _scheduleType == ScheduleType.video
                      ? Text(_fileUploaded ? "$path" : "Upload Image/Video: *")
                      : const Text('Post body: *'),
                  const SizedBox(height: 10.0),
                  _scheduleType == ScheduleType.image
                      ? _uploadImage()
                      : _scheduleType == ScheduleType.video
                          ? _uploadVideo()
                          : SizedBox(
                              width: MediaQuery.of(context).size.width * 0.89,
                              child: TextFormField(
                                maxLines: 5,
                                controller: _bodyController,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Body cannot be empty!";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Post body here...",
                                  hintStyle:
                                      Theme.of(context).textTheme.caption,
                                  fillColor: _themeProvider.darkTheme
                                      ? Colors.black12
                                      : Colors.grey[200],
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
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
                  const SizedBox(height: 12.0),
                  CustomButton(
                    btnWidth: MediaQuery.of(context).size.width,
                    btnHeight: 45.0,
                    btnOnPressed: _scheduleType == ScheduleType.text
                        ? _postText
                        : _scheduleType == ScheduleType.image
                            ? _postImage
                            : _postVideo,
                    btnColor: kPrimaryBlueColor,
                    btnText: _isUpdating
                        ? kLoaderWhite
                        : const Text(
                            'Schedule Post',
                            style: kBtnTextStyle,
                          ),
                  ),
                  const SizedBox(height: 5.0),
                  TextButton(
                      onPressed: () {}, child: const Text("Save as Draft")),
                  const SizedBox(height: 10.0),
                  Text(
                    "Scheduled Posts",
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

  // upload image button
  Widget _uploadImage() {
    return CustomButton(
      btnWidth: MediaQuery.of(context).size.width,
      btnHeight: 45,
      btnOnPressed: () => _addAttachment(true),
      btnColor: Colors.white,
      btnText: _uploadingFile
          ? kLoader
          : const Text(
              'Upload Media',
              style: TextStyle(
                color: kPrimaryBlueColor,
              ),
            ),
    );
  }

  // upload video button
  Widget _uploadVideo() {
    return CustomButton(
      btnWidth: MediaQuery.of(context).size.width,
      btnHeight: 45,
      btnOnPressed: () => _addAttachment(false),
      btnColor: Colors.white,
      btnText: _uploadingFile
          ? kLoader
          : const Text(
              'Upload Media',
              style: TextStyle(
                color: kPrimaryBlueColor,
              ),
            ),
    );
  }

  // pickingFile
  void _addAttachment(bool isImage) async {
    filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: isImage ? ['png', 'jpg', 'jpeg'] : ['mp4'],
    );

    if (filePickerResult != null) {
      someFile = File(filePickerResult.files.single.path);
      platformFile = filePickerResult.files.first;

      setState(() {
        path = platformFile.path;
        _fileUploaded = true;
        _uploadingFile = true;
      });

      // getting url image
      if (isImage) {
        await _imageToFirebase();
      } else {
        await _videoToFirebase();
      }
    }
  }

  // upload and get URL from firestorage
  // IMAGE
  Future<void> _imageToFirebase() async {
    print(path);
    Reference ref = _firebaseStorage.ref('reddit').child('image');

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
        .ref("reddit/image")
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
    Reference ref = _firebaseStorage.ref('reddit').child('video');

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
        .ref("reddit/video")
        .getDownloadURL()
        .whenComplete(() {
      print("URL UPLOADED AT: $_urlMedia");
    });
    setState(() {
      _urlMedia = _url;
    });

    print("FILE UPLOADED $_urlMedia");
  }

  // text post
  void _postText() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState.validate()) {
      setState(() {
        _isUpdating = true;
      });
      var value = await RedditMarketing()
          .postText(
        _titleController.text.trim(),
        _bodyController.text.trim(),
        "${_dateController.text.trim()} ${_timeController.text.trim()}",
      )
          .whenComplete(() {
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
          scheduledPosts.insert(
              0,
              ScheduledPostCard(
                date: _dateController.text.trim(),
                time: _timeController.text.trim(),
                caption: _titleController.text.trim(),
              ));
        });
        _titleController.clear();
        _bodyController.clear();
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

  // image post
  void _postImage() async {
    if (someFile == null) {
      customSnackBar(
        context,
        Colors.red,
        Row(
          children: [
            const Icon(Icons.image, color: Colors.white),
            const SizedBox(width: 8.0),
            const Text('Please upload some media file!'),
          ],
        ),
      );
    } else {
      if (_formKey.currentState.validate()) {
        setState(() {
          _isUpdating = true;
        });
        var value = await RedditMarketing()
            .postImage(
          _titleController.text.trim(),
          _urlMedia,
          "${_dateController.text.trim()} ${_timeController.text.trim()}",
        )
            .whenComplete(() {
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
                const Text("Image has been scheduled successfully!")
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
                  caption: _titleController.text.trim(),
                ));
          });
          _titleController.clear();
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
    }
  }

  // video post
  void _postVideo() async {
    if (someFile == null) {
      customSnackBar(
        context,
        Colors.red,
        Row(
          children: [
            const Icon(Icons.image, color: Colors.white),
            const SizedBox(width: 8.0),
            const Text('Please upload some media file!'),
          ],
        ),
      );
    } else {
      if (_formKey.currentState.validate()) {
        setState(() {
          _isUpdating = true;
        });
        var value = await RedditMarketing()
            .postVideo(
          _titleController.text.trim(),
          _urlMedia,
          "${_dateController.text.trim()} ${_timeController.text.trim()}",
        )
            .whenComplete(() {
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
                const Text("Image has been scheduled successfully!")
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
                  caption: _titleController.text.trim(),
                ));
          });
          _titleController.clear();
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
    }
  }
}

class ScheduledPostCard extends StatelessWidget {
  final String caption;
  final String date;
  final String time;

  const ScheduledPostCard({
    Key key,
    this.caption = "Some caption here",
    this.date = "12-10-2022",
    this.time = "12:00 PM",
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _themeProviders = Provider.of<ThemeProvider>(context);
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/phoneVerify.gif'),
        ),
        title: Text(
          // "${caption.substring(0, 17)}...",
          caption,
          style: TextStyle(
            color: _themeProviders.darkTheme ? Colors.white : kPrimaryBlueColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text("$date at $time"),
      ),
    );
  }
}
