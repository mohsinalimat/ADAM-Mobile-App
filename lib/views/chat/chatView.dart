import 'package:adam/controller/darkModeController/themeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatView extends StatefulWidget {
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final _messageFieldController = TextEditingController();
  FocusNode _focus;
  bool _fieldEnabled = false;

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
                  child: Center(
                    child: Text("Send a message to get started!"),
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
                          _focus.unfocus();
                        },
                        icon: Icon(Icons.send_rounded),
                      ),
                      _fieldEnabled
                          ? Container()
                          : IconButton(
                              onPressed: () {},
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
