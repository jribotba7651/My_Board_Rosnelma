// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:my_board/core/storage.dart';
import 'package:my_board/core/values/api_constant.dart';
import 'package:my_board/core/values/show.dart';

import '../imports.dart';

class APIService {
  //DANISH
  //______________________________________________________GET DATA WITH API
  getDataWithAPI({
    required String url,
    required BuildContext context,
  }) async {
    String token = await SharedPrefStorage.getString(key: "token");
    token = token.toString();
    try {
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      });
      print(response.body);
      if (response.statusCode == 200) {
        dynamic jsonDecodeData = jsonDecode(response.body);
        if (jsonDecodeData["success"] == true) {
          if (jsonDecodeData["message"] != null) {
            showErrorMessage(jsonDecodeData["message"], context, "success");
          }
          return jsonDecodeData;
        } else {
          showErrorMessage(jsonDecodeData["message"], context, "warning");
          return null;
        }
      } else {
        errorHandlor(response.statusCode);
      }
    } catch (error) {
      debugPrint("......................EXCEPTION: $error");
    }
  }

  //DANISH
  //______________________________________________________GET DATA WITH API
  getDataWithAPIWithoutContext({
    required String url,
  }) async {
    String token = await SharedPrefStorage.getString(key: "token") ?? "";
    token = token.toString();
    try {
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      });
      print(response.body);
      if (response.statusCode == 200) {
        dynamic jsonDecodeData = jsonDecode(response.body);
        if (jsonDecodeData["success"] == true) {
          print(jsonDecodeData["message"]);
          return jsonDecodeData;
        } else {
          print(jsonDecodeData["message"]);
          return null;
        }
      } else {
        errorHandlor(response.statusCode);
      }
    } catch (error) {
      debugPrint("......................EXCEPTION: $error");
    }
  }

   getDataWithAPIWithoutContextforFamily({
    required String url,
  }) async {
    String token = await SharedPrefStorage.getString(key: "token") ?? "";
    token = token.toString();
    try {
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      });
      print(response.body);
      if (response.statusCode == 200) {
        dynamic jsonDecodeData = jsonDecode(response.body);
           return jsonDecodeData;
      } else {
        errorHandlor(response.statusCode);
      }
    } catch (error) {
      debugPrint("......................EXCEPTION: $error");
    }
  }


  //DANISH
  //______________________________________________________POST DATA WITH API
  postDataWithAPI({
    required String url,
    required Map<String, dynamic> data,
    required BuildContext context,
    bool? isReturnJson = false,
  }) async {
    String? token = await SharedPrefStorage.getString(key: "token");
    token = token.toString();
    var body = jsonEncode(data);

    // ========== ENHANCED API DEBUGGING ==========
    print("🌐 API DEBUG: POST Request Starting");
    print("📍 URL: $url");
    print("🔑 TOKEN: ${token == 'null' || token == '' ? 'NO TOKEN' : 'TOKEN EXISTS (${token.length} chars)'}");
    print("📤 REQUEST HEADERS: {");
    print("    'Content-Type': 'application/json',");
    print("    'Authorization': 'Bearer $token'");
    print("}");
    print("📦 REQUEST BODY (JSON): $body");
    print("📦 REQUEST DATA (MAP): $data");
    print("==========================================");

    try {
      print("⏳ Sending HTTP POST request...");
      var response = await http.post(Uri.parse(url), body: body, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      print("📬 RESPONSE RECEIVED:");
      print("📊 STATUS CODE: ${response.statusCode}");
      print("📋 RESPONSE HEADERS: ${response.headers}");
      print("📄 RESPONSE BODY: ${response.body}");
      print("==========================================");

      dynamic jsonDecodeData = jsonDecode(response.body);

      print("🔍 PARSED JSON RESPONSE:");
      print("📊 Full Response: $jsonDecodeData");
      if (jsonDecodeData is Map) {
        jsonDecodeData.forEach((key, value) {
          print("   $key: $value");
        });
      }
      print("==========================================");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("✅ SUCCESS STATUS CODE (${response.statusCode})");

        // Check for token in response
        bool hasToken = jsonDecodeData["token"] != null &&
                       jsonDecodeData["token"].toString().isNotEmpty;
        print("🔑 TOKEN IN RESPONSE: ${hasToken ? 'YES' : 'NO'}");

        if (hasToken) {
          print("💾 Storing token and role...");
          if (jsonDecodeData["role"] != null) {
            await SharedPrefStorage.storeString(
                key: "role", value: jsonDecodeData["role"].toString());
            print("👤 ROLE STORED: ${jsonDecodeData["role"]}");
          }
          await SharedPrefStorage.storeToken(
              key: "token", value: jsonDecodeData["token"].toString());
          print("🔑 TOKEN STORED: ${jsonDecodeData["token"].toString().substring(0, 10)}...");
        }

        // Check success field
        bool isSuccess = jsonDecodeData["success"] == true;
        print("📈 SUCCESS FIELD: $isSuccess");

        if (isSuccess) {
          print("🎉 API CALL SUCCESSFUL - Showing success message");
          showErrorMessage(jsonDecodeData["message"], context, "success");
          return isReturnJson == true ? jsonDecodeData : true;
        } else {
          print("❌ API CALL FAILED - Success field is false");
          showErrorMessage(jsonDecodeData["message"], context, "warning");
          return isReturnJson == true ? jsonDecodeData : false;
        }
      } else {
        print("❌ ERROR STATUS CODE: ${response.statusCode}");
        print("📄 ERROR RESPONSE: ${response.body}");
        showErrorMessage(jsonDecodeData["message"] ?? "Unknown error", context, "warning");
        errorHandlor(response.statusCode);
        return false;
      }
    } catch (error) {
      print("💥 API EXCEPTION:");
      print("📍 URL: $url");
      print("❌ ERROR: $error");
      print("🔍 ERROR TYPE: ${error.runtimeType}");
      print("📊 STACK TRACE: ${StackTrace.current}");
      debugPrint("......................EXCEPTION In:$url  $error");
      return false;
    }
  }

  // Zeeshan
  postDataWithReturn({
    required String url,
    required Map<String, dynamic> data,
    required BuildContext context,
    bool? isReturnJson = false,
    bool? isShowSnackBar = true,
  }) async {
    print(data.toString());
    String? token = await SharedPrefStorage.getString(key: "token");
    token = token.toString();
    var body = jsonEncode(data);
    print("Tokennnn $token");
    try {
      var response = await http.post(Uri.parse(url), body: body, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      print("______________________");
      print(response.body.toString());
      print("______________________");
      dynamic jsonDecodeData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(jsonDecodeData["token"].toString().isNotEmpty &&
            jsonDecodeData["token"] != null);
        if (jsonDecodeData["token"].toString().isNotEmpty &&
            jsonDecodeData["token"] != null) {
          await SharedPrefStorage.storeToken(
              key: "token", value: jsonDecodeData["token"].toString());
        }
        if (jsonDecodeData["success"] == true) {
          isShowSnackBar == true
              ? showErrorMessage(
                  jsonDecodeData["message"].toString(), context, "success")
              : null;
          return jsonDecodeData;
        } else {
          isShowSnackBar == true
              ? showErrorMessage(jsonDecodeData["message"], context, "warning")
              : null;
          return jsonDecodeData;
        }
      } else {
        showErrorMessage(jsonDecodeData["message"], context, "warning");
        errorHandlor(response.statusCode);
      }
    } catch (error) {
      debugPrint("......................EXCEPTION In:$url  $error");
    }
  }

  ///ZEESHAN
  ///______________________________________________________POST DATA WITH API
  putDataWithAPI({
    required String url,
    required Map<String, dynamic> data,
    required BuildContext context,
    bool? isReturnJson = false,
  }) async {
    var body = jsonEncode(data);
    print(body);
    String? token = await SharedPrefStorage.getString(key: "token");
    token = token.toString();
    try {
      var response = await http.put(Uri.parse(url), body: body, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      print("______________________");
      print(response.body.toString());
      print("______________________");
      dynamic jsonDecodeData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // if (jsonDecodeData["token"].toString().isNotEmpty &&
        //     jsonDecodeData["token"] != null) {
        //   await SharedPrefStorage.storeString(
        //       key: "role", value: jsonDecodeData["role"].toString());
        //   await SharedPrefStorage.storeToken(
        //       key: "token", value: jsonDecodeData["token"].toString());
        // }
        if (jsonDecodeData["success"] == true) {
          // Show.showSnackBar("Message", "Success");

          showErrorMessage(jsonDecodeData["message"], context, "success");
          return isReturnJson == true ? jsonDecodeData : true;
        } else {
          showErrorMessage(jsonDecodeData["message"], context, "warning");
          return isReturnJson == true ? jsonDecodeData : false;
        }
      } else {
        showErrorMessage(jsonDecodeData["message"], context, "warning");
        errorHandlor(response.statusCode);
      }
    } catch (error) {
      debugPrint("......................EXCEPTION In:$url  $error");
    }
  }

  //DANISH
  //______________________________________________________DELETE DATA WITH API
  deleteDataWithAPI({
    required String url,
    required BuildContext context,
  }) async {
    String token = await SharedPrefStorage.getString(key: "token");
    token = token.toString();
    try {
      var response = await http.delete(Uri.parse(url), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      });
      dynamic jsonDecodeData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (jsonDecodeData["success"] == true) {
          showErrorMessage(jsonDecodeData["message"], context, "success");
          return true;
        } else {
          showErrorMessage(jsonDecodeData["message"], context, "warning");
          return false;
        }
      } else {
        showErrorMessage(jsonDecodeData["message"], context, "warning");
        errorHandlor(response.statusCode);
      }
    } catch (error) {
      debugPrint("......................EXCEPTION: $error");
    }
  }

  //DANISH
  //______________________________________________________API ERROR HANDLING
  errorHandlor(int code) {
    if (code == 404) {
      debugPrint("......................404 Not Found");
    } else if (code == 401) {
      // signOut();
      debugPrint("......................401 UnauthorizedPermalink");
    } else if (code == 403) {
      debugPrint("......................403 ForbiddenPermalink");
    } else if (code == 400) {
      debugPrint("......................400 Bad Request");
    } else if (code == 429) {
      debugPrint("......................429 Too Many Requests");
    } else if (code == 500) {
      debugPrint("......................500 Internal Server ErrorPermalink");
    } else if (code == 502) {
      debugPrint("......................502 Bad Gateway");
    } else if (code == 503) {
      debugPrint("......................503 Service Unavailable");
    } else if (code == 504) {
      debugPrint("......................504 Gateway Timed Out");
    }
  }

   uploadSingleFile(String filePath) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(EndPoint.fileUploader)); // your server url
    request.fields
        .addAll({'file': 'file'}); // any other fields required by your server
    request.files.add(await http.MultipartFile.fromPath('file', filePath));
    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        Map a = jsonDecode(await response.stream.bytesToString());
        print(a);
        print(a['imageUrl']);
        return a['imageUrl'];
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
        return null;
      }
    } catch (e) {
      print(e);
    }
  }
}

//DANISH
//______________________________________________________SHOW API ERROR MESSAGE

showErrorMessage(String message, BuildContext context, String type) {
  return showTopSnackBar(
      Overlay.of(context),
      type == "success"
          ? CustomSnackBar.success(
              message: message, backgroundColor: Colors.green)
          : CustomSnackBar.error(
              message: message, backgroundColor: Colors.red));
}
