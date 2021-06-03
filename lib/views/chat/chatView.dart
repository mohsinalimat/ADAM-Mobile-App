import 'dart:io';

import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/widgets/messageBubble.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatView extends StatefulWidget {
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  ScrollController _scrollController = ScrollController();
  final _messageFieldController = TextEditingController();
  FocusNode _focus;
  bool _fieldEnabled = false;
  List<Widget> _chatMessages = [];
  FilePickerResult filePickerResult;
  PlatformFile platformFile;
  File someFile;
  bool _uploadingFile = false;

  void _addAttachment() async {
    filePickerResult = await FilePicker.platform.pickFiles();

    if (filePickerResult != null) {
      someFile = File(filePickerResult.files.single.path);
      platformFile = filePickerResult.files.first;

      // sending the file in chat
      setState(() {
        _uploadingFile = true;
      });
      _chatMessages.add(MessageBubble(
        isUser: true,
        sender: FirebaseAuth.instance.currentUser.displayName,
        text: platformFile.name,
        uploadingFile: _uploadingFile,
      ));
    }
  }

  // _scrollDown() {
  //   _scrollController.animateTo(
  //     MediaQuery.of(context).size.height,
  //     curve: Curves.easeOut,
  //     duration: Duration(
  //       milliseconds: 750,
  //     ),
  //   );
  // }

  @override
  void initState() {
    _focus = FocusNode();
    _focus.addListener(() {
      print("FOCUS ${_focus.hasFocus}");
      _fieldEnabled = _focus.hasFocus;
      print("MESSAGE ENABLED! $_fieldEnabled");
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageFieldController.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: BackButton(
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Live Chat",
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text("Live chat with ADAM team!"),
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                    child: Container(
                  child: _chatMessages.length == 0
                      ? Center(
                          child: Text("Send a message to get started!"),
                        )
                      : SingleChildScrollView(
                          controller: _scrollController,
                          // reverse: true,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: _chatMessages,
                          ),
                        ),
                )),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                          child: SizedBox(
                        height: 40.0,
                        child: TextFormField(
                          maxLines: null,
                          focusNode: _focus,
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          controller: _messageFieldController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                              left: 10.0,
                            ),
                            hintText: "Message...",
                            hintStyle: Theme.of(context).textTheme.caption,
                            fillColor: _themeProvider.darkTheme
                                ? Colors.black12
                                : Colors.grey[200],
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          ),
                        ),
                      )),
                      SizedBox(width: 8.0),
                      IconButton(
                        onPressed: () {
                          if (_messageFieldController.text != "") {
                            setState(() {
                              _chatMessages.add(MessageBubble(
                                isUser: true,
                                sender: FirebaseAuth
                                    .instance.currentUser.displayName,
                                text: _messageFieldController.text.trim(),
                              ));
                            });
                            _messageFieldController.clear();
                            _focus.unfocus();
                            // _scrollDown();
                          }
                        },
                        icon: Icon(Icons.send_rounded),
                      ),
                      _fieldEnabled
                          ? Container()
                          : IconButton(
                              onPressed: () {
                                _addAttachment();

                                Future.delayed(Duration(seconds: 1), () {
                                  setState(() {});
                                });
                              },
                              icon: Icon(Icons.attach_file_rounded),
                            ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
