import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.greenAccent,
            ),
            child: Text(
              AppLocalizations.of(context)?.appName ?? '',
              style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)?.dashboard ?? '',
            ),
            leading: const Icon(
              Icons.home_rounded,
            ),
            selected: selectedIndex == NavigationItem.dashboard.index,
            onTap: () {
              onSelectionChanged(NavigationItem.dashboard.index);
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            title: Text(
              AppLocalizations.of(context)?.queryLog ?? '',
            ),
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
            title: Text(
              AppLocalizations.of(context)?.queriesBlocked ?? '',
            ),
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
            title: Text(
              AppLocalizations.of(context)?.topLists ?? '',
            ),
            leading: const Icon(
              Icons.group_rounded,
            ),
            selected: selectedIndex == NavigationItem.topLists.index,
            onTap: () {
              onSelectionChanged(NavigationItem.topLists.index);
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            title: Text(
              AppLocalizations.of(context)?.network ?? '',
            ),
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
