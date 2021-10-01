import 'package:adam/constants.dart';
import 'package:adam/controller/themeController/themeProvider.dart';
import 'package:adam/views/services/linkedin/linkedin_account_scheduler.dart';
import 'package:adam/views/services/linkedin/linkedin_marketing_view.dart';
import 'package:adam/widgets/non_premium.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LinkedinView extends StatefulWidget {
  final bool isPrem;

  const LinkedinView({Key key, @required this.isPrem}) : super(key: key);
  @override
  _LinkedinViewState createState() => _LinkedinViewState();
}

class _LinkedinViewState extends State<LinkedinView> {
  int _currentIndex = 0;

  Widget _buildView(int index, bool isPremium) {
    if (index == 0) {
      return LinkedinMarketingView();
    } else if (index == 1 && isPremium) {
      return LinkedinAccountScheduler();
    } else {
      return NonPremiumView();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _themeProviders = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: _buildView(_currentIndex, widget.isPrem),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: _themeProviders.darkTheme ? Colors.white : kPrimaryBlueColor,
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Marketing',
            icon: Icon(Icons.location_city),
          ),
          BottomNavigationBarItem(
            label: ' Scheduler',
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
