// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:inventory_app/QRCode/model.dart/getmodel.dart';

class GetDataController extends GetxController {
  var isLoading = false.obs;
  var welcome = Welcome(superheros: []).obs;

  getDataFromApi() async {
    isLoading.value = true;
    try {
      var response = await Dio().get(
        'https://protocoderspoint.com/jsondata/superheros.json',
      );
      welcome.value = Welcome.fromJson(response.data);
      print(response);
      isLoading.value = false;
    } catch (e) {
      print(e);
    }
  }
}
