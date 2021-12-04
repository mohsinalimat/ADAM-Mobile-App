import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class MessageBubble extends StatefulWidget {
  MessageBubble(
      {this.sender, this.text, this.isUser, this.uploadingFile = false});
  final String sender;
  final String text;
  final bool isUser;
  final bool uploadingFile;

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  bool _fileUploaded = false;

  void _fileUploadedDone() {
    _fileUploaded = widget.uploadingFile;
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _fileUploaded = false;
      });
    });
  }

  @override
  void initState() {
    _fileUploadedDone();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            widget.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.sender,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          SizedBox(height: 2.0),
          _fileUploaded
              ? FadingText("Uploading File...")
              : Material(
                  borderRadius: widget.isUser
                      ? BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))
                      : BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                  elevation: 1.0,
                  color:
                      widget.isUser ? Colors.lightBlueAccent : Colors.white54,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Text(
                      widget.text,
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
