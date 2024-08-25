import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum DateRange {
  today,
  yesterday,
  last7Days,
  last30Days,
  thisMonth,
  lastMonth,
  thisYear,
  allTime,
  customRange;
}

extension DateRangeExtension on DateRange {
  String getDescription(BuildContext context) {
    switch (this) {
      case DateRange.today:
        return AppLocalizations.of(context)?.today ?? '';
      case DateRange.yesterday:
        return AppLocalizations.of(context)?.yesterday ?? '';
      case DateRange.last7Days:
        return AppLocalizations.of(context)?.last7Days ?? '';
      case DateRange.last30Days:
        return AppLocalizations.of(context)?.last30Days ?? '';
      case DateRange.thisMonth:
        return AppLocalizations.of(context)?.thisMonth ?? '';
      case DateRange.lastMonth:
        return AppLocalizations.of(context)?.lastMonth ?? '';
      case DateRange.thisYear:
        return AppLocalizations.of(context)?.thisYear ?? '';
      case DateRange.allTime:
        return AppLocalizations.of(context)?.allTime ?? '';
      case DateRange.customRange:
        return AppLocalizations.of(context)?.customRange ?? '';
    }
  }

  DateTimeRange getValue() {
    switch (this) {
      case DateRange.today:
        DateTime now = DateTime.now();
        return DateTimeRange(
          start: DateTime(now.year, now.month, now.day),
          end: now,
        );
      case DateRange.yesterday:
        DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
        return DateTimeRange(
          start: DateTime(
            yesterday.year,
            yesterday.month,
            yesterday.day,
          ),
          end: DateTime(
            yesterday.year,
            yesterday.month,
            yesterday.day,
            23,
            59,
            59,
          ),
        );
      case DateRange.last7Days:
        DateTime now = DateTime.now();
        return DateTimeRange(
          start: DateTime(now.year, now.month, now.day - 7),
          end: now,
        );
      case DateRange.last30Days:
        return DateTimeRange(
          start: DateTime.now().subtract(const Duration(days: 30)),
          end: DateTime.now(),
        );
      case DateRange.thisMonth:
        DateTime now = DateTime.now();
        return DateTimeRange(
          start: DateTime(now.year, now.month, 1),
          end: now,
        );
      case DateRange.lastMonth:
        DateTime now = DateTime.now();
        DateTime firstDay = DateTime(now.year, now.month - 1, 1);
        DateTime lastDay = DateTime(now.year, now.month, 0);
        return DateTimeRange(
          start: firstDay,
          end: lastDay,
        );
      case DateRange.thisYear:
        DateTime now = DateTime.now();
        return DateTimeRange(
          start: DateTime(now.year, 1, 1),
          end: now,
        );
      case DateRange.allTime:
        return DateTimeRange(
          start: DateTime.fromMillisecondsSinceEpoch(0),
          end: DateTime.now(),
        );
      case DateRange.customRange:
        DateTime now = DateTime.now();
        return DateTimeRange(
          start: now,
          end: now,
        );
    }
  }
}
