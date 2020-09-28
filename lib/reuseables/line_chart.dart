import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:nepal_stock/models/time_value_model.dart';
import 'package:nepal_stock/styles/colors.dart';

class CustomLineChart extends StatefulWidget {
  final List<TimeValueModel> data;
  const CustomLineChart({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  _CustomLineChartState createState() => _CustomLineChartState();
}

class _CustomLineChartState extends State<CustomLineChart> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<TimeValueModel, DateTime>> series = [
      charts.Series(
        id: "timeValue",
        data: widget.data,
        domainFn: (TimeValueModel time, _) => time.time,
        measureFn: (TimeValueModel value, _) => value.value,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(kColorGreen),
      ),
    ];
    return charts.TimeSeriesChart(
      series,
      animate: true,
      primaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(
            color: charts.ColorUtil.fromDartColor(Theme.of(context).textTheme.caption.color),
          ),
        ),
        tickProviderSpec: charts.NumericEndPointsTickProviderSpec(),
      ),
      domainAxis: charts.DateTimeAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(
            color: charts.ColorUtil.fromDartColor(Theme.of(context).textTheme.caption.color),
          ),
        ),
      ),
    );
  }
}
