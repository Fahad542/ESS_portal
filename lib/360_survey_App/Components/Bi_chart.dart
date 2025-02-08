import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


class PieChartSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: PieChart(
        PieChartData(
          sections: showingSections(),
          borderData: FlBorderData(show: false),
          centerSpaceRadius: 40,
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return [
      PieChartSectionData(
        color: Colors.blue,
        value: 40,
        title: 'Blue\n40%',
        radius: 60,
      ),
      PieChartSectionData(
        color: Colors.red,
        value: 30,
        title: 'Red\n30%',
        radius: 60,
      ),
      PieChartSectionData(
        color: Colors.green,
        value: 20,
        title: 'Green\n20%',
        radius: 60,
      ),
      PieChartSectionData(
        color: Colors.yellow,
        value: 10,
        title: 'Yellow\n10%',
        radius: 60,
      ),
    ];
  }
}
