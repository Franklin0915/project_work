import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'errors.dart';

class NetworkService {
  late Dio _dio;
  bool isMultipartForm = false;

  NetworkService() {
    _dio = Dio(BaseOptions(
      connectTimeout: const Duration(milliseconds: 10000),
      baseUrl: kBaseUrl,
      contentType: isMultipartForm ? 'multipart/form-data' : "application/json",
    ));

    // bypassing TLS/SSL. Not Advisable
    (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };

    _dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) => handler.resolve(
          Response(
              statusCode: response.statusCode,
              requestOptions: RequestOptions(path: kBaseUrl),
              headers: response.headers,
              statusMessage: response.statusMessage,
              extra: response.extra,
              data: response.data),
        ),
      ),
    );
  }

  Future<NetworkResponse> get({required String url}) async {
    try {
      final response = await _dio.get(url);
      return handleResponse(response);
    } on DioError catch (e) {
      return _handleErrorResponse(e);
    }
  }

  Future<NetworkResponse> post({
    required bool isFormData,
    required String url,
    Map<String, String>? headers,
    required Map<String, dynamic> body,
  }) async {
    try {
      (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      };

      FormData formData = FormData.fromMap(body);
      final response = isFormData ? await _dio.post(url, data: formData) : await _dio.post(url, data: body);
      return handleResponse(response);
    } on DioException catch (e) {
      return _handleErrorResponse(e);
    }
  }
}

class NetworkResponse {
  // data contains the actual data expected from the server

  Map<String, dynamic>? data;

  // error
  Failure? error;

  // optional headers of response
  Map<String, dynamic>? headers;

  int? status;

  NetworkResult result;

  NetworkResponse({
    required this.data,
    this.error,
    this.headers,
    required this.result,
    this.status,
  });
}

enum NetworkResult {
  SUCCESS,
  FAILURE,
  NO_INTERNET_CONNECTION,
  SERVER_ERROR,
  BAD_REQUEST,
  UNAUTHORISED,
  FORBIDDEN,
  NO_SUCH_ENDPOINT,
  METHOD_DISALLOWED,
  SERVER_TIMEOUT,
  TOO_MANY_REQUESTS,
  NOT_IMPLEMENTED,
  NOT_FOUND
}

NetworkResponse handleResponse(Response? response) {
  if (response == null) {
    return NetworkResponse(data: null, result: NetworkResult.SERVER_ERROR);
  }
  if (response.statusCode.toString().startsWith("2")) {
    if (response.data["data"] == null) {
      return NetworkResponse(
        data: {'data': response.data["data"]},
        result: NetworkResult.SUCCESS,
      );
    }
    return NetworkResponse(
      data: <String, dynamic>{'data': response.data["data"]},
      result: NetworkResult.SUCCESS,
    );
  } else {
    switch (response.statusCode) {
      case 300:
        return NetworkResponse(
            data: <String, dynamic>{'data': response.data["data"]},
            result: NetworkResult.FORBIDDEN,
            error: Failure(response.statusMessage!));
      case 400:
        return NetworkResponse(
            data: <String, dynamic>{'data': response.data["data"]},
            result: NetworkResult.UNAUTHORISED,
            error: Failure(response.statusMessage!));
      case 500:
        return NetworkResponse(
            data: <String, dynamic>{'data': response.data["data"]},
            result: NetworkResult.SERVER_ERROR,
            error: Failure(response.statusMessage!));
      default:
        return NetworkResponse(
            data: <String, dynamic>{'data': response.data["data"]},
            result: NetworkResult.FAILURE,
            error: Failure(response.statusMessage!));
    }
  }

  // return handleResponse(response);
}

NetworkResponse _handleErrorResponse(DioError error) {
  return NetworkResponse(data: null, result: NetworkResult.FAILURE, error: NetworkFailure(error.toString()));
}
