import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pihole_manager/pihole_api/pihole.dart';
import 'package:pihole_manager/widgets/table_chart.dart';

class TopLists extends StatefulWidget {
  final Widget drawer;
  const TopLists({
    super.key,
    required this.drawer,
  });

  @override
  State<StatefulWidget> createState() => _TopListsState();
}

class _TopListsState extends State<TopLists> {
  Pihole pihole = GetIt.instance.get<Pihole>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top lists'),
      ),
      drawer: widget.drawer,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: pihole.getTopItems(),
                  builder:
                      (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        !snapshot.hasData) {
                      return Container();
                    }
                    Map<String, dynamic> data = snapshot.data!;
                    Map<String, dynamic> topQueries = data['top_queries'];

                    return TableChart(
                      data: topQueries,
                      title: 'Top Permitted Domains',
                      infoLabel: 'Hits',
                    );
                  },
                ),
                FutureBuilder(
                  future: pihole.getTopItems(),
                  builder:
                      (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        !snapshot.hasData) {
                      return Container();
                    }
                    Map<String, dynamic> data = snapshot.data!;
                    Map<String, dynamic> topAds = data['top_ads'];

                    return TableChart(
                      data: topAds,
                      title: 'Top Blocked Domains',
                      infoLabel: 'Hits',
                    );
                  },
                ),
                FutureBuilder(
                  future: pihole.getQuerySources(),
                  builder:
                      (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        !snapshot.hasData) {
                      return Container();
                    }
                    Map<String, dynamic> data = snapshot.data!;
                    Map<String, dynamic> topAds = data['top_sources'];

                    return TableChart(
                      data: topAds,
                      title: 'Top Clients (total)',
                      infoLabel: 'Requests',
                    );
                  },
                ),
                FutureBuilder(
                  future: pihole.topClientsBlocked(),
                  builder:
                      (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        !snapshot.hasData) {
                      return Container();
                    }
                    Map<String, dynamic> data = snapshot.data!;
                    Map<String, dynamic> topAds = data['top_sources_blocked'];

                    return TableChart(
                      data: topAds,
                      title: 'Top Clients (blocked only)',
                      infoLabel: 'Requests',
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
