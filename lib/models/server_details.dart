import 'package:pihole_manager/enums/protocol.dart';

class ServerDetails {
  final String host;
  final String port;
  final String name;
  final Protocol protocol;
  final String? authToken;
  final String? user;
  final String? password;

  ServerDetails({
    required this.host,
    required this.port,
    required this.name,
    required this.protocol,
    this.authToken,
    this.user,
    this.password,
  });

  String get address => '$host${port.isNotEmpty ? ':$port' : ''}';
}
