import 'dart:convert';
import 'dart:developer';

import 'dart:developer';

import 'package:api_task/modules/Home/models/login_model.dart';
import 'package:api_task/modules/Home/views/home_screen.dart';
import 'package:api_task/network/EndPoints.dart';
import 'package:api_task/network/api_service_class.dart';
import 'package:api_task/utils/const/cache_keys.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class AuthController extends GetxController {

  Rx<LoginModel> loginModel =  LoginModel().obs;


  signIn({String? email, String? password}) async {
    await APIService().callAPI(
        params: {},
        body: {"email": email, "password": password},
        headers: {},
        serviceUrl: EndPoints.baseUrl + EndPoints.signInURL,
        method: APIService.postMethod,
        success: (dio.Response response) {
          loginModel.value =  LoginModel.fromJson(response.data);
          getPref.write(CacheKeys.loginKey, loginModel.value.toJson());
          Get.snackbar("Success", "Login Successfully");
          Get.offAll(()=> const HomeScreen());
        },
        error: (dio.Response response) {
          // final decoded = jsonDecode(response.data);
          log(">>>> RESPONSE SUCCESS >> ${response.data}");
          log(">>>> RESPONSE ERROR >> ${response}");
          log(">>>> RESPONSE ERROR >> ${response.data}");
          Get.snackbar("Error", "Something went wrong");
        },
        showProcess: true);
  }

  signUp(
      {String? email,
      String? password,
      String? fullName,
      String? username,
      String? firstName,
      String? lastName,
      String? middleName,
      String? phoneNumber,
      String? walletPin,
      String? deviceId,
      String? deviceIp,
      String? deviceModel,
      String? street1,
      String? street2,
      String? city,
      String? state,
      String? country,
      String? zipCode}) async {
    await APIService().callAPI(
        params: {},
        body: {
          "email": email, "password": password,
          "username": username,
          "firstName": firstName,
          "lastName": lastName,
          "middleName": middleName,
          "phoneNumber": phoneNumber,
          "walletPin": 0,
          "deviceId": deviceId,
          "deviceIp": deviceIp,
          "deviceModel": deviceModel,
          "billingAddress": {
            "street1": street1,
            "street2": street2,
            "city": city,
            "state": state,
            "zipCode": zipCode,
            "country": country,
          }
        },
        // formDataMap: {},
        headers: {},
        serviceUrl: EndPoints.baseUrl + EndPoints.signUpURL,
        method: APIService.postMethod,
        success: (dio.Response response) {
          final decoded = jsonDecode(response.data);
          // log(">>>> RESPONSE SUCCESS >> ${decoded['status']}");
          Get.back();
          Get.snackbar("Success", "Signup Successfully");
        },
        error: (dio.Response response) {
          // final decoded = jsonDecode();
          log(">>>> RESPONSE ERROR >> ${response.data}");
          Get.snackbar("Error", "Something went wrong");
        },
        showProcess: true);
  }
}
