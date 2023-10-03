import 'dart:developer';
import 'dart:io';
import 'dart:js';

import 'package:api_task/network/apiutility.dart';
import 'package:api_task/utils/const/const_text.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as get_x;
import 'package:get/get.dart';

import '../main.dart';
import 'api_config.dart';

const String somethingWrong = "Something Went Wrong";
const String responseMessage = "NO RESPONSE DATA FOUND";
const String interNetMessage = "No internet connection, Please check your internet connection and try again later";
const String connectionTimeOutMessage = "Oops.. Server not working or might be in maintenance .Please Try Again Later";
const String authenticationMessage = "The session has been Expired. Please log in again.";
const String tryAgain = "Try Again";
const String logInAgain = "LogIn Again";

///Status Code with message type array or string
// 501 : sql related err
// 401: validation array
// 201 : string error
// 400 : string error
// 200: response, string/null
// 422: array
class Api {
  Future serviceCall({
    required Map<String, dynamic> params,
    Map<String, dynamic>? headers,
    required String serviceUrl,
    required Function success,
    required Function error,
    required bool isProgressShow,
    required String methodType,
    String? deviceType,
    bool isFromLogout = false,
    bool? isLoading,
    bool? isHideLoader = true,
    dynamic? formValues,
  }) async {
    final stopwatch = Stopwatch()..start();
    if (await checkInternet()) {
      if (isProgressShow) {
        showProgressDialog();
      }
      if (formValues != null) {
        Map<String, dynamic> tempMap = <String, dynamic>{};
        for (var element in formValues.fields) {
          tempMap[element.key] = element.value;
        }
        dynamic reGenerateFormData = tempMap;
        for (var element in formValues.files) {
          reGenerateFormData.files.add(MapEntry(element.key, element.value));
        }
        formValues = reGenerateFormData;
      }
      Map<String, dynamic> headerParameters;
      headerParameters = {
        "Accept": "application/json",
        "device-type": deviceType ??= Platform.isAndroid
            ? "1"
            : Platform.isIOS
                ? "2"
                : "3",
      };

      try {
        Response response;
        if (methodType == ApiConfig.methodGET) {
          response = await APIProvider.getDio().get(serviceUrl, queryParameters: params, options: Options(headers: headers ?? headerParameters));
        } else if (methodType == ApiConfig.methodPUT) {
          response = await APIProvider.getDio().put(serviceUrl, data: params, options: Options(headers: headers ?? headerParameters));
        } else if (methodType == ApiConfig.methodDELETE) {
          response = await APIProvider.getDio().delete(serviceUrl, data: params, options: Options(headers: headers ?? headerParameters));
        } else {
          response = await APIProvider.getDio().post(serviceUrl, data: formValues ?? params, options: Options(headers: headers ?? headerParameters));
        }

        if (kDebugMode) {
          logshowLog("serviceUrl ===> $serviceUrl");
          logshowLog("params ===> $params");
          logshowLog("headers ===> ${headers ?? headerParameters}");
          log("response ===> ${serviceUrl} START ??>>>  $response END ??>>>");
          logshowLog("STATUS CODE ===> ${response.statusCode}");
        }
        if (response.statusCode == 200) {

          if (isHideLoader ?? true) {
            hideProgressDialog();
          }
            success(response);
        } else if (response.statusCode == 401) {
          if (isHideLoader ?? true) {
            hideProgressDialog();
          }
          error(response);
        } else {
          //400 - Bad Request - Error Message.
          //403 - Forbidden
          //404 - Not Found
          //405 - Method Not Allowed
          //500 - Internal Server Error - Show "Something went wrong.".
          //503 - Service Unavailable

          try {

            if (isHideLoader ?? true) {
              hideProgressDialog();
            }
            error(response);
          } catch (e) {
            if (isHideLoader ?? true) {
              hideProgressDialog();
            }
          }
        }
      } on DioError catch (dioError) {
        dioErrorCall(
            dioError: dioError,
            onCallBack: (String message, bool isRecallError) {
              showErrorMessage(
                  message: message,
                  callBack: () {
                    get_x.Get.back();
                    serviceCall(params: params, serviceUrl: serviceUrl, success: success, error: error, isProgressShow: isProgressShow, methodType: methodType, formValues: formValues, isFromLogout: isFromLogout, isHideLoader: isHideLoader, isLoading: isLoading);
                  });
            });
      } catch (e) {
        hideProgressDialog();
        logshowLog(" API ERROR >> ${e.toString()}");
        // showErrorMessage(
        //     message: e.toString(),
        //     callBack: () {
        //       get_x.Get.back();
        //       serviceCall(params: params, serviceUrl: serviceUrl, success: success, error: error, isProgressShow: isProgressShow, methodType: methodType, formValues: formValues, isFromLogout: isFromLogout, isHideLoader: isHideLoader, isLoading: isLoading);
        //     });
        // GeneralController.to.isLoading.value = false;
      }
    } else {
      showErrorMessage(
          message: interNetMessage,
          callBack: () {
            get_x.Get.back();
            serviceCall(params: params, serviceUrl: serviceUrl, success: success, error: error, isProgressShow: isProgressShow, methodType: methodType, formValues: formValues, isFromLogout: isFromLogout, isHideLoader: isHideLoader, isLoading: isLoading, headers: headers);
          });
    }

  }
}

