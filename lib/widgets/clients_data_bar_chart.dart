import 'package:community_charts_flutter/community_charts_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:pihole_manager/models/clients_data.dart';
import 'package:pihole_manager/pihole_api/pihole.dart';
import 'package:pihole_manager/utils/colors_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ClientsDataBarChart extends StatefulWidget {
  const ClientsDataBarChart({
    super.key,
  });

  @override
  State<ClientsDataBarChart> createState() => _ClientsDataBarChartState();
}

class _ClientsDataBarChartState extends State<ClientsDataBarChart> {
  Pihole pihole = GetIt.instance.get<Pihole>();
  final List<Color> colors = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getOverTimeDataClients(),
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
                    child: Text(
                      AppLocalizations.of(context)?.clientActivity ?? '',
                    ),
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

  Future<List<Series<ClientsData, String>>> _getOverTimeDataClients() async {
    Map<String, dynamic> overTimeDataClients =
        await pihole.getOverTimeDataClients();

    List<Map<String, String>> clients = [];
    for (var client in overTimeDataClients['clients']) {
      if (client is Map) {
        Map<String, String> clientMap = {};
        client.forEach((key, value) {
          if (key is String && value is String) {
            clientMap[key] = value;
          }
        });
        clients.add(clientMap);
      }
    }

    Map<String, List<dynamic>> overTime = {};
    if (overTimeDataClients['over_time'] is Map) {
      overTimeDataClients['over_time'].forEach((key, value) {
        if (key is String && value is List<dynamic>) {
          overTime[key] = value;
        }
      });
    }
    List<Series<ClientsData, String>> result = [];
    for (MapEntry<String, List<dynamic>> time
        in overTime.entries.toList().reversed) {
      result.add(
        Series<ClientsData, String>(
          id: 'ClientsData',
          domainFn: (ClientsData data, _) => DateFormat('HH:mm').format(
            DateTime.fromMillisecondsSinceEpoch(
              (int.tryParse(data.time) ?? 0) * 1000,
            ),
          ),
          measureFn: (ClientsData data, _) => data.dataList,
          data: time.value
              .where((element) => element is int && element != 0)
              .map((e) => ClientsData(time.key, e))
              .toList(),
          colorFn: (datum, index) =>
              ColorsUtils.getClientColor(colors, index ?? 0),
        ),
      );

      if (result.length == 12) break;
    }

    return result;
  }
}
