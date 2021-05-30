import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
