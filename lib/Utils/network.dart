import 'package:dio/dio.dart';

import 'constants.dart';
import 'errors.dart';

class NetworkService {
  late Dio _dio;

  NetworkService() {
    _dio = Dio(BaseOptions(
        connectTimeout: const Duration(milliseconds: 10000), baseUrl: kBaseUrl, contentType: "application/json"));

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

  Future<NetworkResponse> post(
      {required String url, Map<String, String>? headers, required Map<String, dynamic> body}) async {
    try {
      final response = await _dio.post(url, data: body);
      return handleResponse(response);
    } on DioException catch (e) {
      // print(e);
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

  NetworkResult result;

  NetworkResponse({required this.data, this.error, this.headers, required this.result});
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

NetworkResponse handleResponse(Response response) {
  if (response.statusCode.toString().startsWith("2")) {
    // if ((response.data is Map <String, dynamic> && response.data as Map<String, dynamic>).containsKey("data")) {
    //   return NetworkResponse(
    //     data: response.data,
    //     result: NetworkResult.SUCCESS,
    //   );
    // }

    return NetworkResponse(
      data: <String, dynamic>{'data': response.data},
      result: NetworkResult.SUCCESS,
    );
  }

  return handleResponse(response);
}

NetworkResponse _handleErrorResponse(DioError error) {
  return NetworkResponse(data: null, result: NetworkResult.FAILURE, error: NetworkFailure(error.toString()));
}
