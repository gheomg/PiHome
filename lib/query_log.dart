import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
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
                onPressed: () => Scaffold.of(context).openEndDrawer(),
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
      endDrawer: Drawer(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Text(
                'Filter',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Total number of records'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Records per page'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Status'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: pihole.getAllQueries(
          forwarddest: (widget.showBlocked ?? false) ? 'blocked' : null,
        ),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List<dynamic> data = snapshot.data!['data'] ?? [];
          data.sort(
            (a, b) {
              if (a is! List || b is! List) return 0;
              return a.elementAt(0).compareTo(b.elementAt(0));
            },
          );

          return ListView.builder(
            controller: _scrollController,
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
