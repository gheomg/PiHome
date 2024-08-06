import 'package:flutter/material.dart';
import 'package:pihole_manager/dashboard.dart';
import 'package:pihole_manager/query_log.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.greenAccent,
              ),
              child: Text(
                'Pi-Hole',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Dashboard'),
              onTap: () {
                setState(() => selectedIndex = 0);
                Navigator.pop(context);
              },
            ),
            const Divider(
              thickness: 0.5,
              color: Colors.black12,
            ),
            ListTile(
              title: const Text('Query log'),
              onTap: () {
                setState(() => selectedIndex = 1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Queries blocked'),
              onTap: () {
                setState(() => selectedIndex = 1);
                Navigator.pop(context);
              },
            ),
            const Divider(
              thickness: 0.5,
              color: Colors.black12,
            ),
            ListTile(
              title: const Text('Groups'),
              onTap: () {
                setState(() => selectedIndex = 2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Clients'),
              onTap: () {
                setState(() => selectedIndex = 2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Domains'),
              onTap: () {
                setState(() => selectedIndex = 2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Adlist'),
              onTap: () {
                setState(() => selectedIndex = 2);
                Navigator.pop(context);
              },
            ),
            const Divider(
              thickness: 0.5,
              color: Colors.black12,
            ),
          ],
        ),
      ),
      body: body,
    );
  }

  Widget get body {
    switch (selectedIndex) {
      case 1:
        return const QueryLog();
      case 2:
        return Container();
      default:
        return const Dashboard();
    }
  }
}
