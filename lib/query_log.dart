import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:pihole_manager/pihole_api/pihole.dart';

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
        future: pihole.getAllQueries(
          addTimestamp: true,
          limit: 100,
        ),
        builder: (context, snapshot) {
          if (snapshot.data == null) return Container();

          List<dynamic> data = snapshot.data!['data'] ?? [];

          return SingleChildScrollView(
            child: Table(
              border: const TableBorder(
                horizontalInside: BorderSide(
                  color: Colors.grey,
                ),
                verticalInside: BorderSide(
                  color: Colors.grey,
                ),
              ),
              children: [
                const TableRow(
                  children: [
                    Text('Time'),
                    Text('Type'),
                    Text('Domain'),
                    Text('Client'),
                    Text('Status'),
                    Text('Reply'),
                  ],
                ),
                ...data.map(
                  (e) {
                    List list = e as List;
                    return TableRow(
                      children: [
                        Text(
                          DateFormat('dd/MM/yyyy HH:mm').format(
                            DateTime.fromMillisecondsSinceEpoch(
                              (int.tryParse(list.elementAt(0)) ?? 0) * 1000,
                            ),
                          ),
                        ),
                        Text(list.elementAt(1)),
                        Text(list.elementAt(2)),
                        Text(list.elementAt(3)),
                        Text(list.elementAt(4)),
                        Text(list.elementAt(5)),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
