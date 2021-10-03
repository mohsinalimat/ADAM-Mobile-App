import 'package:adam/constants.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:adam/widgets/logoDisplay.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

enum ScheduleType {
  Post,
  Story,
}

class InstagramAccountScheduler extends StatefulWidget {
  @override
  _InstagramAccountSchedulerState createState() =>
      _InstagramAccountSchedulerState();
}

class _InstagramAccountSchedulerState extends State<InstagramAccountScheduler> {
  final format = DateFormat("dd-MM-yyyy");
  final formatTime = DateFormat("HH:mm");

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  bool _isUpdating = false;
  ScheduleType _scheduleType = ScheduleType.Post;

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
    _contentController.dispose();
    _dateController.dispose();
    _timeController.dispose();
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
                    "Instagram Account Scheduler",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 20.0),
                  const Text("Schedule:"),
                  Row(children: [
                    Radio(
                      value: ScheduleType.Post,
                      groupValue: _scheduleType,
                      onChanged: (value) {
                        setState(() {
                          _scheduleType = value;
                        });
                      },
                    ),
                    const Text('Post'),
                    const SizedBox(width: 30.0),
                    Radio(
                      value: ScheduleType.Story,
                      groupValue: _scheduleType,
                      onChanged: (value) {
                        setState(() {
                          _scheduleType = value;
                        });
                      },
                    ),
                    const Text('Story'),
                  ]),
                  const SizedBox(height: 20.0),
                  const Text('Add Image/Video: *'),
                  const SizedBox(height: 10.0),
                  CustomButton(
                    btnWidth: MediaQuery.of(context).size.width,
                    btnHeight: 45.0,
                    btnOnPressed: () {},
                    btnColor: Colors.white,
                    btnText: const Text(
                      'Upload',
                      style: TextStyle(
                        letterSpacing: 1.3,
                        color: kPrimaryBlueColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    _scheduleType == ScheduleType.Post
                        ? "Post Caption: *"
                        : "Story Caption: *",
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.89,
                    child: TextFormField(
                      maxLines: 5,
                      controller: _contentController,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
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
                    btnOnPressed:
                        _scheduleType == ScheduleType.Post ? _post : _story,
                    btnColor: kPrimaryBlueColor,
                    btnText: _isUpdating
                        ? kLoaderWhite
                        : Text(
                            _scheduleType == ScheduleType.Post
                                ? "Scheduled Post"
                                : "Scheduled Story",
                            style: kBtnTextStyle),
                  ),
                  const SizedBox(height: 5.0),
                  TextButton(
                      onPressed: () {}, child: const Text("Save as Draft")),
                  const SizedBox(height: 10.0),
                  Text(
                    _scheduleType == ScheduleType.Post
                        ? "Scheduled Posts"
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

  // post method
  void _post() async {
    if (_formKey.currentState.validate()) {
      
    }
  }

  // story method
  void _story() async {
    if (_formKey.currentState.validate()) {}
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
        // trailing: Row(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     InkWell(
        //       onTap: () {},
        //       child: Padding(
        //         padding: const EdgeInsets.all(5.0),
        //         child: Icon(
        //           Icons.edit,
        //           color: kLightGreenColor,
        //         ),
        //       ),
        //     ),
        //     InkWell(
        //       onTap: () {},
        //       child: Padding(
        //         padding: const EdgeInsets.all(5.0),
        //         child: Icon(
        //           Icons.delete,
        //           color: Colors.red,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
