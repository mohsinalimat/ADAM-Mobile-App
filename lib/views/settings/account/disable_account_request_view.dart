import 'package:adam/app_routes.dart';
import 'package:adam/auth/userAuth.dart';
import 'package:adam/constants.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/utils/custom_snackbar.dart';
import 'package:adam/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DisableAccountRequestView extends StatefulWidget {
  @override
  _DisableAccountRequestViewState createState() =>
      _DisableAccountRequestViewState();
}

class _DisableAccountRequestViewState extends State<DisableAccountRequestView> {
  final _commentController = TextEditingController();
  String _reason = "Select reason";

  bool _isDisabling = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Disable account"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              SvgPicture.asset(
                'assets/disable.svg',
                height: 100,
              ),
              const SizedBox(height: 20.0),
              Text(
                "Disable My Account!",
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(height: 10.0),
              const Text(
                "You may active your account by login again.\n\nYour data will be SAVED!",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12.0),
              DropdownButtonHideUnderline(
                child: Material(
                  elevation: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: DropdownButton(
                      isExpanded: true,
                      onChanged: (value) {
                        setState(() {
                          _reason = value;
                        });
                      },
                      value: _reason,
                      items: [
                        "Select reason",
                        "I want to take a break",
                        "I don't want any suspicious activity",
                        "Others"
                      ]
                          .map((res) =>
                              DropdownMenuItem(value: res, child: Text(res)))
                          .toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Any other comments: (Optional)"),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.89,
                child: TextFormField(
                  maxLines: 6,
                  controller: _commentController,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    hintText: "Type something...",
                    hintStyle: Theme.of(context).textTheme.caption,
                    fillColor: Provider.of<ThemeProvider>(context).darkTheme
                        ? Colors.black12
                        : Colors.grey[200],
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12),
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
              const SizedBox(height: 25.0),
              CustomButton(
                  btnWidth: 150.0,
                  btnHeight: 40.0,
                  btnOnPressed: _disableAccount,
                  btnColor: kPrimaryBlueColor,
                  btnText: _isDisabling
                      ? kLoaderWhite
                      : const Text("Submit", style: kBtnTextStyle))
            ],
          ),
        ),
      ),
    );
  }

  void _disableAccount() async {
    if (_reason.contains("Select reason")) {
      customSnackBar(
        context,
        Colors.red,
        Row(
          children: [
            const Icon(
              Icons.info,
              color: Colors.white,
            ),
            const SizedBox(
              width: 8.0,
            ),
            const Text('Please select a reason!')
          ],
        ),
      );
    } else {
      setState(() {
        _isDisabling = true;
      });

      var value = await UserAuth()
          .disableAccount(_reason, _commentController.text.trim())
          .whenComplete(() {
        setState(() {
          _isDisabling = false;
        });
      });

      if (value is String) {
        customSnackBar(
          context,
          Colors.red,
          Row(
            children: [
              const Icon(
                Icons.info,
                color: Colors.white,
              ),
              const SizedBox(
                width: 8.0,
              ),
              Text(value)
            ],
          ),
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.login,
          (route) => route.settings.name == AppRoutes.login ? true : false,
        );
        customSnackBar(
          context,
          kSecondaryBlueColor,
          Row(
            children: [
              const Icon(
                Icons.report,
                color: Colors.white,
              ),
              const SizedBox(
                width: 8.0,
              ),
              const Text('Disable account request has sent!')
            ],
          ),
        );
        await UserAuth().logout(context);
      }
    }
  }
}
