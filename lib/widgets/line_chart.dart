import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:nepal_stock/models/time_value_model.dart';
import 'package:nepal_stock/styles/colors.dart';

class CustomLineChart extends StatefulWidget {
  final List<TimeValueModel> data;
  final double min;
  final double max;
  const CustomLineChart({
    Key key,
    @required this.data,
    this.min = 0,
    this.max = 2000,
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
            color: charts.ColorUtil.fromDartColor(kColorGrey2),
          ),
        ),
        tickProviderSpec: charts.StaticNumericTickProviderSpec(
          <charts.TickSpec<num>>[
            charts.TickSpec<num>(this.widget.max +
                ((this.widget.min + this.widget.max) * 0.5) * 0.0005),
            charts.TickSpec<num>((this.widget.min + this.widget.max) * 0.5),
            charts.TickSpec<num>(this.widget.min -
                ((this.widget.min + this.widget.max) * 0.5) * 0.0005),
          ],
        ),
      ),
      domainAxis: charts.DateTimeAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(
            color: charts.ColorUtil.fromDartColor(kColorGrey2),
          ),
        ),
      ),
    );
  }
}
