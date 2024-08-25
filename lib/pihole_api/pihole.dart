import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pihole_manager/enums/log_status_type.dart';
import 'package:pihole_manager/enums/number_of_records.dart';
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
    _init();
  }

  Pihole.fromServer({required ServerDetails server})
      : protocol = server.protocol,
        host = server.host,
        port = server.port,
        user = server.user,
        password = server.password,
        token = server.authToken {
    _init();
  }

  Dio? dio;

  String get address => '$host${port!.isNotEmpty ? ':$port' : ''}';

  void _init() {
    dio = Dio(BaseOptions(baseUrl: '${protocol.getString()}://$address'));
  }

  Future<Response> _get({
    Map<String, dynamic>? additionalParams,
    bool isApi = true,
  }) async {
    Map<String, dynamic> params = {
      'auth': token,
    };
    if (additionalParams != null) params.addAll(additionalParams);

    return await dio!.get(
      '/admin/${isApi ? 'api' : 'api_db'}.php',
      queryParameters: params,
    );
  }

  Future<Map<String, dynamic>> _getData({
    Map<String, dynamic>? additionalParams,
    bool isApi = true,
  }) async {
    final response = await _get(
      additionalParams: additionalParams,
      isApi: isApi,
    );
    if (response.statusCode == 200) {
      return response.data as Map<String, dynamic>;
    } else {
      return {};
    }
  }

  Future<bool> checkConnection() async {
    try {
      final response = await _get(
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
    return await _getData(
      additionalParams: {'summary': ''},
    );
  }

  Future<Map<String, dynamic>> getQueryTypes() async {
    return await _getData(
      additionalParams: {'getQueryTypes': ''},
    );
  }

  Future<Map<String, dynamic>> getForwardDestinations() async {
    return await _getData(
      additionalParams: {'getForwardDestinations': ''},
    );
  }

  Future<Map<String, dynamic>> getTopItems() async {
    return await _getData(
      additionalParams: {'topItems': ''},
    );
  }

  Future<Map<String, dynamic>> getQuerySources() async {
    return await _getData(
      additionalParams: {'getQuerySources': ''},
    );
  }

  Future<Map<String, dynamic>> topClientsBlocked() async {
    return await _getData(
      additionalParams: {'topClientsBlocked': ''},
    );
  }

  Future<Map<String, dynamic>> getAllQueries({
    String? forwarddest,
    NumberOfRecords? numberOfRecords,
  }) async {
    return await _getData(
      additionalParams: {
        'getAllQueries':
            (numberOfRecords ?? NumberOfRecords.hundred).getValue(),
        if (forwarddest != null) 'forwarddest': forwarddest,
        '_': DateTime.timestamp().millisecondsSinceEpoch,
      },
    );
  }

  Future<Map<String, dynamic>> getAllQueriesByStatus({
    LogStatusType? status,
    NumberOfRecords? numberOfRecords,
    DateTimeRange? range,
  }) async {
    final response = await _get(
      additionalParams: {
        'getAllQueries': '',
        if (status != null) 'status': status.getQueryTypes(),
        if (range != null) 'from': range.start.millisecondsSinceEpoch / 1000,
        if (range != null) 'until': range.end.millisecondsSinceEpoch / 1000,
        '_': DateTime.timestamp().millisecondsSinceEpoch / 1000,
      },
      isApi: false,
    );
    if (response.statusCode == 200) {
      return response.data as Map<String, dynamic>;
    } else {
      return {};
    }
  }

  Future<Map<String, dynamic>> getOverTimeDataClients() async {
    return await _getData(
      additionalParams: {
        'overTimeDataClients': '',
        'getClientNames': '',
      },
    );
  }

  Future<Map<String, dynamic>> getOverTimeData10mins() async {
    return await _getData(
      additionalParams: {
        'overTimeData10mins': '',
      },
    );
  }

  Future<Map<String, dynamic>> getNetwork() async {
    return await _getData(
      additionalParams: {
        'network': '',
        '_': DateTime.timestamp().millisecondsSinceEpoch.toString(),
      },
      isApi: false,
    );
  }
}
