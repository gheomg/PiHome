import 'package:flutter/material.dart';
import 'package:progress_bar_chart/progress_bar_chart.dart';

class TableChart extends StatelessWidget {
  final Map<String, dynamic> data;
  final String title;
  final String infoLabel;

  const TableChart({
    super.key,
    required this.data,
    required this.title,
    required this.infoLabel,
  });

  @override
  Widget build(BuildContext context) {
    double maxValue = 0;
    for (int element in data.values) {
      maxValue += element;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 4.0, left: 8.0),
              child: Text(title),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                bottom: 8.0,
              ),
              child: Table(
                defaultVerticalAlignment:
                    TableCellVerticalAlignment.intrinsicHeight,
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
                },
                children: data.entries.map(
                  (MapEntry<String, dynamic> entry) {
                    return TableRow(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              !entry.key.contains('|')
                                  ? entry.key
                                  : entry.key.split('|').first,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              '$infoLabel: ${entry.value.toString()}',
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Theme.of(context).hintColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            alignment: Alignment.center,
                            child: ProgressBarChart(
                              values: [
                                StatisticsItem(
                                  Colors.green,
                                  entry.value.toDouble(),
                                ),
                              ],
                              height: 10,
                              borderRadius: 10,
                              totalPercentage: maxValue,
                              showLables: false,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
