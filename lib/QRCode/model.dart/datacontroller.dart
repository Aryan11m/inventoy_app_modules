import 'dart:convert';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;
import 'package:inventory_app/QRCode/model.dart/getmodel.dart';

class GetDataController extends GetxController {
  var isLoading = false.obs;
  var welcome = LeaveApproval().obs;
  var errorMessage = ''.obs;

  // Method to call API with fixed payload
  getDataFromApi({String status = "Rejected"}) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      dio.Dio dioClient = dio.Dio();
      dioClient.interceptors.add(
        dio.LogInterceptor(
          requestBody: true,
          responseBody: true,
          requestHeader: true,
          responseHeader: true,
        ),
      );

      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      var requestData = {
        "EmpCode": "1300001",
        "Status": status,
        "IsManager": "0",
        "Month": "5",
        "Year": "2025",
      };

      var response = await dioClient.post(
        'https://myhrms.oriole.co.in/api/ApproveLeaveIonic/ApproveLeave',
        options: dio.Options(headers: headers),
        data: requestData,
      );

      if (response.statusCode == 200) {
        welcome.value = LeaveApproval.fromJson(response.data);
      } else {
        errorMessage.value = 'Unexpected status code: ${response.statusCode}';
      }
    } catch (e) {
      if (e is dio.DioException) {
        errorMessage.value = handleDioError(e);
      } else {
        errorMessage.value = 'Unexpected error: $e';
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getDataByMonth(int monthNumber) async {
    try {
      isLoading.value = true;

      // Replace with your actual API endpoint
      var response = await http.post(
        Uri.parse(
          'https://myhrms.oriole.co.in/api/ApproveLeaveIonic/ApproveLeave',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'month': monthNumber}),
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        welcome.value = LeaveApproval.fromJson(jsonData);
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Method to get data filtered by year
  Future<void> getDataByYear(int year) async {
    try {
      isLoading.value = true;

      var response = await http.post(
        Uri.parse(
          'https://myhrms.oriole.co.in/api/ApproveLeaveIonic/ApproveLeave',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'year': year}),
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        welcome.value = LeaveApproval.fromJson(jsonData);
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Method to get data filtered by status
  Future<void> getDataByStatus(String status) async {
    try {
      isLoading.value = true;

      var response = await http.post(
        Uri.parse(
          'https://myhrms.oriole.co.in/api/ApproveLeaveIonic/ApproveLeave',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'status': status}),
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        welcome.value = LeaveApproval.fromJson(jsonData);
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Method to get data with combined filters
  Future<void> getDataWithFilters(Map<String, dynamic> filters) async {
    try {
      isLoading.value = true;

      var response = await http.post(
        Uri.parse(
          'https://myhrms.oriole.co.in/api/ApproveLeaveIonic/ApproveLeave',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(filters),
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        welcome.value = LeaveApproval.fromJson(jsonData);
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Optional method to test multiple HTTP methods
  testApiMethods() async {
    List<String> methods = ['GET', 'POST', 'PUT'];

    for (String method in methods) {
      try {
        print('Testing $method method...');

        dio.Response response;
        var dioClient = dio.Dio();

        switch (method) {
          case 'GET':
            response = await dioClient.get(
              'https://myhrms.oriole.co.in/api/ApproveLeaveIonic/ApproveLeave',
              options: dio.Options(headers: {'Accept': 'application/json'}),
            );
            break;
          case 'POST':
            response = await dioClient.post(
              'https://myhrms.oriole.co.in/api/ApproveLeaveIonic/ApproveLeave',
              options: dio.Options(
                headers: {'Content-Type': 'application/json'},
              ),
              data: {
                // "EmpCode": "1300001",
                // "Status": "Pending",
                // "IsManager": "0",
                // "Month": "5",
                // "Year": "2025",
              },
            );
            break;
          case 'PUT':
            response = await dioClient.put(
              'https://myhrms.oriole.co.in/api/ApproveLeaveIonic/ApproveLeave',
              options: dio.Options(
                headers: {'Content-Type': 'application/json'},
              ),
              data: {},
            );
            break;
          default:
            continue;
        }

        print('$method Success: ${response.statusCode}');
        return; // Exit if successful
      } catch (e) {
        print('$method Failed: $e');
      }
    }
  }

  // Helper method to handle Dio errors
  String handleDioError(dio.DioException e) {
    switch (e.response?.statusCode) {
      case 401:
        return 'Authentication required';
      case 403:
        return 'Access forbidden';
      case 404:
        return 'API endpoint not found';
      case 405:
        return 'Method not allowed - check API documentation';
      case 500:
        return 'Server error';
      default:
        return 'Network error: ${e.message}';
    }
  }
}