void logshowLog(dynamic logshowLog) {
  if (kDebugMode) {
    // ignore: avoid_showLog
    print('${logshowLog ?? ""}');
  }
}


int serviceCallCount = 0;

showErrorMessage({required String message, Function? callBack}) {
  serviceCallCount = 0;
  // serviceCallCount++;
  hideProgressDialog();
  apiAlertDialog(
      buttonTitle: serviceCallCount < 3 ? tryAgain : "Restart App",
      message: message,
      buttonCallBack: () {
        if (callBack != null) {
          callBack();
        } else {
          get_x.Get.back(); // For redirecting to back screen
        }
      });
}

void showProgressDialog() {
  if ((get_x.Get.isDialogOpen ?? false) || get_x.Get.isSnackbarOpen) {
    return;
  }
  get_x.Get.dialog(
      WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Container(
              height: 75,
              width: 75,
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle
                  // borderRadius: BorderRadius.circular(15),
                  ),
              child: const CupertinoActivityIndicator(radius: 14, color: AppColors.buttonColor),
            ),
          ),
        ),
      ),
      barrierDismissible: false);
}

void hideProgressDialog({bool isLoading = true, bool isProgressShow = true, bool isHideLoader = true}) {
  if ((isProgressShow || isHideLoader) && (get_x.Get.isDialogOpen ?? true)) {
    // getX.Get.back();
    get_x.Get.back();
  }
}

dioErrorCall({required DioError dioError, required Function onCallBack}) {
  switch (dioError.type) {
    case DioErrorType.cancel:
    case DioErrorType.receiveTimeout:
      onCallBack(connectionTimeOutMessage, true);
      break;
    case DioErrorType.sendTimeout:
    default:
      onCallBack(dioError.message, true);
      break;
  }
}

Future<bool> checkInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}



apiAlertDialog({required String message, String? buttonTitle, Function? buttonCallBack, bool isShowGoBack = true}) {
  if (get_x.Get.isDialogOpen ?? false) {
    get_x.Get.back();
  }
  if (!(get_x.Get.isDialogOpen ?? false)) {
    get_x.Get.dialog(
      WillPopScope(
        onWillPop: () {
          return isShowGoBack ? Future.value(true) : Future.value(false);
        },
        child: CupertinoAlertDialog(
          title:  "Demo App".buildText(),
          content: Column(
            children: [
              message.buildText(),
              const SizedBox(height: 10),
            ],
          ),
          actions: isShowGoBack
              ? [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: (buttonTitle ?? 'Try again').buildText(),
                    onPressed: () {
                      if (buttonCallBack != null) {
                        buttonCallBack();
                      } else {
                        get_x.Get.back();
                      }
                    },
                  ),
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child:  "Go Back".buildText(),
                    onPressed: () {
                      get_x.Get.back();
                      // getX.Get.back();
                    },
                  )
                ]
              : [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: ( buttonTitle ?? 'Try again').buildText(),
                    onPressed: () {
                      if (buttonCallBack != null) {
                        buttonCallBack();
                      } else {
                        get_x.Get.back();
                      }
                    },
                  ),
                ],
        ),
      ),
      barrierDismissible: false,
      transitionCurve: Curves.easeInCubic,
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}

showSuccessMessage({String? message, bool show = true}) {
  if (show) {
    return ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(message!)));
  }
}

