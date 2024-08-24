import 'package:flutter/material.dart';
import 'package:pihole_manager/enums/log_status_type.dart';

class LogStatus extends StatelessWidget {
  final String status;

  const LogStatus({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    LogStatusType statusType = LogStatusType.values.firstWhere(
      (element) => element.value == status,
      orElse: () => LogStatusType.unknown,
    );

    switch (statusType) {
      case LogStatusType.blocked_gravity:
        return logStatusWidget(
          icon: Icons.gpp_bad_rounded,
          color: Colors.red,
          text: statusType.getString(context),
        );

      case LogStatusType.ok_forwarded:
        return logStatusWidget(
          icon: Icons.verified_user_rounded,
          color: Colors.green,
          text: statusType.getString(context),
        );

      case LogStatusType.ok_cache:
        return logStatusWidget(
          icon: Icons.verified_user_rounded,
          color: Colors.green,
          text: statusType.getString(context),
        );

      case LogStatusType.blocked_regex_black:
        return logStatusWidget(
          icon: Icons.gpp_bad_rounded,
          color: Colors.red,
          text: statusType.getString(context),
        );

      case LogStatusType.blocked_black:
        return logStatusWidget(
          icon: Icons.gpp_bad_rounded,
          color: Colors.red,
          text: statusType.getString(context),
        );

      case LogStatusType.blocked_external_ip:
        return logStatusWidget(
          icon: Icons.gpp_bad_rounded,
          color: Colors.red,
          text: statusType.getString(context),
        );

      case LogStatusType.blocked_external_null:
        return logStatusWidget(
          icon: Icons.gpp_bad_rounded,
          color: Colors.red,
          text: statusType.getString(context),
        );

      case LogStatusType.blocked_external_nxra:
        return logStatusWidget(
          icon: Icons.gpp_bad_rounded,
          color: Colors.red,
          text: statusType.getString(context),
        );

      case LogStatusType.blocked_gravity_cname:
        return logStatusWidget(
          icon: Icons.gpp_bad_rounded,
          color: Colors.red,
          text: statusType.getString(context),
        );

      case LogStatusType.blocked_regex_black_cname:
        return logStatusWidget(
          icon: Icons.gpp_bad_rounded,
          color: Colors.red,
          text: statusType.getString(context),
        );

      case LogStatusType.blocked_black_cname:
        return logStatusWidget(
          icon: Icons.gpp_bad_rounded,
          color: Colors.red,
          text: statusType.getString(context),
        );

      case LogStatusType.retried:
        return logStatusWidget(
          icon: Icons.refresh_rounded,
          color: Colors.blue,
          text: statusType.getString(context),
        );

      case LogStatusType.retried_ignored:
        return logStatusWidget(
          icon: Icons.refresh_rounded,
          color: Colors.blue,
          text: statusType.getString(context),
        );

      case LogStatusType.ok_already_forwarded:
        return logStatusWidget(
          icon: Icons.verified_user_rounded,
          color: Colors.green,
          text: statusType.getString(context),
        );

      case LogStatusType.database_busy:
        return logStatusWidget(
          icon: Icons.storage_rounded,
          color: Colors.orange,
          text: statusType.getString(context),
        );

      case LogStatusType.blocked_special_domain:
        return logStatusWidget(
          icon: Icons.gpp_bad_rounded,
          color: Colors.orange,
          text: statusType.getString(context),
        );

      default:
        return logStatusWidget(
          icon: Icons.shield_rounded,
          color: Colors.grey,
          text: statusType.getString(context),
        );
    }
  }

  Widget logStatusWidget({
    required IconData icon,
    required Color color,
    required String? text,
  }) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Icon(
            icon,
            color: color,
            size: 14,
          ),
        ),
        Text(
          text ?? '',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
