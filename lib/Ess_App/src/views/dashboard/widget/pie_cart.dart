import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class PieCharNewData {
  final String title;

  PieCharNewData({required this.title});
}

class PieCharNew extends StatelessWidget {
  final Map<String, double> dataMap;
  const PieCharNew({Key? key, required this.dataMap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PieChart(
        dataMap: dataMap,
        animationDuration: Duration(milliseconds: 2800),
        chartLegendSpacing: 40,
        chartRadius: MediaQuery.of(context).size.width / 2.5,
        initialAngleInDegree: 0,
        chartType: ChartType.ring,
        ringStrokeWidth: 30,
        colorList: [
          // Define a custom gradient for each color
          ColorTween(begin: Colors.green[800], end: Color(0xff0dda17)).lerp(0.5)!,
          ColorTween(begin: Color(0xfff51604), end: Color(0xfff51604)).lerp(0.5)!,
        ],
        legendOptions: LegendOptions(
          showLegendsInRow: false,
          legendPosition: LegendPosition.right,
          showLegends: true,
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: AppColors.primary,
          ),
        ),
        chartValuesOptions: ChartValuesOptions(
          showChartValueBackground: true,
          showChartValues: true,
          showChartValuesInPercentage: false,
          showChartValuesOutside: false,
          decimalPlaces: 1,
          chartValueStyle: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}





