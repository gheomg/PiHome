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

  Future<Response> get({String? method, int? limit, bool? addTimestamp}) async {
    Map<String, dynamic> params = {
      'auth': token,
    };
    if (method != null) params[method] = limit ?? '';

    if (addTimestamp != null) params['_'] = DateTime.timestamp().millisecond;

    return await dio!.get(
      '/admin/api.php',
      queryParameters: params,
    );
  }

  Future<Map<String, dynamic>> getData(
      {String? method, int? limit, bool? addTimestamp}) async {
    final response =
        await get(method: method, limit: limit, addTimestamp: addTimestamp);
    if (response.statusCode == 200) {
      return response.data as Map<String, dynamic>;
    } else {
      return {};
    }
  }

  Future<bool> checkConnection() async {
    try {
      final response = await get(method: 'status');
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
    return await getData(method: 'summary');
  }

  Future<Map<String, dynamic>> getQueryTypes() async {
    return await getData(method: 'getQueryTypes');
  }

  Future<Map<String, dynamic>> getForwardDestinations() async {
    return await getData(method: 'getForwardDestinations');
  }

  Future<Map<String, dynamic>> getTopItems() async {
    return await getData(method: 'topItems');
  }

  Future<Map<String, dynamic>> getQuerySources() async {
    return await getData(method: 'getQuerySources');
  }

  Future<Map<String, dynamic>> topClientsBlocked() async {
    return await getData(method: 'topClientsBlocked');
  }

  Future<Map<String, dynamic>> getAllQueries(
      {int? limit, bool? addTimestamp}) async {
    return await getData(
        method: 'getAllQueries', limit: limit, addTimestamp: addTimestamp);
  }
}
