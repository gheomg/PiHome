import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:pihole_manager/pihole_api/pihole.dart';

class Network extends StatefulWidget {
  final Widget drawer;
  const Network({
    super.key,
    required this.drawer,
  });

  @override
  State<StatefulWidget> createState() => _NetworkState();
}

class _NetworkState extends State<Network> {
  Pihole pihole = GetIt.instance.get<Pihole>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Network',
        ),
      ),
      drawer: widget.drawer,
      body: FutureBuilder(
        future: pihole.getNetwork(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          Map<String, dynamic> data = snapshot.data ?? {};
          List<dynamic> network = [];
          if (data.containsKey('network')) {
            network = data['network'];
          }
          network.sort((a, b) => b['lastQuery'].compareTo(a['lastQuery']));

          return ListView.builder(
            itemCount: network.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> itemData = network[index];

              dynamic ipData = itemData['ip'];
              List<String> ips = [];
              if (ipData is List) {
                for (var element in ipData) {
                  ips.add(element);
                  if (ips.length > 1) break;
                }
              }

              dynamic nameData = itemData['name'];
              List<String> names = [];
              if (nameData is List) {
                for (var element in nameData) {
                  names.add(element);
                }
              }

              int lastQuery = itemData['lastQuery'] ?? 0;
              DateTime lastSeen = DateTime.fromMillisecondsSinceEpoch(
                (int.tryParse(lastQuery.toString()) ?? 0) * 1000,
              );
              DateTimeRange range = DateTimeRange(
                start: lastSeen,
                end: DateTime.now(),
              );

              Color? cardColor = getCardColor(range, lastQuery);

              return Card(
                color: cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MAC Address: ${itemData['hwaddr'] ?? ''}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text('Interface: ${itemData['interface'] ?? ''}'),
                      const Text('IP Addresses:'),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: ips.map(
                          (ip) {
                            String name = names.elementAt(ips.indexOf(ip));
                            if (name.isNotEmpty) {
                              name = ' ($name)';
                            }

                            return Text(
                              '  - $ip$name',
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          },
                        ).toList(),
                      ),
                      Text(
                        'First Seen: ${DateFormat().format(
                          DateTime.fromMillisecondsSinceEpoch(
                            (int.tryParse(
                                      (itemData['firstSeen'] ?? '').toString(),
                                    ) ??
                                    0) *
                                1000,
                          ),
                        )}',
                      ),
                      Text(
                        'Last Query: ${DateFormat().format(lastSeen)}',
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text('Queries Made: ${itemData['numQueries']}'),
                      if ((itemData['macVendor'] ?? '').toString().isNotEmpty)
                        Text(
                          'MAC Vendor: ${itemData['macVendor']}',
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Color? getCardColor(DateTimeRange range, int lastQuery) {
    Color? cardColor;
    if (range.duration.inHours <= 1) {
      cardColor = const Color.fromRGBO(76, 175, 80, 1);
    } else if (range.duration.inHours <= 2) {
      cardColor = const Color.fromRGBO(139, 195, 74, 1);
    } else if (range.duration.inHours <= 12) {
      cardColor = const Color.fromRGBO(205, 220, 57, 1);
    } else if (range.duration.inHours <= 24) {
      cardColor = const Color.fromRGBO(255, 235, 59, 1);
    } else if (range.duration.inHours > 24) {
      if (lastQuery == 0) {
        cardColor = const Color.fromRGBO(244, 67, 54, 1);
      } else {
        cardColor = const Color.fromRGBO(255, 152, 0, 1);
      }
    }

    return cardColor;
  }
}
