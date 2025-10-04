import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'PiHome'**
  String get appName;

  /// No description provided for @servers.
  ///
  /// In en, this message translates to:
  /// **'Servers'**
  String get servers;

  /// No description provided for @newConnection.
  ///
  /// In en, this message translates to:
  /// **'New connection'**
  String get newConnection;

  /// No description provided for @serverInfo.
  ///
  /// In en, this message translates to:
  /// **'Server information'**
  String get serverInfo;

  /// No description provided for @hostAddress.
  ///
  /// In en, this message translates to:
  /// **'Host address'**
  String get hostAddress;

  /// No description provided for @port.
  ///
  /// In en, this message translates to:
  /// **'Port'**
  String get port;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @authentication.
  ///
  /// In en, this message translates to:
  /// **'Authentication'**
  String get authentication;

  /// No description provided for @tokenLabel.
  ///
  /// In en, this message translates to:
  /// **'Token'**
  String get tokenLabel;

  /// No description provided for @tokenDescription.
  ///
  /// In en, this message translates to:
  /// **'In the Pi-hole web interface, go to Settings > API/Web interface to find the API token.'**
  String get tokenDescription;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @couldNotConnect.
  ///
  /// In en, this message translates to:
  /// **'Could not access the RaspberryPi hosted at'**
  String get couldNotConnect;

  /// No description provided for @clientActivity.
  ///
  /// In en, this message translates to:
  /// **'Client activity'**
  String get clientActivity;

  /// No description provided for @logStatusBlockedGravity.
  ///
  /// In en, this message translates to:
  /// **'Blocked (gravity)'**
  String get logStatusBlockedGravity;

  /// No description provided for @logStatusOKForwarded.
  ///
  /// In en, this message translates to:
  /// **'OK (forwarded)'**
  String get logStatusOKForwarded;

  /// No description provided for @logStatusOKCache.
  ///
  /// In en, this message translates to:
  /// **'OK (cache)'**
  String get logStatusOKCache;

  /// No description provided for @logStatusBlockedRegexBlack.
  ///
  /// In en, this message translates to:
  /// **'Blocked (regex blacklist)'**
  String get logStatusBlockedRegexBlack;

  /// No description provided for @logStatusBlockedBlack.
  ///
  /// In en, this message translates to:
  /// **'Blocked (exact blacklist)'**
  String get logStatusBlockedBlack;

  /// No description provided for @logStatusBlockedExternalIP.
  ///
  /// In en, this message translates to:
  /// **'Blocked (external, IP)'**
  String get logStatusBlockedExternalIP;

  /// No description provided for @logStatusBlockedExternalNull.
  ///
  /// In en, this message translates to:
  /// **'Blocked (external, NULL)'**
  String get logStatusBlockedExternalNull;

  /// No description provided for @logStatusBlockedExternalNxra.
  ///
  /// In en, this message translates to:
  /// **'Blocked (external, NXRA)'**
  String get logStatusBlockedExternalNxra;

  /// No description provided for @logStatusBlockedGravityCName.
  ///
  /// In en, this message translates to:
  /// **'Blocked (gravity, CNAME)'**
  String get logStatusBlockedGravityCName;

  /// No description provided for @logStatusBlockedRegexBlackCName.
  ///
  /// In en, this message translates to:
  /// **'Blocked (regex blacklist, CNAME)'**
  String get logStatusBlockedRegexBlackCName;

  /// No description provided for @logStatusBlockedBlackCName.
  ///
  /// In en, this message translates to:
  /// **'Blocked (exact blacklist, CNAME)'**
  String get logStatusBlockedBlackCName;

  /// No description provided for @logStatusRetried.
  ///
  /// In en, this message translates to:
  /// **'Retried'**
  String get logStatusRetried;

  /// No description provided for @logStatusRetriedIgnored.
  ///
  /// In en, this message translates to:
  /// **'Retried (ignored)'**
  String get logStatusRetriedIgnored;

  /// No description provided for @logStatusOKAlreadyForwarded.
  ///
  /// In en, this message translates to:
  /// **'OK (already forwarded)'**
  String get logStatusOKAlreadyForwarded;

  /// No description provided for @logStatusDatabaseBusy.
  ///
  /// In en, this message translates to:
  /// **'Database is busy'**
  String get logStatusDatabaseBusy;

  /// No description provided for @logStatusBlockedSpecialDomain.
  ///
  /// In en, this message translates to:
  /// **'Blocked (special domain)'**
  String get logStatusBlockedSpecialDomain;

  /// No description provided for @logStatusUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get logStatusUnknown;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @queryLog.
  ///
  /// In en, this message translates to:
  /// **'Query log'**
  String get queryLog;

  /// No description provided for @queriesBlocked.
  ///
  /// In en, this message translates to:
  /// **'Queries blocked'**
  String get queriesBlocked;

  /// No description provided for @topLists.
  ///
  /// In en, this message translates to:
  /// **'Top lists'**
  String get topLists;

  /// No description provided for @network.
  ///
  /// In en, this message translates to:
  /// **'Network'**
  String get network;

  /// No description provided for @topQueries.
  ///
  /// In en, this message translates to:
  /// **'Top queries'**
  String get topQueries;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @connect.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get connect;

  /// No description provided for @totalQueries.
  ///
  /// In en, this message translates to:
  /// **'Total queries'**
  String get totalQueries;

  /// No description provided for @percentageBlocked.
  ///
  /// In en, this message translates to:
  /// **'Percentage blocked'**
  String get percentageBlocked;

  /// No description provided for @domainsOnAdlist.
  ///
  /// In en, this message translates to:
  /// **'Domains on Adlists'**
  String get domainsOnAdlist;

  /// No description provided for @listAllQueries.
  ///
  /// In en, this message translates to:
  /// **'List all queries'**
  String get listAllQueries;

  /// No description provided for @listAllBlockedQueries.
  ///
  /// In en, this message translates to:
  /// **'List blocked queries'**
  String get listAllBlockedQueries;

  /// No description provided for @activeClients.
  ///
  /// In en, this message translates to:
  /// **'active clients'**
  String get activeClients;

  /// No description provided for @manageAdlist.
  ///
  /// In en, this message translates to:
  /// **'Manage adlist'**
  String get manageAdlist;

  /// No description provided for @macAddress.
  ///
  /// In en, this message translates to:
  /// **'MAC Address'**
  String get macAddress;

  /// No description provided for @interface.
  ///
  /// In en, this message translates to:
  /// **'Interface'**
  String get interface;

  /// No description provided for @ipAddresses.
  ///
  /// In en, this message translates to:
  /// **'IP Addresses'**
  String get ipAddresses;

  /// No description provided for @firstSeen.
  ///
  /// In en, this message translates to:
  /// **'First seen'**
  String get firstSeen;

  /// No description provided for @lastQuery.
  ///
  /// In en, this message translates to:
  /// **'Last query'**
  String get lastQuery;

  /// No description provided for @queriesMade.
  ///
  /// In en, this message translates to:
  /// **'Queries made'**
  String get queriesMade;

  /// No description provided for @macVendor.
  ///
  /// In en, this message translates to:
  /// **'MAC Vendor'**
  String get macVendor;

  /// No description provided for @hits.
  ///
  /// In en, this message translates to:
  /// **'Hits'**
  String get hits;

  /// No description provided for @requests.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get requests;

  /// No description provided for @topPermittedDomains.
  ///
  /// In en, this message translates to:
  /// **'Top permitted domains'**
  String get topPermittedDomains;

  /// No description provided for @topBlockedDomains.
  ///
  /// In en, this message translates to:
  /// **'Top blocked domains'**
  String get topBlockedDomains;

  /// No description provided for @topClientsTotal.
  ///
  /// In en, this message translates to:
  /// **'Top Clients (total)'**
  String get topClientsTotal;

  /// No description provided for @topClientsBlocked.
  ///
  /// In en, this message translates to:
  /// **'Top Clients (blocked only)'**
  String get topClientsBlocked;

  /// No description provided for @numberOfEntries.
  ///
  /// In en, this message translates to:
  /// **'Number of entries'**
  String get numberOfEntries;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @dateRange.
  ///
  /// In en, this message translates to:
  /// **'Date range'**
  String get dateRange;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @last7Days.
  ///
  /// In en, this message translates to:
  /// **'Last 7 days'**
  String get last7Days;

  /// No description provided for @last30Days.
  ///
  /// In en, this message translates to:
  /// **'Last 30 days'**
  String get last30Days;

  /// No description provided for @thisMonth.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get thisMonth;

  /// No description provided for @lastMonth.
  ///
  /// In en, this message translates to:
  /// **'Last month'**
  String get lastMonth;

  /// No description provided for @thisYear.
  ///
  /// In en, this message translates to:
  /// **'This year'**
  String get thisYear;

  /// No description provided for @lastYear.
  ///
  /// In en, this message translates to:
  /// **'Last year'**
  String get lastYear;

  /// No description provided for @allTime.
  ///
  /// In en, this message translates to:
  /// **'All time'**
  String get allTime;

  /// No description provided for @customRange.
  ///
  /// In en, this message translates to:
  /// **'Custom range'**
  String get customRange;

  /// No description provided for @domains.
  ///
  /// In en, this message translates to:
  /// **'Domains'**
  String get domains;

  /// No description provided for @whiteList.
  ///
  /// In en, this message translates to:
  /// **'White list'**
  String get whiteList;

  /// No description provided for @blackList.
  ///
  /// In en, this message translates to:
  /// **'Black list'**
  String get blackList;

  /// No description provided for @whitelist.
  ///
  /// In en, this message translates to:
  /// **'Whitelist'**
  String get whitelist;

  /// No description provided for @blacklist.
  ///
  /// In en, this message translates to:
  /// **'Blacklist'**
  String get blacklist;

  /// No description provided for @regexWhitelist.
  ///
  /// In en, this message translates to:
  /// **'Regex whitelist'**
  String get regexWhitelist;

  /// No description provided for @regexBlacklist.
  ///
  /// In en, this message translates to:
  /// **'Regex blacklist'**
  String get regexBlacklist;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
