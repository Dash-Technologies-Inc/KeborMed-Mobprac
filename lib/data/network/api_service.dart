import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:kebormed_mobile/common/constants.dart';
import 'package:kebormed_mobile/common/labels.dart';

import '../../utils/session/preference.dart';

/// Class for handling network API requests.
class NetworkApiService {
  Future<dynamic> getApi(String url) async {
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    try {
      //check the authentication
      if(!checkAuthentication()){
        throw Labels.unauthoriseMessage;
      }else {
        final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: AppConstants.apiTimeOut));
        responseJson = returnResponse(response);
      }
    } on SocketException {
      throw Labels.internetErrorMessage;
    } on TimeoutException {
      throw Labels.timeoutErrorMessage;
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  //return response based on status code
  dynamic returnResponse(http.Response response) {
    if (kDebugMode) {
      print(response.statusCode);
    }
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw Labels.badrequestMessage;
      case 401:
        throw Labels.unauthoriseMessage;
      case 500:
        throw Labels.serverErrorMessage;
      case 404:
        throw Labels.requestNotMessage;
      default:
        throw Labels.defaultErrorMessage;
    }
  }

  //check the token is missing or not for dummy authentication
  bool checkAuthentication(){
    var token = Preference.getToken();
    return token.isEmpty ? false : true;
  }
}
