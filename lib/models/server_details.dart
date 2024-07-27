import 'package:pihole_manager/enums/protocol.dart';

class ServerDetails {
  static const tableName = 'ServerDetails';
  static const hostColumn = 'host';
  static const portColumn = 'port';
  static const nameColumn = 'name';
  static const protocolColumn = 'protocol';
  static const authTokenColumn = 'authToken';
  static const userColumn = 'user';
  static const passwordColumn = 'password';

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

  String get address =>
      '${protocol.getString()}://$host${port.isNotEmpty ? ':$port' : ''}';

  static String get createTable => '''
          CREATE TABLE $tableName (
            host TEXT PRIMARY KEY,
            port INTEGER,
            name TEXT,
            protocol INTEGER,
            authToken TEXT NOT NULL,
            user TEXT,
            password TEXT
          )
          ''';

  Map<String, dynamic> toMap() {
    return {
      hostColumn: host,
      portColumn: port,
      nameColumn: name,
      protocolColumn: protocol.index,
      authTokenColumn: authToken,
      userColumn: user,
      passwordColumn: password,
    };
  }

  static ServerDetails fromMap(Map<String, dynamic> map) {
    return ServerDetails(
      host: map[hostColumn],
      port: map[portColumn],
      name: map[nameColumn],
      protocol: Protocol.values[map[protocolColumn]],
      authToken: map[authTokenColumn],
      user: map[userColumn],
      password: map[passwordColumn],
    );
  }
}
