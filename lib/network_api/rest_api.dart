import 'package:audioroom/helper/constants.dart';
import 'package:audioroom/helper/dialogues.dart';
import 'package:audioroom/helper/validate.dart';
import 'package:audioroom/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class ApisInterface {
  void onSuccess(String url, var response);

  void onError(String url, int responseCode, String errorMessage, var response);
}

enum ApisType { post, get }

class Apis {
  ApisInterface _apisInterface;
  bool _isPrintParam = true;

  Apis(this._apisInterface);

  Future<void> onApis(String url, ApisType apisType,
      {var headers, var body}) async {
    bool isAvailable = await checkInternetConnect();
    if (isAvailable) {
      showApiLoader();
      try {
        showRequestData(url, "", body.toString());
        switch (apisType) {
          case ApisType.post:
            http
                .post(Uri.parse(url), headers: headers, body: body)
                .then((responseBody) {
              showResponseData(responseBody);
              Navigator.pop(navigatorKey.currentContext);
              _apisInterface.onSuccess(url, responseBody);
            }).catchError((onError) {
              Navigator.pop(navigatorKey.currentContext);
              _apisInterface.onError(
                  url, onError.hashCode, onError.toString(), "");
            });
            break;
          case ApisType.get:
            http.get(Uri.parse(url), headers: headers).then((responseBody) {
              showResponseData(responseBody);
              Navigator.pop(navigatorKey.currentContext);
              _apisInterface.onSuccess(url, responseBody);
            }).catchError((onError) {
              Navigator.pop(navigatorKey.currentContext);
              _apisInterface.onError(
                  url, onError.hashCode, onError.toString(), "");
            });
            break;
          default:
            break;
        }
      } catch (exception) {
        Navigator.pop(navigatorKey.currentContext);
        _apisInterface.onError(url, -1, AppConstants.str_something, "");
      }
    } else {
      _apisInterface.onError(url, -2, AppConstants.str_no_network, "");
    }
  }

  void showRequestData(String url, String header, String str) {
    if (_isPrintParam) {
      print("Request url: ${url.toString()}");
      print("Request header: ${header.toString()}");
      print("Request data: ${str.toString()}");
    }
  }

  void showResponseData(var responseBody) {
    if (_isPrintParam) {
      print("Response status: ${responseBody.statusCode}");
      print("Response body length: ${responseBody.contentLength}");
      print("Response headers: ${responseBody.headers}");
      print("Response request: ${responseBody.request}");
      print("Response body: ${responseBody.body}");
    }
  }
}
