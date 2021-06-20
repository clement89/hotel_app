import 'dart:async';
import 'dart:io';

import 'package:firebase_demo/networking/api_response.dart';
import 'package:http/http.dart' as http;

class WebApiClient {
  final String baseUrl = 'https://www.mocky.io/v2/';

  Future<ApiResponse> getRecordsFromServer({required String url}) async {
    print('GET --------- ${baseUrl + url}');
    try {
      http.Response response = await http.get(Uri.parse(baseUrl + url));
      if (response.statusCode == 200) {
        return ApiResponse(false, '', response.body);
      } else {
        print(response.statusCode);
        return ApiResponse(true, 'Error getting response from server', '');
      }
    } on SocketException {
      return ApiResponse(true, 'No internet connection', '');
    }
  }
}
