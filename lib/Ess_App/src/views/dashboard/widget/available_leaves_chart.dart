import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartSample extends StatefulWidget {
  final Map<String, double> dataMap;

  const PieChartSample({
    Key? key,
    required this.dataMap,
  }) : super(key: key);

  @override
  _PieChartSampleState createState() => _PieChartSampleState();
}

class _PieChartSampleState extends State<PieChartSample> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  pieTouchResponse == null ||
                  pieTouchResponse.touchedSection == null) {
                touchedIndex = -1;
                return;
              }
              touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
            });
          },
        ),
        borderData: FlBorderData(show: false),
        sectionsSpace: 0,
        centerSpaceRadius: 40,
        sections: showingSections(),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    final sections = <PieChartSectionData>[];

    // Loop through the categories in the dataMap
    widget.dataMap.forEach((key, value) {
      final index = sections.length;
      final isTouched = index == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;

      // Define colors based on category
      final Color baseColor = getCategoryColor(key);

      sections.add(
        PieChartSectionData(
          color: baseColor,
          value: value,
          title: '${value.toStringAsFixed(1)}%', // Showing the percentage value
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
          ),
          badgeWidget: getCategoryBadge(key), // Add badge for all categories
          badgePositionPercentageOffset: .98,
          titlePositionPercentageOffset: isTouched ? 0.6 : 0.5,
        ),
      );
    });

    return sections;
  }

  // Function to get color for each category
  Color getCategoryColor(String category) {
    switch (category) {
      case "Strongly Agree":
        return Colors.green;
      case "Agree":
        return Colors.blue;
      case "Disagree":
        return Colors.red;
      case "Strongly Disagree":
        return Colors.black;
      default:
        return Colors.grey; // Default color
    }
  }

  // Function to return a badge for each category
  Widget getCategoryBadge(String category) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Text(
        category, // Display the category name as the badge
        style: TextStyle(
          color: getCategoryColor(category), // Color based on category
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
