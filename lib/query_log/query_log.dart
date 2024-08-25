import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:pihole_manager/enums/date_range.dart';
import 'package:pihole_manager/enums/log_status_type.dart';
import 'package:pihole_manager/enums/number_of_records.dart';
import 'package:pihole_manager/pihole_api/pihole.dart';
import 'package:pihole_manager/query_log/filter_bottom_sheet.dart';
import 'package:pihole_manager/widgets/log_status.dart';

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

  LogStatusType? _status;
  DateTimeRange? _dateTimeRange;
  DateRange? _range;

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
                  showModalBottomSheet(
                    context: context,
                    useSafeArea: true,
                    builder: (context) => FilterBottomSheet(
                      initialRange: _range,
                      initialStatus: _status,
                      initialDateTimeRange: _dateTimeRange,
                      onApply: (
                        LogStatusType status,
                        DateTimeRange dateTimeRange,
                        DateRange range,
                      ) {
                        _status = status;
                        _dateTimeRange = dateTimeRange;
                        _range = range;
                        getQueryTypes();
                      },
                    ),
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
      body: SafeArea(
        child: Builder(
          builder: (context) {
            List<dynamic> data = queries['data'] ?? [];
            data.sort(
              (a, b) {
                if (a is! List || b is! List) return 0;
                return b.elementAt(0).compareTo(a.elementAt(0));
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
      ),
    );
  }

  Future<void> getQueryTypes() async {
    Map<String, dynamic> result;
    if (_status != null || _dateTimeRange != null) {
      result = await pihole.getAllQueriesByStatus(
        status: _status,
        numberOfRecords: NumberOfRecords.hundred,
        range: _dateTimeRange,
      );
    } else {
      result = await pihole.getAllQueries(
        forwarddest: (widget.showBlocked ?? false) ? 'blocked' : null,
        numberOfRecords: NumberOfRecords.hundred,
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
