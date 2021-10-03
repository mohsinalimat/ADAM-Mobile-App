import 'dart:math';

import 'package:adam/constants.dart';
import 'package:adam/views/stats/chart_view.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

enum StatsFilter { Daily, Weekly, Monthly }

class StatsView extends StatefulWidget {
  @override
  _StatsViewState createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView> {
  // StatsFilter _filter = StatsFilter.Weekly;
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
                  initialValue: _currentService,
                  child: Icon(
                    Icons.more_vert,
                    size: 30,
                  ),
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
                ),
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
            SizedBox(
              height: 300.0,
              child: BadgeBarChart(
                data: _currentService == _services[0]
                    ? _dataInstagram
                    : _currentService == _services[1]
                        ? _dataLinkedIn
                        : _dataTwitter,
              ),
            ),
            const SizedBox(height: 20.0),
            // Center(
            //   child: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       Radio(
            //         value: StatsFilter.Daily,
            //         groupValue: _filter,
            //         onChanged: (value) {
            //           setState(() {
            //             _filter = value;
            //           });
            //         },
            //       ),
            //       const Text("Daily"),
            //       Radio(
            //         value: StatsFilter.Weekly,
            //         groupValue: _filter,
            //         onChanged: (value) {
            //           setState(() {
            //             _filter = value;
            //           });
            //         },
            //       ),
            //       const Text("Weekly"),
            //       Radio(
            //         value: StatsFilter.Monthly,
            //         groupValue: _filter,
            //         onChanged: (value) {
            //           setState(() {
            //             _filter = value;
            //           });
            //         },
            //       ),
            //       const Text("Monthly"),
            //     ],
            //   ),
            // ),
     
          ],
        ),
      ),
    );
  }

  void _generateDummyFollowers() => setState(() {
        _followersDummy = (Random().nextInt(3500) + 200).toString();
      });

  // daily
  List<BarChartModel> _dataInstagram = [
    BarChartModel(
      barColor: charts.ColorUtil.fromDartColor(kSecondaryBlueColor),
      followerName: "hmz",
      followers: 22,
    ),
    BarChartModel(
      barColor: charts.ColorUtil.fromDartColor(kSecondaryBlueColor),
      followerName: "aa",
      followers: 12,
    ),
    BarChartModel(
      barColor: charts.ColorUtil.fromDartColor(kSecondaryBlueColor),
      followerName: "hsssmz",
      followers: 36,
    ),
  ];

  List<BarChartModel> _dataTwitter = [
    BarChartModel(
      barColor: charts.ColorUtil.fromDartColor(kSecondaryBlueColor),
      followerName: "hmz",
      followers: 82,
    ),
    BarChartModel(
      barColor: charts.ColorUtil.fromDartColor(kSecondaryBlueColor),
      followerName: "aa",
      followers: 33,
    ),
    BarChartModel(
      barColor: charts.ColorUtil.fromDartColor(kSecondaryBlueColor),
      followerName: "hsssmz",
      followers: 32,
    ),
  ];

  List<BarChartModel> _dataLinkedIn = [
    BarChartModel(
      barColor: charts.ColorUtil.fromDartColor(kSecondaryBlueColor),
      followerName: "hmz",
      followers: 11,
    ),
    BarChartModel(
      barColor: charts.ColorUtil.fromDartColor(kSecondaryBlueColor),
      followerName: "aa",
      followers: 19,
    ),
    BarChartModel(
      barColor: charts.ColorUtil.fromDartColor(kSecondaryBlueColor),
      followerName: "hsssmz",
      followers: 32,
    ),
  ];
}
