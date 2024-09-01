import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:pihole_manager/enums/navigation_item.dart';
import 'package:pihole_manager/pihole_api/pihole.dart';
import 'package:pihole_manager/widgets/chart_card.dart';
import 'package:pihole_manager/widgets/clients_data_bar_chart.dart';
import 'package:pihole_manager/widgets/info_card.dart';
import 'package:pihole_manager/widgets/over_time_data_chart.dart';

class Dashboard extends StatefulWidget {
  final Widget drawer;
  final Function(NavigationItem) onNavigateTo;

  const Dashboard({
    super.key,
    required this.drawer,
    required this.onNavigateTo,
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
        title: Text(AppLocalizations.of(context)?.dashboard ?? ''),
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
                      return const Center(
                        child: RepaintBoundary(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    Map<String, dynamic> data = snapshot.data!;

                    Size size = MediaQuery.of(context).size;

                    return Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        InkWell(
                          child: SizedBox(
                            width: (size.width - 40) / 2,
                            child: InfoCard(
                              title: AppLocalizations.of(context)?.totalQueries,
                              text: data['dns_queries_today'] ?? '',
                              color: Colors.blue,
                              icon: Icons.query_stats,
                              iconColor: Colors.blue.shade700.withOpacity(0.5),
                              infoText:
                                  '${data['unique_clients'] ?? 0} ${AppLocalizations.of(context)?.activeClients}',
                            ),
                          ),
                          onTap: () =>
                              widget.onNavigateTo(NavigationItem.network),
                        ),
                        InkWell(
                          child: SizedBox(
                            width: (size.width - 40) / 2,
                            child: InfoCard(
                              title:
                                  AppLocalizations.of(context)?.queriesBlocked,
                              text: data['ads_blocked_today'] ?? '',
                              color: Colors.red,
                              icon: Icons.back_hand,
                              iconColor: Colors.red.shade700.withOpacity(0.5),
                              infoText: AppLocalizations.of(context)
                                  ?.listAllBlockedQueries,
                            ),
                          ),
                          onTap: () => widget
                              .onNavigateTo(NavigationItem.queryLogBlocked),
                        ),
                        InkWell(
                          child: SizedBox(
                            width: (size.width - 40) / 2,
                            child: InfoCard(
                              title: AppLocalizations.of(context)
                                  ?.percentageBlocked,
                              text: '${data['ads_percentage_today'] ?? '0.0'}%',
                              color: Colors.orange,
                              icon: Icons.pie_chart,
                              iconColor:
                                  Colors.orange.shade700.withOpacity(0.5),
                              infoText:
                                  AppLocalizations.of(context)?.listAllQueries,
                            ),
                          ),
                          onTap: () =>
                              widget.onNavigateTo(NavigationItem.queryLog),
                        ),
                        SizedBox(
                          width: (size.width - 40) / 2,
                          child: InfoCard(
                            title:
                                AppLocalizations.of(context)?.domainsOnAdlist,
                            text: data['domains_being_blocked'] ?? '',
                            color: Colors.green,
                            icon: Icons.format_list_bulleted_outlined,
                            iconColor: Colors.green.shade700.withOpacity(0.5),
                            infoText:
                                AppLocalizations.of(context)?.manageAdlist,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
