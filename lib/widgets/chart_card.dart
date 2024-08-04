import 'package:community_charts_flutter/community_charts_flutter.dart';
import 'package:flutter/material.dart';
import 'package:pihole_manager/models/chart_data.dart';
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
      child: Container(
        height: 220,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 4.0, left: 8.0),
              child: Text(title),
            ),
            const Divider(
              thickness: 0.5,
              color: Colors.black12,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 35.0),
                child: PieChart<String>(
                  _createSampleData(),
                  animate: true,
                  defaultRenderer: ArcRendererConfig(
                    arcWidth: 35,
                  ),
                  behaviors: [
                    DatumLegend(
                      position: BehaviorPosition.end,
                      cellPadding:
                          const EdgeInsets.only(right: 4.0, bottom: 4.0),
                      legendDefaultMeasure: LegendDefaultMeasure.firstValue,
                      horizontalFirst: false,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Series<ChartData, String>> _createSampleData() {
    return [
      Series<ChartData, String>(
        id: 'Sales',
        domainFn: (ChartData data, index) => data.name.split('|').last,
        measureFn: (ChartData data, _) => data.value,
        colorFn: (_, int? index) =>
            ColorsUtils.getClientColor(colors, index ?? 0),
        data: dataMap.entries
            .map(
              (entry) => ChartData(
                entry.key,
                entry.value,
              ),
            )
            .toList(),
      ),
    ];
  }
}
