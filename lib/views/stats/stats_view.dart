import 'dart:math';

import 'package:adam/controller/service_controller.dart';
import 'package:adam/model/subscribed_services/subscribed_services_list.dart';
import 'package:flutter/material.dart';
import 'package:adam/constants.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

enum StatsFilter { Weekly, Monthly }

class StatsView extends StatefulWidget {
  @override
  _StatsViewState createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView> {
  StatsFilter _filter = StatsFilter.Weekly;
  String _followersDummy = "2303";

  String _currentService = "Instagram Marketing";

  List<String> _services = [
    "Instagram Marketing",
    "LinkedIn Marketing",
    "Twitter Marketing",
  ];

  // data
  // subscribed services
  List _subscribedServices = [];

  Future<void> _getServices() async {
    SubscribedServices service =
        await ServiceController().getSubscribedServices();
    setState(() {
      _subscribedServices = service.subscribedServices;
    });
  }

  @override
  void initState() {
    _getServices();
    super.initState();
  }

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
                  itemBuilder: (context) => _subscribedServices
                      .map(
                        (ser) => PopupMenuItem(
                          value: ser['serviceData']['service_name'],
                          child: Text(ser['serviceData']['service_name']),
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
            SfSparkBarChart(data: dummyData(_filter, _currentService)),
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
    if (filter == StatsFilter.Weekly) {
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
