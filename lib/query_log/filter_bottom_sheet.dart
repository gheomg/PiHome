import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pihole_manager/enums/date_range.dart';
import 'package:pihole_manager/enums/log_status_type.dart';

class FilterBottomSheet extends StatefulWidget {
  final Function(LogStatusType, DateTimeRange, DateRange) onApply;
  final DateRange? initialRange;
  final LogStatusType? initialStatus;
  final DateTimeRange? initialDateTimeRange;

  const FilterBottomSheet({
    super.key,
    required this.onApply,
    required this.initialRange,
    required this.initialStatus,
    required this.initialDateTimeRange,
  });

  @override
  State<StatefulWidget> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  LogStatusType? _status;
  DateRange? _range;
  DateTimeRange? _dateTimeRange;

  @override
  void initState() {
    super.initState();

    setState(() {
      _status = widget.initialStatus;
      _range = widget.initialRange;
      _dateTimeRange = widget.initialDateTimeRange;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 24.0,
              top: 10.0,
            ),
            child: Text(
              AppLocalizations.of(context)?.filter ?? '',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context)?.dateRange ?? '',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 4.0),
                DropdownButtonFormField(
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(20.0),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  items: DateRange.values
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e.getDescription(context),
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  value: _range,
                  onChanged: (dateRange) {
                    if (dateRange == DateRange.customRange) {
                      showDateRangePicker(
                        context: context,
                        firstDate: DateTime.fromMillisecondsSinceEpoch(
                          0,
                        ),
                        lastDate: DateTime.now(),
                      ).then(
                        (value) {
                          if (value != null) {
                            setState(() {
                              _range = dateRange!;
                              _dateTimeRange = value;
                            });
                          }
                        },
                      );
                    } else {
                      setState(() {
                        _range = dateRange!;
                        _dateTimeRange = dateRange.getValue();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context)?.status ?? '',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 4.0),
                DropdownButtonFormField(
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(20.0),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  items: LogStatusType.values
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e.getString(context),
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  value: _status,
                  onChanged: (value) {
                    setState(() {
                      _status = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                if (_status == null || _range == null) return;
                widget.onApply(_status!, _dateTimeRange!, _range!);
                Navigator.of(context).pop();
              },
              style: _status == null || _range == null
                  ? ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Colors.grey.shade400,
                      ),
                    )
                  : null,
              child: Text(
                (AppLocalizations.of(context)?.apply ?? '').toUpperCase(),
                style: _status != null && _range != null
                    ? null
                    : TextStyle(
                        color: Colors.grey.shade800,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
