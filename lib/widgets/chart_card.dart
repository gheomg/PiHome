import 'package:flutter/material.dart';
import 'package:gauge_chart/gauge_chart.dart';
import 'package:pihole_manager/utils/colors_utils.dart';

class ChartCard extends StatelessWidget {
  final List<Color> colors = [];
  final Map<String, double> dataMap;
  final String title;

  ChartCard({
    super.key,
    required this.dataMap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        child: SizedBox(
          height: 220,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: RepaintBoundary(
              child: GaugeChart(
                children: dataMap.entries.map(
                  (e) {
                    return PieData(
                      value: e.value,
                      color: ColorsUtils.colors.elementAt(
                        dataMap.keys.toList().indexOf(e.key),
                      ),
                      description: e.key.split('|').first,
                    );
                  },
                ).toList(),
                gap: 10,
                animateDuration: const Duration(seconds: 1),
                shouldAnimate: true,
                animateFromEnd: false,
                isHalfChart: false,
                size: 150,
                showValue: false,
                borderWidth: 25,
                showLegend: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
