import 'package:adam/constants.dart';
import 'package:adam/controller/theme_controller/theme_provider.dart';
import 'package:adam/views/services/instagram/instagram_account_scheduler.dart';
import 'package:adam/views/services/instagram/instagram_marketing_view.dart';
import 'package:adam/widgets/non_premium_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InstagramView extends StatefulWidget {
  final bool isPrem;

  const InstagramView({Key key, @required this.isPrem}) : super(key: key);
  @override
  _InstagramViewState createState() => _InstagramViewState();
}

class _InstagramViewState extends State<InstagramView> {
  int _currentIndex = 0;

  Widget _buildView(int index, bool isPremium) {
    if (index == 0) {
      return InstagramMarketingView();
    } else if (index == 1 && isPremium) {
      return InstagramAccountScheduler();
    } else {
      return NonPremiumView();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _themeProviders = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: _buildView(_currentIndex, widget.isPrem),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor:
            _themeProviders.darkTheme ? Colors.white : kPrimaryBlueColor,
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
            label: 'Scheduler',
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
