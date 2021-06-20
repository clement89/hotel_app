import 'package:firebase_demo/networking/api_client.dart';

import '../../networking/api_response.dart';

class ApiRepository {
  final WebApiClient _apiClient = WebApiClient();

  Future<ApiResponse> getHotelInfo() async {
    ApiResponse response =
        await _apiClient.getRecordsFromServer(url: '5dfccffc310000efc8d2c1ad');
    return response;
  }
}
