import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BarChartModel {
  final String followerName;
  final int followers;
  final charts.Color barColor;

  BarChartModel({this.followerName, this.followers, this.barColor});
}

class BadgeBarChart extends StatelessWidget {
  final List<BarChartModel> data;

  const BadgeBarChart({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<charts.Series<BarChartModel, String>> series = [
      charts.Series(
        id: "followers",
        data: data,
        domainFn: (BarChartModel model, _) => model.followerName,
        measureFn: (BarChartModel model, _) => model.followers,
        colorFn: (BarChartModel model, _) => model.barColor,
      )
    ];

    return charts.BarChart(
      series,
      animate: true,
      defaultRenderer: charts.BarRendererConfig(maxBarWidthPx: 50),
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: new charts.SmallTickRendererSpec(
          labelRotation: 15,
          minimumPaddingBetweenLabelsPx: 0,
          labelStyle: new charts.TextStyleSpec(
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
