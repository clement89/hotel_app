import 'dart:convert';

import 'package:firebase_demo/business_logic/models/api_repository.dart';
import 'package:firebase_demo/business_logic/models/hotel.dart';
import 'package:firebase_demo/networking/api_response.dart';
import 'package:flutter/cupertino.dart';

class HomeViewModel extends ChangeNotifier {
  ApiRepository _apiRepository = ApiRepository();
  late Hotel hotel;
  String errorMessage = '';
  bool isLoading = false;

  void loadHotelInfo() async {
    isLoading = true;

    ApiResponse response = await _apiRepository.getHotelInfo();
    if (response.isError) {
      errorMessage = response.errorMessage;
    } else {
      List<dynamic> responseData = jsonDecode(response.data);
      hotel = Hotel.fromMap(responseData.first);
      errorMessage = '';
    }

    isLoading = false;
    notifyListeners();
  }
}
