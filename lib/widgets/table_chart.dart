import 'package:flutter/material.dart';
import 'package:progress_bar_chart/progress_bar_chart.dart';

class TableChart extends StatelessWidget {
  final Map<String, dynamic> data;

  const TableChart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    double maxValue = 0;
    for (int element in data.values) {
      maxValue += element;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
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
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.intrinsicHeight,
          children: data.entries.map(
            (MapEntry<String, dynamic> entry) {
              return TableRow(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(!entry.key.contains('|')
                          ? entry.key
                          : entry.key.split('|').first),
                      Text('Hits: ${entry.value.toString()}'),
                    ],
                  ),
                  ProgressBarChart(
                    values: [
                      StatisticsItem(
                        Colors.green,
                        entry.value.toDouble(),
                      )
                    ],
                    height: 10,
                    borderRadius: 10,
                    totalPercentage: maxValue,
                    showLables: false,
                  ),
                ],
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
