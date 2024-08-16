import 'package:flutter/material.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:pihole_manager/models/clients_data.dart';
import 'package:pihole_manager/pihole_api/pihole.dart';
import 'package:pihole_manager/utils/colors_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OverTimeDataChart extends StatefulWidget {
  const OverTimeDataChart({super.key});

  @override
  State<StatefulWidget> createState() => _OverTimeDataChart();
}

class _OverTimeDataChart extends State<OverTimeDataChart> {
  Pihole pihole = GetIt.instance.get<Pihole>();
  final List<Color> colors = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getOverTimeData(),
      builder:
          (context, AsyncSnapshot<List<Series<ClientsData, String>>> snapshot) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Card(
            child: SizedBox(
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 4.0, left: 8.0),
                    child: Text(AppLocalizations.of(context)?.topQueries ?? ''),
                  ),
                  const Divider(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: BarChart(
                        (snapshot.data ?? []).reversed.toList(),
                        barGroupingType: BarGroupingType.stacked,
                        domainAxis: OrdinalAxisSpec(
                          renderSpec: SmallTickRendererSpec(
                            labelStyle: TextStyleSpec(
                              fontSize: 10,
                              color: ColorsUtils.getColor2(
                                Theme.of(context).hintColor,
                              ),
                            ),
                            lineStyle: LineStyleSpec(
                              color: ColorsUtils.getColor2(
                                Theme.of(context).hintColor,
                              ),
                            ),
                          ),
                        ),
                        primaryMeasureAxis: NumericAxisSpec(
                          renderSpec: GridlineRendererSpec(
                            labelStyle: TextStyleSpec(
                              fontSize: 10,
                              color: ColorsUtils.getColor2(
                                Theme.of(context).hintColor,
                              ),
                            ),
                            lineStyle: LineStyleSpec(
                              color: ColorsUtils.getColor2(
                                Theme.of(context).hintColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<List<Series<ClientsData, String>>> _getOverTimeData() async {
    Map<String, dynamic> data = await pihole.getOverTimeData10mins();

    Map<String, int> domainOverTime = {};
    if (data['domains_over_time'] is Map) {
      data['domains_over_time'].forEach((key, value) {
        if (key is String && value is int) {
          domainOverTime[key] = value;
        }
      });
    }

    Map<String, int> adsOverTime = {};
    if (data['ads_over_time'] is Map) {
      data['ads_over_time'].forEach((key, value) {
        if (key is String && value is int) {
          adsOverTime[key] = value;
        }
      });
    }

    List<Series<ClientsData, String>> result = [];

    for (int i = domainOverTime.entries.length - 1; i >= 0; i--) {
      MapEntry<String, int> domain = domainOverTime.entries.elementAt(i);
      MapEntry<String, int> ad = adsOverTime.entries.elementAt(i);

      result.add(
        Series<ClientsData, String>(
          id: 'OverTimeDataChart',
          domainFn: (ClientsData data, _) => DateFormat('HH:mm').format(
            DateTime.fromMillisecondsSinceEpoch(
              (int.tryParse(data.time) ?? 0) * 1000,
            ),
          ),
          measureFn: (ClientsData data, _) => data.dataList,
          data: [
            ClientsData(ad.key, ad.value),
            ClientsData(domain.key, domain.value),
          ],
          colorFn: (datum, index) => index == 0
              ? ColorsUtils.getColor(Colors.grey)
              : ColorsUtils.getColor(Colors.green),
        ),
      );

      if (result.length == 12) break;
    }

    return result;
  }
}
