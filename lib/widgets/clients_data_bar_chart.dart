import 'package:community_charts_flutter/community_charts_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:pihole_manager/pihole_api/pihole.dart';

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
        return SizedBox(
          height: 200,
          child: BarChart(
            (snapshot.data ?? []).reversed.toList(),
            barGroupingType: BarGroupingType.stacked,
            domainAxis: const OrdinalAxisSpec(
              renderSpec: SmallTickRendererSpec(
                labelStyle: TextStyleSpec(
                  fontSize: 10,
                ),
              ),
            ),
            primaryMeasureAxis: const NumericAxisSpec(
              renderSpec: GridlineRendererSpec(
                labelStyle: TextStyleSpec(
                  fontSize: 10,
                ),
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
          id: 'Desktop',
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
          colorFn: (datum, index) => getClientColor(index ?? 0),
        ),
      );

      if (result.length == 12) break;
    }

    return result;
  }

  Color getClientColor(int index) {
    if (index < colors.length) return colors.elementAt(index);

    MaterialColor color = Colors.primaries.reversed.elementAt(index);
    colors.add(Color(r: color.red, g: color.green, b: color.blue));

    return colors.last;
  }
}

class ClientsData {
  final String time;
  final int dataList;

  ClientsData(this.time, this.dataList);
}