import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:pihole_manager/enums/log_status_type.dart';
import 'package:pihole_manager/enums/number_of_records.dart';
import 'package:pihole_manager/pihole_api/pihole.dart';
import 'package:pihole_manager/widgets/log_status.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QueryLog extends StatefulWidget {
  final Widget drawer;
  final bool? showBlocked;

  const QueryLog({
    super.key,
    required this.drawer,
    this.showBlocked = false,
  });

  @override
  State<QueryLog> createState() => _QueryLogState();
}

class _QueryLogState extends State<QueryLog> {
  Pihole pihole = GetIt.instance.get<Pihole>();

  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _isScrollToTop = ValueNotifier<bool>(false);

  NumberOfRecords numberOfRecords = NumberOfRecords.hundred;
  LogStatusType? status;

  Map<String, dynamic> queries = {};

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 50 && !_isScrollToTop.value) {
        _isScrollToTop.value = true;
      }
      if (_scrollController.position.pixels < 50 && _isScrollToTop.value) {
        _isScrollToTop.value = false;
      }
    });

    getQueryTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (widget.showBlocked ?? false)
              ? AppLocalizations.of(context)?.queriesBlocked ?? ''
              : AppLocalizations.of(context)?.queryLog ?? '',
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.more_vert),
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();

                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              top: 10.0,
                            ),
                            child: Text(
                              AppLocalizations.of(context)?.filter ?? '',
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  AppLocalizations.of(context)
                                          ?.numberOfEntries ??
                                      '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        color: Colors.black54,
                                      ),
                                ),
                                const SizedBox(height: 4.0),
                                DropdownButtonFormField(
                                  isExpanded: true,
                                  borderRadius: BorderRadius.circular(20.0),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  items: NumberOfRecords.values
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(
                                            e.getDescription(),
                                            style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  value: numberOfRecords,
                                  onChanged: (value) =>
                                      numberOfRecords = value!,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  AppLocalizations.of(context)?.status ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        color: Colors.black54,
                                      ),
                                ),
                                const SizedBox(height: 4.0),
                                DropdownButtonFormField(
                                  isExpanded: true,
                                  borderRadius: BorderRadius.circular(20.0),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  items: LogStatusType.values
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(
                                            e.getString(context),
                                            style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  value: status,
                                  onChanged: (value) => status = value!,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                getQueryTypes();
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                (AppLocalizations.of(context)?.apply ?? '')
                                    .toUpperCase(),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
      drawer: widget.drawer,
      floatingActionButton: ValueListenableBuilder(
        valueListenable: _isScrollToTop,
        builder: (context, value, child) {
          if (!value) return Container();
          return FloatingActionButton(
            onPressed: () => _scrollController.animateTo(
              _scrollController.position.minScrollExtent,
              duration: const Duration(milliseconds: 500),
              curve: Curves.decelerate,
            ),
            child: const Icon(Icons.arrow_upward),
          );
        },
      ),
      body: Builder(
        builder: (context) {
          List<dynamic> data = queries['data'] ?? [];
          data.sort(
            (a, b) {
              if (a is! List || b is! List) return 0;
              return a.elementAt(0).compareTo(b.elementAt(0));
            },
          );

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            controller: _scrollController,
            itemCount: data.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              dynamic item = data.elementAt(index);
              List<String> values = [];
              if (item is List) {
                for (var element in item) {
                  values.add(element.toString());
                }
              }

              return ListBody(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LogStatus(
                        status: values.elementAt(4),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          DateFormat(DateFormat.HOUR_MINUTE_SECOND).format(
                            DateTime.fromMillisecondsSinceEpoch(
                              (int.tryParse(values.elementAt(0)) ?? 0) * 1000,
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
                  Text(
                    values.elementAt(3),
                    style: TextStyle(
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Future<void> getQueryTypes() async {
    Map<String, dynamic> result;
    if (status != null) {
      result = await pihole.getAllQueriesByStatus(
        status: status,
        numberOfRecords: numberOfRecords,
      );
    } else {
      result = await pihole.getAllQueries(
        forwarddest: (widget.showBlocked ?? false) ? 'blocked' : null,
        numberOfRecords: numberOfRecords,
      );
    }

    setState(() {
      queries = result;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
