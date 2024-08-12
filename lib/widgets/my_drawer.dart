import 'package:flutter/material.dart';
import 'package:pihole_manager/enums/navigation_item.dart';

class MyDrawer extends StatelessWidget {
  final Function(int) onSelectionChanged;
  final int selectedIndex;

  const MyDrawer({
    super.key,
    required this.onSelectionChanged,
    required this.selectedIndex,
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
            leading: const Icon(
              Icons.home_rounded,
            ),
            selected: selectedIndex == NavigationItem.dashboard.index,
            onTap: () {
              onSelectionChanged(NavigationItem.dashboard.index);
              Navigator.pop(context);
            },
          ),
          const Divider(
            thickness: 0.5,
            color: Colors.black12,
          ),
          ListTile(
            title: const Text('Query log'),
            leading: const Icon(
              Icons.restore_rounded,
            ),
            selected: selectedIndex == NavigationItem.queryLog.index,
            onTap: () {
              onSelectionChanged(NavigationItem.queryLog.index);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Queries blocked'),
            leading: const Icon(
              Icons.lock_reset_rounded,
            ),
            selected: selectedIndex == NavigationItem.queryLogBlocked.index,
            onTap: () {
              onSelectionChanged(NavigationItem.queryLogBlocked.index);
              Navigator.pop(context);
            },
          ),
          const Divider(
            thickness: 0.5,
            color: Colors.black12,
          ),
          ListTile(
            title: const Text('Groups'),
            leading: const Icon(
              Icons.group_rounded,
            ),
            selected: selectedIndex == NavigationItem.groups.index,
            onTap: () {
              onSelectionChanged(NavigationItem.groups.index);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Clients'),
            leading: const Icon(
              Icons.laptop_rounded,
            ),
            selected: selectedIndex == NavigationItem.clients.index,
            onTap: () {
              onSelectionChanged(NavigationItem.clients.index);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Domains'),
            leading: const Icon(
              Icons.format_list_bulleted_rounded,
            ),
            selected: selectedIndex == NavigationItem.domains.index,
            onTap: () {
              onSelectionChanged(NavigationItem.domains.index);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Adlist'),
            leading: const Icon(
              Icons.shield_rounded,
            ),
            selected: selectedIndex == NavigationItem.adlist.index,
            onTap: () {
              onSelectionChanged(NavigationItem.adlist.index);
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
