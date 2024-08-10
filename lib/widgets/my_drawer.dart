import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final Function(int) onSelectionChanged;

  const MyDrawer({
    super.key,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              onSelectionChanged(0);
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
              onSelectionChanged(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Queries blocked'),
            onTap: () {
              onSelectionChanged(2);
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
              onSelectionChanged(3);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Clients'),
            onTap: () {
              onSelectionChanged(4);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Domains'),
            onTap: () {
              onSelectionChanged(5);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Adlist'),
            onTap: () {
              onSelectionChanged(6);
              Navigator.pop(context);
            },
          ),
          const Divider(
            thickness: 0.5,
            color: Colors.black12,
          ),
        ],
      ),
    );
  }
}
