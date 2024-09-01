import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DomainsList extends StatefulWidget {
  final List<Future<Map<String, dynamic>>> futures;

  const DomainsList({
    super.key,
    required this.futures,
  });

  @override
  State<DomainsList> createState() => _DomainsListState();
}

class _DomainsListState extends State<DomainsList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: Future.wait(widget.futures),
      builder: (
        context,
        AsyncSnapshot<List<Map<String, dynamic>>> snapshot,
      ) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: RepaintBoundary(
              child: CircularProgressIndicator(),
            ),
          );
        }

        List<Map<String, dynamic>> allData = snapshot.data ?? [];
        List<Map<String, dynamic>> combinedList = [
          ...allData[0]['data'],
          ...allData[1]['data'],
        ];

        return ListView.separated(
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            dynamic item = combinedList[index];
            DateTime dateAdded = DateTime.fromMillisecondsSinceEpoch(
              (int.tryParse(item['date_added'].toString()) ?? 0) * 1000,
            );
            String comment = item['comment'] ?? '';

            return ListTile(
              title: Text(item['domain']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (comment.isNotEmpty) Text(comment),
                  Text(DateFormat().format(dateAdded)),
                ],
              ),
              trailing: Builder(
                builder: (context) {
                  String typeDescription = '';
                  int type = item['type'];
                  Color color = Theme.of(context).colorScheme.primary;
                  switch (type) {
                    case 0:
                      typeDescription =
                          AppLocalizations.of(context)?.whitelist ?? '';
                      break;
                    case 1:
                      typeDescription =
                          AppLocalizations.of(context)?.blacklist ?? '';
                      color = Colors.red.shade700;
                      break;
                    case 2:
                      typeDescription =
                          AppLocalizations.of(context)?.regexWhitelist ?? '';
                      break;
                    case 3:
                      typeDescription =
                          AppLocalizations.of(context)?.regexBlacklist ?? '';
                      color = Colors.red.shade700;
                      break;
                  }
                  return Text(
                    typeDescription,
                    style: TextStyle(color: color),
                  );
                },
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: combinedList.length,
        );
      },
    );
  }
}
