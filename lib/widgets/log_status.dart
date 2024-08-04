import 'package:flutter/material.dart';

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
          text: 'Blocked (gravity)',
        );

      case '2':
        return logStatusWidget(
          icon: Icons.verified_user_rounded,
          color: Colors.green,
          text: 'OK (forwarded)',
        );

      case '3':
        return logStatusWidget(
          icon: Icons.verified_user_rounded,
          color: Colors.green,
          text: 'OK (cache)',
        );

      case '4':
        return logStatusWidget(
          icon: Icons.gpp_bad_rounded,
          color: Colors.red,
          text: 'Blocked (regex blacklist)',
        );

      case '5':
        return logStatusWidget(
          icon: Icons.gpp_bad_rounded,
          color: Colors.red,
          text: 'Blocked (exact blacklist)',
        );

      case '6':
        return logStatusWidget(
          icon: Icons.gpp_bad_rounded,
          color: Colors.red,
          text: 'Blocked (external, IP)',
        );

      case '7':
        return logStatusWidget(
          icon: Icons.gpp_bad_rounded,
          color: Colors.red,
          text: 'Blocked (external, NULL)',
        );

      case '8':
        return logStatusWidget(
          icon: Icons.gpp_bad_rounded,
          color: Colors.red,
          text: 'Blocked (external, NXRA)',
        );

      case '9':
        return logStatusWidget(
          icon: Icons.gpp_bad_rounded,
          color: Colors.red,
          text: 'Blocked (gravity, CNAME)',
        );

      case '10':
        return logStatusWidget(
          icon: Icons.gpp_bad_rounded,
          color: Colors.red,
          text: 'Blocked (regex blacklist, CNAME)',
        );

      case '11':
        return logStatusWidget(
          icon: Icons.gpp_bad_rounded,
          color: Colors.red,
          text: 'Blocked (exact blacklist, CNAME)',
        );

      case '12':
        return logStatusWidget(
          icon: Icons.refresh_rounded,
          color: Colors.blue,
          text: 'Retried',
        );

      case '13':
        return logStatusWidget(
          icon: Icons.refresh_rounded,
          color: Colors.blue,
          text: 'Retried (ignored)',
        );

      case '14':
        return logStatusWidget(
          icon: Icons.verified_user_rounded,
          color: Colors.green,
          text: 'OK (already forwarded)',
        );

      case '15':
        return logStatusWidget(
          icon: Icons.storage_rounded,
          color: Colors.orange,
          text: 'Database is busy',
        );

      case '16':
        return logStatusWidget(
          icon: Icons.gpp_bad_rounded,
          color: Colors.orange,
          text: 'Blocked (special domain)',
        );

      default:
        return logStatusWidget(
          icon: Icons.shield_rounded,
          color: Colors.grey,
          text: 'Unknown',
        );
    }
  }

  Widget logStatusWidget({
    required IconData icon,
    required Color color,
    required String text,
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
          text,
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