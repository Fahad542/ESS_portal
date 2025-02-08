import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../Models/Result_model.dart';

import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import '../Models/Result_model.dart';

class Chart extends StatelessWidget {
  final ResultModel data;

  Chart({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          constraints: BoxConstraints.expand(),
          child: BarChart(
            _createSampleData(),
            animate: true,
          ),
        ),
      ),
    );
  }

  // Sample data for the chart
  List<charts.Series<Map<String, dynamic>, String>> _createSampleData() {
    List<Map<String, dynamic>> chartData = [
      {'response': 'Strongly Agree', 'value': data.stronglyAgree},
      {'response': 'Agree', 'value': data.agree},
      {'response': 'Disagree', 'value': data.disAgree},
      {'response': 'Strongly Disagree', 'value': data.stronglyDisagree},
    ];

    return [
      charts.Series<Map<String, dynamic>, String>(
        id: 'Survey Responses',
        colorFn: (Map<String, dynamic> response, __) {
          switch (response['response']) {
            case 'Strongly Agree':
              return charts.MaterialPalette.green.shadeDefault; // Green for Strongly Agree
            case 'Agree':
              return charts.MaterialPalette.blue.shadeDefault; // Blue for Agree
            case 'Disagree':
              return charts.MaterialPalette.red.shadeDefault; // Red for Disagree
            case 'Strongly Disagree':
              return charts.MaterialPalette.black; // Orange for Strongly Disagree
            default:
              return charts.MaterialPalette.gray.shadeDefault; // Default color
          }
        },
        domainFn: (Map<String, dynamic> response, _) => response['response'],
        measureFn: (Map<String, dynamic> response, _) => int.tryParse(response['value']) ?? 0,
        data: chartData,
      )
    ];
  }
}



