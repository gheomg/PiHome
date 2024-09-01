import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:pihole_manager/domains/domains_list.dart';
import 'package:pihole_manager/pihole_api/pihole.dart';

class Domains extends StatefulWidget {
  final Widget drawer;

  const Domains({
    super.key,
    required this.drawer,
  });

  @override
  State<StatefulWidget> createState() => _Domains();
}

class _Domains extends State<Domains> {
  Pihole pihole = GetIt.instance.get<Pihole>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)?.domains ?? ''),
          bottom: TabBar(
            dividerColor: Colors.transparent,
            tabs: <Widget>[
              Tab(
                text: AppLocalizations.of(context)?.whiteList ?? '',
                icon: const Icon(Icons.checklist_rounded),
              ),
              Tab(
                text: AppLocalizations.of(context)?.blackList ?? '',
                icon: const Icon(Icons.clear_all_rounded),
              ),
            ],
          ),
        ),
        drawer: widget.drawer,
        body: TabBarView(
          children: <Widget>[
            DomainsList(
              futures: [
                pihole.getWhiteList(),
                pihole.getRegexWhiteList(),
              ],
            ),
            DomainsList(
              futures: [
                pihole.getBlackList(),
                pihole.getRegexBlackList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
