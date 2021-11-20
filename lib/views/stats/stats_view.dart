import 'dart:math';

import 'package:flutter/material.dart';
import 'package:adam/constants.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

enum StatsFilter { Daily, Weekly, Monthly }

class StatsView extends StatefulWidget {
  @override
  _StatsViewState createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView> {
  StatsFilter _filter = StatsFilter.Daily;
  String _followersDummy = "2303";

  String _currentService = "Instagram Marketing";

  List<String> _services = [
    "Instagram Marketing",
    "LinkedIn Marketing",
    "Twitter Marketing",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _currentService,
                  style: Theme.of(context).textTheme.headline1,
                ),
                PopupMenuButton(
                  onSelected: (value) {
                    setState(() {
                      _currentService = value;
                    });
                    _generateDummyFollowers();
                  },
                  itemBuilder: (context) => _services
                      .map(
                        (ser) => PopupMenuItem(
                          value: ser,
                          child: Text(ser),
                        ),
                      )
                      .toList(),
                )
              ],
            ),
            const SizedBox(height: 40.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.arrow_drop_up,
                  size: 30,
                  color: kLightGreenColor,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _followersDummy,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                    ),
                    const Text(
                      'Followers',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 30.0),
            SfSparkBarChart(
              data: dummyData(_filter, _currentService)
            ),
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                    value: StatsFilter.Daily,
                    groupValue: _filter,
                    onChanged: (value) {
                      setState(() {
                        _filter = value;
                      });
                    }),
                const Text("Daily"),
                Radio(
                    value: StatsFilter.Weekly,
                    groupValue: _filter,
                    onChanged: (value) {
                      setState(() {
                        _filter = value;
                      });
                    }),
                const Text("Weekly"),
                Radio(
                    value: StatsFilter.Monthly,
                    groupValue: _filter,
                    onChanged: (value) {
                      setState(() {
                        _filter = value;
                      });
                    }),
                const Text("Monthly"),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _generateDummyFollowers() => setState(() {
        _followersDummy = (Random().nextInt(3500) + 200).toString();
      });

  List<int> dummyData(StatsFilter filter, String marketing) {
    if (filter == StatsFilter.Daily) {
      if (marketing == _services[0]) {
        return _instaListD;
      } else if (marketing == _services[1]) {
        return _twitterListD;
      } else {
        return _linkedInListD;
      }
    } else if (filter == StatsFilter.Weekly) {
      if (marketing == _services[0]) {
        return _instaListW;
      } else if (marketing == _services[1]) {
        return _twitterListW;
      } else {
        return _linkedInListW;
      }
    } else {
      if (marketing == _services[0]) {
        return _instaListM;
      } else if (marketing == _services[1]) {
        return _twitterListM;
      } else {
        return _linkedInListM;
      }
    }
  }

  // dummy data
  List<int> _instaListD = [51, 11, 21, 73, 14, 25];
  List<int> _twitterListD = [44, 34, 22, 22, 19, 37];
  List<int> _linkedInListD = [35, 61, 73, 15, 54];

  List<int> _instaListW = [51, 11, 21, 12, 73, 14, 25];
  List<int> _twitterListW = [44, 33, 34, 22, 22, 19, 37];
  List<int> _linkedInListW = [35, 61, 22, 82, 73, 15, 54];

  List<int> _instaListM = [
    51,
    11,
    21,
    12,
    73,
    14,
    25,
    51,
    11,
    21,
    12,
    73,
    14,
    25,
    51,
    11,
    21,
    12,
    73,
    14,
    25,
    51,
    11,
    21,
    12,
    73,
    14,
    25,
    22,
    12
  ];
  List<int> _twitterListM = [
    44,
    33,
    34,
    22,
    22,
    19,
    37,
    44,
    33,
    34,
    22,
    22,
    19,
    37,
    44,
    33,
    34,
    22,
    22,
    19,
    37,
    44,
    33,
    34,
    22,
    22,
    19,
    37,
    44,
    22,
  ];
  List<int> _linkedInListM = [
    35,
    61,
    22,
    82,
    73,
    15,
    54,
    35,
    61,
    22,
    82,
    73,
    15,
    54,
    35,
    61,
    22,
    82,
    73,
    15,
    54,
    35,
    61,
    22,
    82,
    73,
    15,
    54,
    21,
    22
  ];
}
