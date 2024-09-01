import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return NavigationDrawer(
      selectedIndex: selectedIndex,
      onDestinationSelected: onSelectionChanged,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text(
            AppLocalizations.of(context)?.appName ?? '',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        NavigationDrawerDestination(
          icon: const Icon(
            Icons.home_rounded,
          ),
          label: Text(
            AppLocalizations.of(context)?.dashboard ?? '',
          ),
        ),
        const Divider(),
        NavigationDrawerDestination(
          label: Text(
            AppLocalizations.of(context)?.queryLog ?? '',
          ),
          icon: const Icon(
            Icons.restore_rounded,
          ),
        ),
        NavigationDrawerDestination(
          label: Text(
            AppLocalizations.of(context)?.queriesBlocked ?? '',
          ),
          icon: const Icon(
            Icons.lock_reset_rounded,
          ),
        ),
        NavigationDrawerDestination(
          label: Text(
            AppLocalizations.of(context)?.topLists ?? '',
          ),
          icon: const Icon(
            Icons.group_rounded,
          ),
        ),
        const Divider(),
        NavigationDrawerDestination(
          label: Text(
            AppLocalizations.of(context)?.domains ?? '',
          ),
          icon: const Icon(
            Icons.view_list_rounded,
          ),
        ),
        const Divider(),
        NavigationDrawerDestination(
          label: Text(
            AppLocalizations.of(context)?.network ?? '',
          ),
          icon: const Icon(
            Icons.lan_rounded,
          ),
        ),
      ],
    );
  }
}
