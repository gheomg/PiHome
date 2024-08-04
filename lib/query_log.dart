import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:pihole_manager/pihole_api/pihole.dart';
import 'package:pihole_manager/widgets/log_status.dart';

class QueryLog extends StatefulWidget {
  const QueryLog({super.key});

  @override
  State<QueryLog> createState() => _QueryLogState();
}

class _QueryLogState extends State<QueryLog> {
  Pihole pihole = GetIt.instance.get<Pihole>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: pihole.getAllQueries(),
        builder: (context, snapshot) {
          if (snapshot.data == null) return Container();

          List<dynamic> data = snapshot.data!['data'] ?? [];

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              dynamic item = data.elementAt(index);
              List<String> values = [];
              if (item is List) {
                for (var element in item) {
                  values.add(element);
                }
              }

              return Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LogStatus(
                            status: values.elementAt(4),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              DateFormat('HH:mm:ss').format(
                                DateTime.fromMillisecondsSinceEpoch(
                                  (int.tryParse(values.elementAt(0)) ?? 0) *
                                      1000,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        values.elementAt(2),
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            values.elementAt(3),
                            style: const TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ],
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
}
