import 'package:adam/controller/darkModeController/themeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeView extends StatefulWidget {
  @override
  _ThemeViewState createState() => _ThemeViewState();
}

class _ThemeViewState extends State<ThemeView> {
  final String _fontSize = "Medium";

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Theme"),
        ),
        body: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.brightness_6_rounded),
              title: Text("Dark Mode"),
              trailing: Switch(
                value: _themeProvider.darkTheme,
                onChanged: (value) => _themeProvider.darkTheme = value,
              ),
            ),
            ListTile(
              leading: Icon(Icons.text_fields_rounded),
              title: Text("Font size"),
              trailing: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: _themeProvider.size,
                  onChanged: (value) {
                    setState(() {
                      _themeProvider.size = value;
                    });
                    print(_themeProvider.size);
                  },
                  items: ["Small", "Medium", "Large"]
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ));
  }
}
