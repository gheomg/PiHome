import 'package:flutter/material.dart';
import 'package:pihole_manager/enums/navigation_item.dart';
import 'package:pihole_manager/widgets/custom_divider.dart';

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
              'PiHome',
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
          const CustomDivider(),
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
          ListTile(
            title: const Text('Top lists'),
            leading: const Icon(
              Icons.group_rounded,
            ),
            selected: selectedIndex == NavigationItem.topLists.index,
            onTap: () {
              onSelectionChanged(NavigationItem.topLists.index);
              Navigator.pop(context);
            },
          ),
          const CustomDivider(),
          ListTile(
            title: const Text('Network'),
            leading: const Icon(
              Icons.lan_rounded,
            ),
            selected: selectedIndex == NavigationItem.network.index,
            onTap: () {
              onSelectionChanged(NavigationItem.network.index);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
