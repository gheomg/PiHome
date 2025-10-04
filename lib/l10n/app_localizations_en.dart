// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'PiHome';

  @override
  String get servers => 'Servers';

  @override
  String get newConnection => 'New connection';

  @override
  String get serverInfo => 'Server information';

  @override
  String get hostAddress => 'Host address';

  @override
  String get port => 'Port';

  @override
  String get name => 'Name';

  @override
  String get authentication => 'Authentication';

  @override
  String get tokenLabel => 'Token';

  @override
  String get tokenDescription =>
      'In the Pi-hole web interface, go to Settings > API/Web interface to find the API token.';

  @override
  String get user => 'User';

  @override
  String get password => 'Password';

  @override
  String get save => 'Save';

  @override
  String get couldNotConnect => 'Could not access the RaspberryPi hosted at';

  @override
  String get clientActivity => 'Client activity';

  @override
  String get logStatusBlockedGravity => 'Blocked (gravity)';

  @override
  String get logStatusOKForwarded => 'OK (forwarded)';

  @override
  String get logStatusOKCache => 'OK (cache)';

  @override
  String get logStatusBlockedRegexBlack => 'Blocked (regex blacklist)';

  @override
  String get logStatusBlockedBlack => 'Blocked (exact blacklist)';

  @override
  String get logStatusBlockedExternalIP => 'Blocked (external, IP)';

  @override
  String get logStatusBlockedExternalNull => 'Blocked (external, NULL)';

  @override
  String get logStatusBlockedExternalNxra => 'Blocked (external, NXRA)';

  @override
  String get logStatusBlockedGravityCName => 'Blocked (gravity, CNAME)';

  @override
  String get logStatusBlockedRegexBlackCName =>
      'Blocked (regex blacklist, CNAME)';

  @override
  String get logStatusBlockedBlackCName => 'Blocked (exact blacklist, CNAME)';

  @override
  String get logStatusRetried => 'Retried';

  @override
  String get logStatusRetriedIgnored => 'Retried (ignored)';

  @override
  String get logStatusOKAlreadyForwarded => 'OK (already forwarded)';

  @override
  String get logStatusDatabaseBusy => 'Database is busy';

  @override
  String get logStatusBlockedSpecialDomain => 'Blocked (special domain)';

  @override
  String get logStatusUnknown => 'Unknown';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get queryLog => 'Query log';

  @override
  String get queriesBlocked => 'Queries blocked';

  @override
  String get topLists => 'Top lists';

  @override
  String get network => 'Network';

  @override
  String get topQueries => 'Top queries';

  @override
  String get edit => 'Edit';

  @override
  String get connect => 'Connect';

  @override
  String get totalQueries => 'Total queries';

  @override
  String get percentageBlocked => 'Percentage blocked';

  @override
  String get domainsOnAdlist => 'Domains on Adlists';

  @override
  String get listAllQueries => 'List all queries';

  @override
  String get listAllBlockedQueries => 'List blocked queries';

  @override
  String get activeClients => 'active clients';

  @override
  String get manageAdlist => 'Manage adlist';

  @override
  String get macAddress => 'MAC Address';

  @override
  String get interface => 'Interface';

  @override
  String get ipAddresses => 'IP Addresses';

  @override
  String get firstSeen => 'First seen';

  @override
  String get lastQuery => 'Last query';

  @override
  String get queriesMade => 'Queries made';

  @override
  String get macVendor => 'MAC Vendor';

  @override
  String get hits => 'Hits';

  @override
  String get requests => 'Requests';

  @override
  String get topPermittedDomains => 'Top permitted domains';

  @override
  String get topBlockedDomains => 'Top blocked domains';

  @override
  String get topClientsTotal => 'Top Clients (total)';

  @override
  String get topClientsBlocked => 'Top Clients (blocked only)';

  @override
  String get numberOfEntries => 'Number of entries';

  @override
  String get status => 'Status';

  @override
  String get apply => 'Apply';

  @override
  String get filter => 'Filter';

  @override
  String get dateRange => 'Date range';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get last7Days => 'Last 7 days';

  @override
  String get last30Days => 'Last 30 days';

  @override
  String get thisMonth => 'This month';

  @override
  String get lastMonth => 'Last month';

  @override
  String get thisYear => 'This year';

  @override
  String get lastYear => 'Last year';

  @override
  String get allTime => 'All time';

  @override
  String get customRange => 'Custom range';

  @override
  String get domains => 'Domains';

  @override
  String get whiteList => 'White list';

  @override
  String get blackList => 'Black list';

  @override
  String get whitelist => 'Whitelist';

  @override
  String get blacklist => 'Blacklist';

  @override
  String get regexWhitelist => 'Regex whitelist';

  @override
  String get regexBlacklist => 'Regex blacklist';
}
