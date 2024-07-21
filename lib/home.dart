import 'package:flutter/material.dart';
import 'package:pihole_manager/home_tab.dart';
import 'package:pihole_manager/pihole_api/pihole.dart';
import 'package:pihole_manager/query_log.dart';

class Home extends StatefulWidget {
  final Pihole pihole;

  const Home({super.key, required this.pihole});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (int index) =>
            setState(() => selectedIndex = index),
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.screen_search_desktop_outlined),
            selectedIcon: Icon(Icons.screen_search_desktop_rounded),
            label: 'Domains',
          ),
          NavigationDestination(
            icon: Icon(Icons.text_snippet_outlined),
            selectedIcon: Icon(Icons.text_snippet),
            label: 'Query log',
          ),
        ],
      ),
    );
  }

  Widget get body {
    switch (selectedIndex) {
      case 1:
        return Container();
      case 2:
        return QueryLog(pihole: widget.pihole);
      default:
        return HomeTab(pihole: widget.pihole);
    }
  }
}
