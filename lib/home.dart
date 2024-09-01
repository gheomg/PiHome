import 'package:flutter/material.dart';
import 'package:pihole_manager/dashboard.dart';
import 'package:pihole_manager/domains/domains.dart';
import 'package:pihole_manager/enums/navigation_item.dart';
import 'package:pihole_manager/network.dart';
import 'package:pihole_manager/query_log/query_log.dart';
import 'package:pihole_manager/top_lists.dart';
import 'package:pihole_manager/widgets/my_drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  MyDrawer get myDrawer => MyDrawer(
        onSelectionChanged: onSelectionChanged,
        selectedIndex: selectedIndex,
      );

  void onSelectionChanged(int index) {
    setState(() => selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
    );
  }

  Widget get body {
    NavigationItem selectedItem = NavigationItem.values[selectedIndex];
    switch (selectedItem) {
      case NavigationItem.dashboard:
        return Dashboard(
          drawer: myDrawer,
          onNavigateTo: _onNavigateTo,
        );
      case NavigationItem.queryLog:
        return QueryLog(
          key: const Key('query_log'),
          drawer: myDrawer,
        );
      case NavigationItem.queryLogBlocked:
        return QueryLog(
          key: const Key('query_log_blocked'),
          drawer: myDrawer,
          showBlocked: true,
        );
      case NavigationItem.topLists:
        return TopLists(
          drawer: myDrawer,
        );
      case NavigationItem.domains:
        return Domains(
          drawer: myDrawer,
        );
      case NavigationItem.network:
        return Network(
          drawer: myDrawer,
        );
      default:
        return Container();
    }
  }

  void _onNavigateTo(NavigationItem item) {
    onSelectionChanged(item.index);
  }
}
