import 'dart:convert';
import 'dart:io';

import 'package:adam/controller/theme_controller/theme_provider.dart';
import 'package:adam/model/user_data.dart';
import 'package:adam/views/chat/widgets/message_bubble.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_socket_io/flutter_socket_io.dart';
// import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatView extends StatefulWidget {
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  ScrollController _scrollController = ScrollController();
  final _messageFieldController = TextEditingController();
  FocusNode _focus;
  bool _fieldEnabled = false;
  FilePickerResult filePickerResult;
  PlatformFile platformFile;
  File someFile;
  bool _uploadingFile = false;

  // socket io
  // SocketIO _socketIO;
  // IO.Socket _socket;
  List<Widget> _chatMessages = [];

  void _addAttachment() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String stringfyJson = preferences.getString("userData");
    UserData userData;
    Map userDataObject = jsonDecode(stringfyJson);
    userData = UserData.fromJSON(userDataObject);

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
        sender: userData.fullName,
        text: platformFile.name,
        uploadingFile: _uploadingFile,
      ));
    }
  }

  @override
  void initState() {
    _focus = FocusNode();
    _focus.addListener(() {
      print("FOCUS ${_focus.hasFocus}");
      _fieldEnabled = _focus.hasFocus;
      print("MESSAGE ENABLED! $_fieldEnabled");
    });

    // initSocket();

    super.initState();
  }

  // void initSocket() {
  //   _socketIO = SocketIOManager().createSocketIO(
  //     'https://adam-web-api.herokuapp.com',
  //     '/',
  //   );

  //   _socketIO.init();

  //   print(_socketIO.getId());

  //   _socketIO.subscribe(
  //     'response',
  //     () {
  //       print("CONECTED HO GYAAA!!!!!!!!!!");
  //     },
  //   );

  //   _socketIO.connect();
  // }

  // void initSocket() {
  //   try {
  //     _socket = IO.io(
  //       'https://adam-web-api.herokuapp.com/',
  //       <String, dynamic>{
  //         'transports': ['websocket'],
  //         'autoConnect': false,
  //       },
  //     );

  //     print(_socket.connected);

  //     _socket.connect();

  //     _socket.onConnect((data) => print('connnect to socket'));

  //     _socket.on('connected', (data) => print("DATA ON CONN: $data"));

  //     _socket.on('response', (data) => print("DATA ON RESPONSE: $data"));
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

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
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 20.0, bottom: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: BackButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // _socketIO.disconnect();
                    },
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  "Live Chat",
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(height: 5.0),
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
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                          child: SizedBox(
                        height: 45.0,
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
                      SizedBox(width: 15.0),
                      InkWell(
                        onTap: () async {
                          if (_messageFieldController.text != "") {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            String stringfyJson =
                                preferences.getString("userData");
                            UserData userData;
                            Map userDataObject = jsonDecode(stringfyJson);
                            userData = UserData.fromJSON(userDataObject);

                            // _socketIO.sendMessage(
                            //   'chat',
                            //   {
                            //     "sender": userData.fullName,
                            //     "message": _messageFieldController.text.trim(),
                            //     "time": DateTime.now().toUtc().toString(),
                            //   },
                            // );

                            // _socketIO.emit(
                            //   'chat',
                            // {
                            //   "sender": userData.fullName,
                            //   "message": _messageFieldController.text.trim(),
                            //   "time": DateTime.now().toUtc().toString(),
                            // },
                            // );

                            this.setState(
                              () => _chatMessages.add(
                                MessageBubble(
                                  isUser: true,
                                  sender: userData.fullName,
                                  text: _messageFieldController.text.trim(),
                                ),
                              ),
                            );
                            _messageFieldController.clear();
                          }
                        },
                        child: Icon(
                          Icons.send_rounded,
                          size: 25.0,
                        ),
                      ),
                      SizedBox(width: 10.0),
                      _fieldEnabled
                          ? Container()
                          : InkWell(
                              onTap: () {
                                _addAttachment();

                                Future.delayed(Duration(seconds: 1), () {
                                  setState(() {});
                                });
                              },
                              child: Icon(
                                Icons.attach_file_rounded,
                                size: 25.0,
                              ),
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
