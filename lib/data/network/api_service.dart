import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:kebormed_mobile/common/constants.dart';

/// Class for handling network API requests.
class NetworkApiService {
  Future<dynamic> getApi(String url) async {
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: AppConstants.apiTimeOut));
      responseJson = returnResponse(response);
    } on SocketException {
      throw "Internet connectivity is not stable";
    } on TimeoutException {
      throw 'Network Request time out';
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    if (kDebugMode) {
      print(response.statusCode);
    }
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 401:
        throw 'Unauthorised request';
      case 500:
      case 404:
        throw 'Invalid Input';
      default:
        throw 'Error occured while communicating with server';
    }
  }
}
