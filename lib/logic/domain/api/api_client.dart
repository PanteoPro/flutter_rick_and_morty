import 'dart:convert';
import 'dart:io';
// import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rick_and_morty_app/logic/domain/entity/all_character_response.dart';
import 'package:rick_and_morty_app/logic/domain/entity/all_episode_response.dart';
import 'package:rick_and_morty_app/logic/domain/entity/all_location_response.dart';

enum ApiClientExceptionType { Network, Auth, Other }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}

class ApiClient {
  // final _client = HttpClient();
  static const _host = 'https://rickandmortyapi.com/api';
  static const _hostAuth = 'http://192.168.1.4:8000';
  static const _timeout = Duration(seconds: 10);

  Uri _makeUrl(String method, {Map<String, String>? params, String? host}) {
    final placeHost = host ?? _host;
    final url = Uri.parse(placeHost + method);
    if (params != null) {
      return url.replace(queryParameters: params);
    } else {
      return url;
    }
  }

  Future<void> login({required String login, required String password}) async {
    const method = '/login/';

    final json = await _post(method, login, password);
    final result = json['result'] as bool;

    if (!result) {
      throw ApiClientException(ApiClientExceptionType.Auth);
    }
  }

  Future<void> register({required String login, required String password}) async {
    const method = '/register/';

    final json = await _post(method, login, password);
    final result = json['result'] as bool;

    if (!result) {
      throw ApiClientException(ApiClientExceptionType.Auth);
    }
  }

  Future<AllCharacterResponse> getCharacters(int page) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      return AllCharacterResponse.fromJson(jsonMap);
    };
    final json = await _get(
      '/character/',
      parser: parser,
      params: <String, String>{'page': page.toString()},
    );
    return json;
  }

  Future<AllEpisodeResponse> getEpisodes(int page) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      return AllEpisodeResponse.fromJson(jsonMap);
    };
    final json = await _get(
      '/episode/',
      parser: parser,
      params: <String, String>{'page': page.toString()},
    );
    return json;
  }

  Future<AllLocationResponse> getLocations(int page) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      return AllLocationResponse.fromJson(jsonMap);
    };
    final json = await _get(
      '/location/',
      parser: parser,
      params: {'page': page.toString()},
    );
    return json;
  }

  Future<Map<String, dynamic>> _post(String method, String login, String password) async {
    final body = jsonEncode(<String, String>{
      'login': login,
      'password': password,
    });
    final url = _makeUrl(method, host: _hostAuth);

    try {
      final response = await http.post(url, body: body).timeout(_timeout, onTimeout: () {
        return http.Response('Error', 500);
      });
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        return jsonResponse;
      } else if (response.statusCode == 500) {
        throw SocketException;
      } else {
        throw ApiClientException(ApiClientExceptionType.Other);
      }
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.Other);
    }
  }

  Future<T> _get<T>(
    String method, {
    required T Function(dynamic json) parser,
    Map<String, String>? params,
  }) async {
    final url = _makeUrl(method, params: params);

    try {
      final response = await http.get(url).timeout(_timeout, onTimeout: () {
        return http.Response('Error', 500);
      });
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        return parser(jsonResponse);
      } else {
        throw ApiClientException(ApiClientExceptionType.Other);
      }
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.Other);
    }
  }
}
