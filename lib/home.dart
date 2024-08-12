import 'package:flutter/material.dart';
import 'package:pihole_manager/dashboard.dart';
import 'package:pihole_manager/query_log.dart';
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
    switch (selectedIndex) {
      case 0:
        return Dashboard(
          drawer: myDrawer,
        );
      case 1:
        return QueryLog(
          drawer: myDrawer,
        );
      case 2:
        return QueryLog(
          drawer: myDrawer,
          showBlocked: true,
        );
      case 3:
        return TopLists(
          drawer: myDrawer,
        );
      default:
        return Container();
    }
  }
}
