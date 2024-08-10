import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pihole_manager/pihole_api/pihole.dart';
import 'package:pihole_manager/widgets/clients_data_bar_chart.dart';
import 'package:pihole_manager/widgets/chart_card.dart';
import 'package:pihole_manager/widgets/info_card.dart';
import 'package:pihole_manager/widgets/over_time_data_chart.dart';
import 'package:pihole_manager/widgets/table_chart.dart';

class Dashboard extends StatefulWidget {
  final Widget drawer;
  const Dashboard({
    super.key,
    required this.drawer,
  });

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  Pihole pihole = GetIt.instance.get<Pihole>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
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
                  future: pihole.getPiHoleSummary(),
                  builder:
                      (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        !snapshot.hasData) {
                      return Container();
                    }
                    Map<String, dynamic> data = snapshot.data!;

                    Size size = MediaQuery.of(context).size;

                    return Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        SizedBox(
                          width: (size.width - 40) / 2,
                          child: InfoCard(
                            title: 'Total queries',
                            text: data['dns_queries_today'] ?? '',
                            color: Colors.blue,
                            icon: Icons.query_stats,
                            iconColor: Colors.blue.shade700.withOpacity(0.5),
                            infoText:
                                '${data['unique_clients'] ?? 0} active clients',
                          ),
                        ),
                        SizedBox(
                          width: (size.width - 40) / 2,
                          child: InfoCard(
                            title: 'Queries blocked',
                            text: data['ads_blocked_today'] ?? '',
                            color: Colors.red,
                            icon: Icons.back_hand,
                            iconColor: Colors.red.shade700.withOpacity(0.5),
                            infoText: 'List blocked queries',
                          ),
                        ),
                        SizedBox(
                          width: (size.width - 40) / 2,
                          child: InfoCard(
                            title: 'Percentage blocked',
                            text: '${data['ads_percentage_today'] ?? '0.0'}%',
                            color: Colors.orange,
                            icon: Icons.pie_chart,
                            iconColor: Colors.orange.shade700.withOpacity(0.5),
                            infoText: 'List all queries',
                          ),
                        ),
                        SizedBox(
                          width: (size.width - 40) / 2,
                          child: InfoCard(
                            title: 'Domains on Adlists',
                            text: data['domains_being_blocked'] ?? '',
                            color: Colors.green,
                            icon: Icons.format_list_bulleted_outlined,
                            iconColor: Colors.green.shade700.withOpacity(0.5),
                            infoText: 'Manage adlists',
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const OverTimeDataChart(),
                const ClientsDataBarChart(),
                FutureBuilder(
                  future: pihole.getQueryTypes(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        !snapshot.hasData) {
                      return Container();
                    }
                    Map<String, dynamic> data = snapshot.data!['querytypes'];
                    data.removeWhere(
                      (key, value) => value == 0,
                    );
                    Map<String, double> dataMap = data.map<String, double>(
                      (key, value) => MapEntry<String, double>(
                        key,
                        value is int ? value.toDouble() : value,
                      ),
                    );

                    return ChartCard(
                      dataMap: dataMap,
                      title: 'Query types',
                    );
                  },
                ),
                FutureBuilder(
                  future: pihole.getForwardDestinations(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        !snapshot.hasData) {
                      return Container();
                    }
                    Map<String, dynamic> data =
                        snapshot.data!['forward_destinations'];
                    Map<String, double> dataMap = data.map(
                      (key, value) => MapEntry(
                        key,
                        value is double ? value : 0.0,
                      ),
                    );

                    return ChartCard(
                      dataMap: dataMap,
                      title: 'Upstream servers',
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
