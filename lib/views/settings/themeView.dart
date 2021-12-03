import 'package:adam/constants.dart';
import 'package:adam/controller/theme_controller/theme_provider.dart';
import 'package:adam/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ThemeView extends StatefulWidget {
  @override
  _ThemeViewState createState() => _ThemeViewState();
}

class _ThemeViewState extends State<ThemeView> {
  List _fontSizeList = ["Small", "Medium", "Large"];

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeProvider>(context);
    return _themeProvider == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("Theme"),
            ),
            body: ListView(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 15.0, right: 10.0),
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
                  leading: Icon(FontAwesomeIcons.font),
                  title: Text("Font size"),
                  trailing: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      icon: Container(),
                      value: _themeProvider.size,
                      onChanged: (value) {
                        _themeProvider.size = value;

                        print(_themeProvider.size);
                      },
                      items: _fontSizeList
                          .map((value) => DropdownMenuItem(
                                onTap: () {
                                  customSnackBar(
                                      context,
                                      kSecondaryBlueColor,
                                      Text(
                                        "Font size changed: $value",
                                      ));
                                },
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ));
  }
}
