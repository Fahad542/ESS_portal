import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';


class BarChartModel {
  final String day;
  final DateTime checkInTime;
  final String attendstatus;

  BarChartModel({
    required this.day,
    required this.checkInTime,
    required this.attendstatus,
  });
}

class HomePage extends StatefulWidget {
  final List<BarChartModel> data;
  final DateTime? end;

  HomePage({Key? key, required this.data, required this.end}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  DateTime? startTime;
  DateTime? endTime;

  @override
  void initState() {
    super.initState();
    startTime = DateFormat('HH:mm').parse('08:00');
    endTime = widget.end;
  }

  charts.Color _getColor(BarChartModel model) {
    if (model.attendstatus == "On Time") {
      return charts.MaterialPalette.green.shadeDefault;
    } else if (model.attendstatus == "Late") {
      return charts.Color(r: 255, g: 0, b: 0);
    } else {
      return charts.MaterialPalette.gray.shadeDefault;
    }
  }

  String _formatMinutesToTime(int minutes) {
    final time = startTime!.add(Duration(minutes: minutes));
    return DateFormat('HH:mm').format(time);
  }

  List<charts.Series<BarChartModel, String>> _getSeriesData() {
    return [
      charts.Series(
        id: "CheckInTime",
        data: widget.data,
        domainFn: (BarChartModel series, _) => series.day,
        measureFn: (BarChartModel series, _) {
          return series.checkInTime.difference(startTime!).inMinutes.toDouble();
        },
        colorFn: (BarChartModel model, _) => _getColor(model),
     //   labelAccessorFn: (BarChartModel series, _) => DateFormat('HH:mm').format(series.checkInTime),
      )
    ];
  }

  void _showCheckInTimeDialog(BuildContext context, BarChartModel model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Check-In Time', textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Day: ${model.day}\nCheck-In Time: ${DateFormat('HH:mm').format(model.checkInTime)}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 15),
              Icon(Icons.access_time, size: 30, color: Colors.blueAccent),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close', style: TextStyle(color: Colors.blueAccent, fontSize: 16)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(16),
          child: charts.BarChart(
            _getSeriesData(),
            animate: true,
            barRendererDecorator: charts.BarLabelDecorator<String>(
              labelPosition: charts.BarLabelPosition.outside,
              insideLabelStyleSpec: charts.TextStyleSpec(fontSize: 12, color: charts.MaterialPalette.black),
            ),
            defaultRenderer: charts.BarRendererConfig(
              groupingType: charts.BarGroupingType.stacked,
              strokeWidthPx: 0,
              maxBarWidthPx: 16,
            ),
            primaryMeasureAxis: charts.NumericAxisSpec(
              tickProviderSpec: charts.BasicNumericTickProviderSpec(
                desiredTickCount: 8,
              ),
              tickFormatterSpec: charts.BasicNumericTickFormatterSpec(
                    (num? value) {
                  if (value == null) return '';
                  return _formatMinutesToTime(value.toInt());
                },
              ),
              viewport: charts.NumericExtents(
                  0, endTime!.difference(startTime!).inMinutes.toDouble()),
              renderSpec: charts.GridlineRendererSpec(
                labelStyle: charts.TextStyleSpec(
                  fontSize: 12,
                  color: charts.MaterialPalette.black,
                ),
              ),
            ),
            domainAxis: charts.OrdinalAxisSpec(
              renderSpec: charts.SmallTickRendererSpec(
                labelStyle: charts.TextStyleSpec(
                  fontSize: 6,
                  color: charts.MaterialPalette.black,
                ),
              ),
            ),
            selectionModels: [
              charts.SelectionModelConfig(
                type: charts.SelectionModelType.info,
                changedListener: (charts.SelectionModel model) {
                  if (model.hasDatumSelection) {
                    final selectedDatum = model.selectedDatum[0].datum as BarChartModel;
                    _showCheckInTimeDialog(context, selectedDatum);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

