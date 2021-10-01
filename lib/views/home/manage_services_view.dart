import 'package:adam/animations/bottomAnimation.dart';
import 'package:adam/constants.dart';
import 'package:adam/controller/serviceController.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/widgets/logoDisplay.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageServicesView extends StatefulWidget {
  final List services;

  const ManageServicesView({Key key, this.services}) : super(key: key);
  @override
  _ManageServicesViewState createState() => _ManageServicesViewState();
}

class _ManageServicesViewState extends State<ManageServicesView> {
  bool _isUnsub = false;
  @override
  Widget build(BuildContext context) {
    final _themeProviders = Provider.of<ThemeProvider>(context);
    return AbsorbPointer(
      absorbing: _isUnsub,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BackButton(
                        onPressed: () => Navigator.pop(context),
                      ),
                      const LogoDisplay(),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Manage Your Services",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 5.0),
                  const Text("Uplift your business game!"),
                  const SizedBox(height: 20.0),
                  widget.services.length == 0
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Center(
                            child: const Text(
                                'No Services has been subscribed yet!'),
                          ),
                        )
                      : ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: List.generate(
                            widget.services.length,
                            (index) => WidgetAnimator(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                    color: _themeProviders.darkTheme
                                        ? Colors.grey[800]
                                        : Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(0, 2.0),
                                        blurRadius: 8.0,
                                        spreadRadius: 8.0,
                                      )
                                    ]),
                                height: 115.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Diagonal(
                                          clipHeight: 20.0,
                                          axis: Axis.vertical,
                                          position: DiagonalPosition.TOP_RIGHT,
                                          child: Container(
                                            height: 30.0,
                                            width: 150,
                                            color: widget.services[index]
                                                    ['isPremium']
                                                ? kLightGreenColor
                                                : kLightBlueColor,
                                            child: Center(
                                              child: Text(
                                                widget.services[index]
                                                        ['isPremium']
                                                    ? "Premium"
                                                    : "Standard",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () => _unSubscribe(index),
                                          child: const Text(
                                            "Unsubscribe",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      widget.services[index]['serviceData']
                                          ['service_name'],
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500,
                                          color: _themeProviders.darkTheme
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    const SizedBox(height: 5.0),
                                    const Text('Renew Subscription: 29-12-2022')
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _unSubscribe(int index) async {
    setState(() {
      _isUnsub = true;
    });

    var unsubSnackbar = SnackBar(
      backgroundColor: Colors.red,
      content: Row(
        children: [
          SizedBox(
            height: 20.0,
            width: 20.0,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          ),
          const SizedBox(width: 8.0),
          const Text("Unsubscribing..."),
        ],
      ),
    );

    var completedSnackBar = SnackBar(
      backgroundColor: kSecondaryBlueColor,
      content: Row(
        children: [
          const Icon(
            Icons.check,
            color: Colors.white,
          ),
          const SizedBox(width: 8.0),
          Text(
              "${widget.services[index]['serviceData']['service_name']} has been Unsubscribed!"),
        ],
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(unsubSnackbar);

    int code = await ServiceController()
        .unsubscribeService(
      widget.services[index]['serviceData']['_id'],
    )
        .whenComplete(() {
      setState(() {
        _isUnsub = false;
      });
    });

    if (code == 200) {
      setState(() {
        widget.services.remove(widget.services[index]);
      });
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(completedSnackBar);
    }
  }
}