// import 'dart:convert';
// import 'dart:io';
//
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart' as getX;
// import 'package:get_storage/get_storage.dart';
// import 'package:lt_stock/View/LoginFlow/splash_view.dart';
//
// import '../Utility/common_function.dart';
// import '../Utility/string_utility.dart';
//
// const String baseUri = "https://stagingrentech.rentechdigital.com:3001/";
//
// const String somethingWrong = "Something went wrong!";
// const String responseMessage = "No response data found!";
// const String interNetMessage = "please check your internet connection and try again latter.";
// const String connectionTimeOutMessage = "Ops.. Server not working or might be in maintenance. Please Try Again Later";
// const String authenticationMessage = "The session has been expired. Please log in again.";
// const String tryAgain = "Try again";
//
// int serviceCallCount = 0;
// final storage = GetStorage();
//
// ///Status Code with message type array or string
// // 501 : sql related err
// // 401: validation array
// // 201 : string error
// // 400 : string error
// // 200: response, string/null
// // 422: array
// class Api {
//   getX.RxBool isLoading = false.obs;
//
//   call({
//     required String url,
//     Map<String, dynamic>? params,
//     required Function success,
//     Function? error,
//     ErrorMessageType errorMessageType = ErrorMessageType.snackBarOnlyError,
//     MethodType methodType = MethodType.post,
//     bool? isHideLoader = true,
//     bool isProgressShow = true,
//     FormData? formValues,
//   }) async {
//     if (await checkInternet()) {
//       if (isProgressShow) {
//         showProgressDialog(isLoading: isProgressShow);
//       }
//       /*if (formValues != null) {
//         Map<String, dynamic> tempMap = <String, dynamic>{};
//         for (var element in formValues.fields) {
//           tempMap[element.key] = element.value;
//         }
//         FormData reGenerateFormData = FormData.fromMap(tempMap);
//         for (var element in formValues.files) {
//           reGenerateFormData.files.add(MapEntry(element.key, element.value));
//         }
//         formValues = reGenerateFormData;
//       }*/
//
//       Map<String, dynamic> headerParameters;
//       headerParameters = {
//         "token": storage.read("loginToken") ?? "",
//         "timeZoneOffset": DateTime.now().timeZoneOffset,
//         "deviceType": Platform.isAndroid
//             ? "1"
//             : Platform.isIOS
//                 ? "2"
//                 : "3",
//       };
//       String mainUrl = url;
//
//       try {
//         Response response;
//         if (methodType == MethodType.get) {
//           response = await Dio().get(mainUrl,
//               queryParameters: params,
//               options: Options(
//                 headers: headerParameters,
//                 responseType: ResponseType.plain,
//               ));
//         } else if (methodType == MethodType.put) {
//           response = await Dio().put(mainUrl,
//               data: params,
//               options: Options(
//                 headers: headerParameters,
//                 responseType: ResponseType.plain,
//               ));
//         } else {
//           response = await Dio().post(mainUrl,
//               data: formValues ?? params,
//               options: Options(
//                 headers: headerParameters,
//                 responseType: ResponseType.plain,
//               ));
//         }
//         if (handleResponse(response)) {
//           if (kDebugMode) {
//             showLog('LOGIN TOKEN ${storage.read("loginToken") ?? ""}');
//             showLog(url);
//             showLog(params);
//             showLog(response.data);
//             showLog(response);
//           }
//
//           ///postman response Code guj
//           Map<String, dynamic>? responseData;
//           responseData = jsonDecode(response.data);
//           if (isHideLoader!) {
//             hideProgressDialog();
//           }
//           if (responseData?["success"] ?? false) {
//             //#region alert
//             if (errorMessageType == ErrorMessageType.snackBarOnlySuccess || errorMessageType == ErrorMessageType.snackBarOnResponse) {
//               getX.Get.snackbar("Error", responseData?["message"]);
//             } else if (errorMessageType == ErrorMessageType.dialogOnlySuccess || errorMessageType == ErrorMessageType.dialogOnResponse) {
//               await apiAlertDialog(message: responseData?["message"], buttonTitle: "Okay");
//             }
//             //#endregion alert
//             if ((responseData?.containsKey("data") ?? false) &&
//                 (responseData?["data"].containsKey("token") ?? false) &&
//                 (responseData?["data"]["token"].toString().isNotEmpty ?? false)) {
//               storage.write("loginToken", responseData?["data"]["token"]);
//             }
//             success(responseData);
//           } else {
//             //region 401 = Session Expired  Manage Authentication/Session Expire
//             if (response.statusCode == 401 || response.statusCode == 403) {
//               unauthorizedDialog(responseData?["message"]);
//             } else if (error != null) {
//               //#region alert
//               if (errorMessageType == ErrorMessageType.snackBarOnlyError || errorMessageType == ErrorMessageType.snackBarOnResponse) {
//                 getX.Get.snackbar("Error", responseData?["message"]);
//               } else if (errorMessageType == ErrorMessageType.dialogOnlyError || errorMessageType == ErrorMessageType.dialogOnResponse) {
//                 await apiAlertDialog(message: responseData?["message"], buttonTitle: "Okay");
//               }
//               //#endregion alert
//               error(responseData);
//             }
//             //endregion
//           }
//           isLoading.value = false;
//         } else {
//           if (isHideLoader!) {
//             hideProgressDialog();
//           }
//           showErrorMessage(
//               message: responseMessage,
//               isRecall: true,
//               callBack: () {
//                 getX.Get.back();
//                 call(
//                     params: params,
//                     url: url,
//                     success: success,
//                     error: error,
//                     isProgressShow: isProgressShow,
//                     methodType: methodType,
//                     formValues: formValues,
//                     isHideLoader: isHideLoader);
//               });
//           if (error != null) {
//             error(response.toString());
//           }
//           isLoading.value = false;
//         }
//         isLoading.value = false;
//       } on DioError catch (dioError) {
//         //#region dioError
//         dioErrorCall(
//             dioError: dioError,
//             onCallBack: (String message, bool isRecallError) {
//               showErrorMessage(
//                   message: message,
//                   isRecall: isRecallError,
//                   callBack: () {
//                     if (serviceCallCount < 3) {
//                       serviceCallCount++;
//
//                       if (isRecallError) {
//                         getX.Get.back();
//                         call(
//                           params: params,
//                           url: url,
//                           success: success,
//                           error: error,
//                           isProgressShow: isProgressShow,
//                           methodType: methodType,
//                           formValues: formValues,
//                           isHideLoader: isHideLoader,
//                         );
//                       } else {
//                         getX.Get.back(); // For redirecting to back screen
//                       }
//                     } else {
//                       getX.Get.back(); // For redirecting to back screen
//                       // GeneralController.to.selectedTab.value = 0;
//                       // getX.Get.offAll(() => DashboardTab());
//                     }
//                   });
//             });
//         isLoading.value = false;
//         //#endregion dioError
//       } catch (e) {
//         //#region catch
//         if (kDebugMode) {
//           showLog(e);
//         }
//         hideProgressDialog();
//         showErrorMessage(
//             message: e.toString(),
//             isRecall: true,
//             callBack: () {
//               getX.Get.back();
//               call(
//                   params: params,
//                   url: url,
//                   success: success,
//                   error: error,
//                   isProgressShow: isProgressShow,
//                   methodType: methodType,
//                   formValues: formValues,
//                   isHideLoader: isHideLoader);
//             });
//         isLoading.value = false;
//         //#endregion catch
//       }
//     } else {
//       //#region No Internet
//       showErrorMessage(
//           message: interNetMessage,
//           isRecall: true,
//           callBack: () {
//             getX.Get.back();
//             call(
//                 params: params,
//                 url: url,
//                 success: success,
//                 error: error,
//                 isProgressShow: isProgressShow,
//                 methodType: methodType,
//                 formValues: formValues,
//                 isHideLoader: isHideLoader);
//           });
//       //#endregion No Internet
//     }
//   }
// }
//
// showErrorMessage({required String message, required bool isRecall, required Function callBack}) {
//   serviceCallCount = 0;
//   // serviceCallCount++;
//   hideProgressDialog();
//   apiAlertDialog(
//       buttonTitle: serviceCallCount < 3 ? tryAgain : "Restart App",
//       message: message,
//       buttonCallBack: () {
//         callBack();
//       });
// }
//
// void showProgressDialog({bool isLoading = true}) {
//   isLoading = true;
//   getX.Get.dialog(
//       WillPopScope(
//         onWillPop: () => Future.value(false),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             Center(child: CircularProgressIndicator()),
//           ],
//         ),
//       ),
//       barrierColor: Colors.black12,
//       barrierDismissible: false);
// }
//
// void hideProgressDialog({bool isLoading = true, bool isProgressShow = true, bool isHideLoader = true}) {
//   isLoading = false;
//   if ((isProgressShow || isHideLoader) && getX.Get.isDialogOpen!) {
//     getX.Get.back();
//   }
// }
//
// dioErrorCall({required DioError dioError, required Function onCallBack}) {
//   switch (dioError.type) {
//     case DioErrorType.other:
//     case DioErrorType.connectTimeout:
//       // onCallBack(connectionTimeOutMessage, false);
//       onCallBack(dioError.message, true);
//       break;
//     case DioErrorType.response:
//     case DioErrorType.cancel:
//     case DioErrorType.receiveTimeout:
//     case DioErrorType.sendTimeout:
//     default:
//       onCallBack(dioError.message, true);
//       break;
//   }
// }
//
// Future<bool> checkInternet() async {
//   var connectivityResult = await (Connectivity().checkConnectivity());
//   if (connectivityResult == ConnectivityResult.mobile) {
//     return true;
//   } else if (connectivityResult == ConnectivityResult.wifi) {
//     return true;
//   }
//   return false;
// }
//
// unauthorizedDialog(message) async {
//   if (!getX.Get.isDialogOpen!) {
//     getX.Get.dialog(
//       WillPopScope(
//         onWillPop: () {
//           return Future.value(false);
//         },
//         child: CupertinoAlertDialog(
//           title: const formattedText(appName),
//           content: formattedText(message ?? authenticationMessage),
//           actions: [
//             CupertinoDialogAction(
//               isDefaultAction: true,
//               child: const formattedText("Okay"),
//               onPressed: () {
//                 //restart the application
//                 storage.erase();
//                 getX.Get.offAll(() => const SplashView());
//               },
//             ),
//           ],
//         ),
//       ),
//       barrierDismissible: false,
//       transitionCurve: Curves.easeInCubic,
//       transitionDuration: const Duration(milliseconds: 400),
//     );
//   }
// }
//
// bool handleResponse(Response response) {
//   try {
//     if (isNotEmptyString(response.toString())) {
//       return true;
//     } else {
//       return false;
//     }
//   } catch (e) {
//     return false;
//   }
// }
//
// apiAlertDialog({required String message, String? buttonTitle, Function? buttonCallBack, bool isShowGoBack = true}) async {
//   if (!getX.Get.isDialogOpen!) {
//     await getX.Get.dialog(
//       WillPopScope(
//         onWillPop: () {
//           return isShowGoBack ? Future.value(true) : Future.value(false);
//         },
//         child: CupertinoAlertDialog(
//           title: const formattedText(appName),
//           content: formattedText(message),
//           actions: isShowGoBack
//               ? [
//                   CupertinoDialogAction(
//                     isDefaultAction: true,
//                     child: formattedText(isNotEmptyString(buttonTitle) ? buttonTitle! : "Try again"),
//                     onPressed: () {
//                       if (buttonCallBack != null) {
//                         buttonCallBack();
//                       } else {
//                         getX.Get.back();
//                       }
//                     },
//                   ),
//                   CupertinoDialogAction(
//                     isDefaultAction: true,
//                     child: const formattedText("Go Back"),
//                     onPressed: () {
//                       getX.Get.back();
//                       getX.Get.back();
//                     },
//                   )
//                 ]
//               : [
//                   CupertinoDialogAction(
//                     isDefaultAction: true,
//                     child: formattedText(isNotEmptyString(buttonTitle) ? buttonTitle! : "Try again"),
//                     onPressed: () {
//                       if (buttonCallBack != null) {
//                         buttonCallBack();
//                       } else {
//                         getX.Get.back();
//                       }
//                     },
//                   ),
//                 ],
//         ),
//       ),
//       barrierDismissible: false,
//       transitionCurve: Curves.easeInCubic,
//       transitionDuration: const Duration(milliseconds: 400),
//     );
//   }
// }
//
// enum MethodType { get, post, put }
//
// enum ErrorMessageType { snackBarOnlyError, snackBarOnlySuccess, snackBarOnResponse, dialogOnlyError, dialogOnlySuccess, dialogOnResponse, none }
