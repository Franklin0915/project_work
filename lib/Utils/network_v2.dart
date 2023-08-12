import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vehicle_recognition/Utils/constants.dart';
import 'package:vehicle_recognition/Utils/errors.dart';

import 'network.dart';

class NetworkServiceV2 {
  late HttpClient _client;

  NetworkServiceV2() {
    _client = HttpClient()
      ..connectionTimeout = const Duration(seconds: 10000)
      ..badCertificateCallback = (cert, host, port) => true;
  }

  Future<NetworkResponse> postFile({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    required File file,
  }) async {
    // final request = _client.postUrl(Uri.parse(kBaseUrl));
    // final fileStream = file.openRead();
    // final fileLength = await file.length();
    // final multipartRequest = await request;
    // multipartRequest.headers.contentType = ContentType('multipart', 'form-data');

    // final multipartFile = MultipartRequest('', request.uri);
    // multipartRequest.add(multipartFile);

    // final response = await multipartRequest.close();
    final request = await _client.postUrl(Uri.parse(kBaseUrl)); // Use the provided URL parameter
    final fileStream = file.openRead();
    final fileLength = await file.length();
    final multipartRequest = http.MultipartRequest('', request.uri); // Initialize MultipartRequest from http package

    if (headers != null) {
      headers.forEach((key, value) {
        multipartRequest.headers[key] = value;
      });
    }

    multipartRequest.files.add(http.MultipartFile(
      'file',
      fileStream,
      fileLength,
      filename: file.path,
    ));

    // Send the request and get the response
    final response = await multipartRequest.send();

    // Read response data and transform it into NetworkResponse
    final responseData = await response.stream.toBytes();
    final responseJson = json.decode(utf8.decode(responseData));
    if (!response.statusCode.toString().contains("2")) {
      throw ApiFailure("failed to send file");
    }
    return NetworkResponse(data: responseJson["data"], result: NetworkResult.SUCCESS);
  }

  Future<String> postFileV2({
    required File file,
  }) async {
    try {
      final postUri = Uri.parse(kBaseUrl);
      http.MultipartRequest request = http.MultipartRequest("POST", postUri);
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath('file', file.path);
      request.files.add(multipartFile);

      http.StreamedResponse streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (!response.statusCode.toString().startsWith("2")) {
        throw ApiFailure("an error occured");
      }
      debugPrint(response.body);
      return response.body;
    } catch (e) {
      throw ApiFailure(e.toString());
    }
  }
}
