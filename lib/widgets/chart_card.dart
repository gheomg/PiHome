import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:pihole_manager/utils/colors_utils.dart';

class ChartCard extends StatelessWidget {
  final List<Color> colors = [];
  final Map<String, double> dataMap;
  final Map<String, String>? legendLabels;

  ChartCard({
    super.key,
    required this.dataMap,
    this.legendLabels,
  }) {
    loadColor();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
            ),
          ],
        ),
        child: PieChart(
          dataMap: dataMap,
          chartLegendSpacing: 32,
          chartRadius: MediaQuery.of(context).size.width / 3.2,
          initialAngleInDegree: 270,
          chartType: ChartType.ring,
          ringStrokeWidth: 32,
          legendOptions: const LegendOptions(
            showLegendsInRow: false,
            legendPosition: LegendPosition.right,
            showLegends: true,
            legendShape: BoxShape.circle,
            legendTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          legendLabels: legendLabels ?? {},
          chartValuesOptions: const ChartValuesOptions(
            showChartValues: false,
          ),
          colorList: colors,
        ),
      ),
    );
  }

  void loadColor() {
    int index = 0;
    dataMap.forEach(
      (key, value) {
        if (index > colors.length - 1) {
          MaterialColor color = ColorsUtils.colors.elementAt(index);
          colors.add(color);
        }
        index++;
      },
    );
  }
}
