import 'package:dio/dio.dart';
import 'package:pihole_manager/enums/protocol.dart';
import 'package:pihole_manager/models/server_details.dart';

class Pihole {
  final String host;
  final String? port;
  final Protocol protocol;
  final String? user;
  final String? password;
  final String? token;

  Pihole({
    required this.protocol,
    required this.host,
    this.user,
    this.password,
    this.token,
    this.port = '',
  }) {
    init();
  }

  Pihole.fromServer({required ServerDetails server})
      : protocol = server.protocol,
        host = server.host,
        port = server.port,
        user = server.user,
        password = server.password,
        token = server.authToken {
    init();
  }

  Dio? dio;

  String get address => '$host${port!.isNotEmpty ? ':$port' : ''}';

  void init() {
    dio = Dio(BaseOptions(baseUrl: '${protocol.getString()}://$address'));
  }

  Future<Response> get(
      {Map<String, String>? additionalParams,
      int? limit,
      bool? addTimestamp}) async {
    Map<String, dynamic> params = {
      'auth': token,
    };
    if (additionalParams != null) params.addAll(additionalParams);
    if (addTimestamp != null) params['_'] = DateTime.timestamp().millisecond;

    return await dio!.get(
      '/admin/api.php',
      queryParameters: params,
    );
  }

  Future<Map<String, dynamic>> getData(
      {Map<String, String>? additionalParams,
      int? limit,
      bool? addTimestamp}) async {
    final response = await get(
      additionalParams: additionalParams,
      limit: limit,
      addTimestamp: addTimestamp,
    );
    if (response.statusCode == 200) {
      return response.data as Map<String, dynamic>;
    } else {
      return {};
    }
  }

  Future<bool> checkConnection() async {
    try {
      final response = await get(
        additionalParams: {'status': ''},
      );
      if (response.statusCode == 200) {
        return (response.data as Map<String, dynamic>).containsKey('status');
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>> getPiHoleSummary() async {
    return await getData(
      additionalParams: {'summary': ''},
    );
  }

  Future<Map<String, dynamic>> getQueryTypes() async {
    return await getData(
      additionalParams: {'getQueryTypes': ''},
    );
  }

  Future<Map<String, dynamic>> getForwardDestinations() async {
    return await getData(
      additionalParams: {'getForwardDestinations': ''},
    );
  }

  Future<Map<String, dynamic>> getTopItems() async {
    return await getData(
      additionalParams: {'topItems': ''},
    );
  }

  Future<Map<String, dynamic>> getQuerySources() async {
    return await getData(
      additionalParams: {'getQuerySources': ''},
    );
  }

  Future<Map<String, dynamic>> topClientsBlocked() async {
    return await getData(
      additionalParams: {'topClientsBlocked': ''},
    );
  }

  Future<Map<String, dynamic>> getAllQueries(
      {int? limit, bool? addTimestamp}) async {
    return await getData(
      additionalParams: {'getAllQueries': ''},
      limit: limit,
      addTimestamp: addTimestamp,
    );
  }

  Future<Map<String, dynamic>> getOverTimeDataClients() async {
    return await getData(
      additionalParams: {
        'overTimeDataClients': '',
        'getClientNames': '',
      },
    );
  }
}
