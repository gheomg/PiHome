// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum LogStatusType {
  blocked_gravity('1'),
  ok_forwarded('2'),
  ok_cache('3'),
  blocked_regex_black('4'),
  blocked_black('5'),
  blocked_external_ip('6'),
  blocked_external_null('7'),
  blocked_external_nxra('8'),
  blocked_gravity_cname('9'),
  blocked_regex_black_cname('10'),
  blocked_black_cname('11'),
  retried('12'),
  retried_ignored('13'),
  ok_already_forwarded('14'),
  database_busy('15'),
  blocked_special_domain('16'),
  unknown('0');

  const LogStatusType(this.value);
  final String value;
}

extension LogStatusTypeExtension on LogStatusType {
  String getString(BuildContext context) {
    switch (this) {
      case LogStatusType.blocked_gravity:
        return AppLocalizations.of(context)?.logStatusBlockedGravity ?? name;
      case LogStatusType.ok_forwarded:
        return AppLocalizations.of(context)?.logStatusOKForwarded ?? name;
      case LogStatusType.ok_cache:
        return AppLocalizations.of(context)?.logStatusOKCache ?? name;
      case LogStatusType.blocked_regex_black:
        return AppLocalizations.of(context)?.logStatusBlockedRegexBlack ?? name;
      case LogStatusType.blocked_black:
        return AppLocalizations.of(context)?.logStatusBlockedBlack ?? name;
      case LogStatusType.blocked_external_ip:
        return AppLocalizations.of(context)?.logStatusBlockedExternalIP ?? name;
      case LogStatusType.blocked_external_null:
        return AppLocalizations.of(context)?.logStatusBlockedExternalNull ??
            name;
      case LogStatusType.blocked_external_nxra:
        return AppLocalizations.of(context)?.logStatusBlockedExternalNxra ??
            name;
      case LogStatusType.blocked_gravity_cname:
        return AppLocalizations.of(context)?.logStatusBlockedGravityCName ??
            name;
      case LogStatusType.blocked_regex_black_cname:
        return AppLocalizations.of(context)?.logStatusBlockedRegexBlackCName ??
            name;
      case LogStatusType.blocked_black_cname:
        return AppLocalizations.of(context)?.logStatusBlockedBlackCName ?? name;
      case LogStatusType.retried:
        return AppLocalizations.of(context)?.logStatusRetried ?? name;
      case LogStatusType.retried_ignored:
        return AppLocalizations.of(context)?.logStatusRetriedIgnored ?? name;
      case LogStatusType.ok_already_forwarded:
        return AppLocalizations.of(context)?.logStatusOKAlreadyForwarded ??
            name;
      case LogStatusType.database_busy:
        return AppLocalizations.of(context)?.logStatusDatabaseBusy ?? name;
      case LogStatusType.blocked_special_domain:
        return AppLocalizations.of(context)?.logStatusBlockedSpecialDomain ??
            name;
      case LogStatusType.unknown:
        return AppLocalizations.of(context)?.logStatusUnknown ?? name;
    }
  }

  String getValue() {
    if (this == LogStatusType.ok_forwarded) {
      return '$value,${LogStatusType.ok_already_forwarded.value}';
    }
    if (this == LogStatusType.ok_already_forwarded) {
      return '$value,${LogStatusType.ok_forwarded.value}';
    }
    return value;
  }

  String getQueryTypes() {
    return LogStatusType.values
        .where(
          (e) => e.value != value && e.value != LogStatusType.unknown.value,
        )
        .map((e) => e.getValue())
        .toSet()
        .join(',');
  }
}
