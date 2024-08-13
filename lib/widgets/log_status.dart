import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogStatus extends StatelessWidget {
  final String status;

  const LogStatus({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case '1':
        return logStatusWidget(
          icon: Icons.gpp_bad_rounded,
          color: Colors.red,
          text: AppLocalizations.of(context)?.logStatusBlockedGravity,
        );

      case '2':
        return logStatusWidget(
          icon: Icons.verified_user_rounded,
          color: Colors.green,
          text: AppLocalizations.of(context)?.logStatusOKForwarded,
        );

      case '3':
        return logStatusWidget(
          icon: Icons.verified_user_rounded,
          color: Colors.green,
          text: AppLocalizations.of(context)?.logStatusOKCache,
        );

      case '4':
        return logStatusWidget(
          icon: Icons.gpp_bad_rounded,
          color: Colors.red,
          text: AppLocalizations.of(context)?.logStatusBlockedRegexBlack,
        );

      case '5':
        return logStatusWidget(
          icon: Icons.gpp_bad_rounded,
          color: Colors.red,
          text: AppLocalizations.of(context)?.logStatusBlockedBlack,
        );

      case '6':
        return logStatusWidget(
          icon: Icons.gpp_bad_rounded,
          color: Colors.red,
          text: AppLocalizations.of(context)?.logStatusBlockedExternalIP,
        );

      case '7':
        return logStatusWidget(
          icon: Icons.gpp_bad_rounded,
          color: Colors.red,
          text: AppLocalizations.of(context)?.logStatusBlockedExternalNull,
        );

      case '8':
        return logStatusWidget(
          icon: Icons.gpp_bad_rounded,
          color: Colors.red,
          text: AppLocalizations.of(context)?.logStatusBlockedExternalNxra,
        );

      case '9':
        return logStatusWidget(
          icon: Icons.gpp_bad_rounded,
          color: Colors.red,
          text: AppLocalizations.of(context)?.logStatusBlockedGravityCName,
        );

      case '10':
        return logStatusWidget(
          icon: Icons.gpp_bad_rounded,
          color: Colors.red,
          text: AppLocalizations.of(context)?.logStatusBlockedRegexBlackCName,
        );

      case '11':
        return logStatusWidget(
          icon: Icons.gpp_bad_rounded,
          color: Colors.red,
          text: AppLocalizations.of(context)?.logStatusBlockedBlackCName,
        );

      case '12':
        return logStatusWidget(
          icon: Icons.refresh_rounded,
          color: Colors.blue,
          text: AppLocalizations.of(context)?.logStatusRetried,
        );

      case '13':
        return logStatusWidget(
          icon: Icons.refresh_rounded,
          color: Colors.blue,
          text: AppLocalizations.of(context)?.logStatusRetriedIgnored,
        );

      case '14':
        return logStatusWidget(
          icon: Icons.verified_user_rounded,
          color: Colors.green,
          text: AppLocalizations.of(context)?.logStatusOKAlreadyForwarded,
        );

      case '15':
        return logStatusWidget(
          icon: Icons.storage_rounded,
          color: Colors.orange,
          text: AppLocalizations.of(context)?.logStatusDatabaseBusy,
        );

      case '16':
        return logStatusWidget(
          icon: Icons.gpp_bad_rounded,
          color: Colors.orange,
          text: AppLocalizations.of(context)?.logStatusBlockedSpecialDomain,
        );

      default:
        return logStatusWidget(
          icon: Icons.shield_rounded,
          color: Colors.grey,
          text: AppLocalizations.of(context)?.logStatusUnknown,
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
