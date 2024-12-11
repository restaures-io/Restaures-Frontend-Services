import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restaures/components/Global/api_constants.dart';
import 'package:restaures/components/Global/api_response.dart';
import 'package:toastification/toastification.dart';

class ApiService {
  Uri _getUri(String endpoint) {
    return Uri.parse('${ApiUrl.baseUrl}$endpoint');
  }

  String _accessToken() {
    return "";
  }

  Map<String, String> _headers() {
    return {
      "Content-Type": "application/json",
      "token": _accessToken(),
    };
  }

  Future<ApiResponse> _sendRequest(
      Future<http.Response> Function() requestFunc, Uri uri,
      {dynamic body}) async {
    try {
      _logRequest(uri, body);
      final response = await requestFunc();
      ApiResponse? apiResponse;
      if (_isBadRequest(response.statusCode)) {
        Map<String, dynamic> parsedResponse = jsonDecode(response.body)[0];
        for (var message in parsedResponse['errors']['issues']) {
          log("Error during API call to $uri: ${message['message']}");
          apiResponse = ApiResponse(
            data: null,
            message: message['message'],
            success: false,
          );
          toastification.show(
            title: Text(apiResponse.message),
            showIcon: true,
            type: ToastificationType.error,
            autoCloseDuration: const Duration(seconds: 5),
          );
        }

        return apiResponse ?? ApiResponse.fromJson(jsonDecode(response.body));
      }
      apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
      _logResponse(uri, response);
      if (!apiResponse.success) {
        log("Error during API call to $uri: ${apiResponse.message}");
        apiResponse.message = apiResponse.message;
        apiResponse.data = null;
        toastification.show(
          title: Text(apiResponse.message),
          showIcon: true,
          type: ToastificationType.error,
          autoCloseDuration: const Duration(seconds: 5),
        );
        return apiResponse;
      }
      if (_isUnauthorized(response.statusCode) && apiResponse.success) {
        _handleUnauthorizedAccess();
      }

      return apiResponse;
    } catch (e) {
      log("Error during API call to $uri: $e");
      rethrow;
    }
  }

  void _logRequest(Uri uri, dynamic body) {
    log("Request URL: $uri");
    if (body != null) log("Request Body: ${jsonEncode(body)}");
  }

  void _logResponse(Uri uri, http.Response response) {
    log("Response for URL: $uri");
    log("Status Code: ${response.statusCode}");
    log("Response Body: ${response.body}");
  }

  bool _isUnauthorized(int statusCode) {
    return statusCode == 401 || statusCode == 403;
  }

  bool _isBadRequest(int statusCode) {
    return statusCode == 400;
  }

  void _handleUnauthorizedAccess() {
    log("Unauthorized access detected.");
  }

  Future<ApiResponse> get(String endpoint) async {
    Uri uri = _getUri(endpoint);
    return _sendRequest(() => http.get(uri, headers: _headers()), uri);
  }

  Future<ApiResponse> post(String endpoint, dynamic body) async {
    Uri uri = _getUri(endpoint);
    return _sendRequest(
        () => http.post(uri, headers: _headers(), body: jsonEncode(body)), uri,
        body: body);
  }

  Future<ApiResponse> put(String endpoint, dynamic body) async {
    Uri uri = _getUri(endpoint);
    return _sendRequest(
        () => http.put(uri, headers: _headers(), body: jsonEncode(body)), uri,
        body: body);
  }

  Future<ApiResponse> patch(String endpoint, dynamic body) async {
    Uri uri = _getUri(endpoint);
    return _sendRequest(
        () => http.patch(uri, headers: _headers(), body: jsonEncode(body)), uri,
        body: body);
  }

  Future<ApiResponse> delete(String endpoint, {dynamic body}) async {
    Uri uri = _getUri(endpoint);
    return _sendRequest(
        () => http.delete(uri, headers: _headers(), body: jsonEncode(body)),
        uri,
        body: body);
  }
}
