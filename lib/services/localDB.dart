import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:looksfreak/utils/user.dart';

class LocalDbResponse {
  final String message;
  final ResponseCode code;
  final dynamic data;
  LocalDbResponse({this.code, this.message, this.data});
}

enum ResponseCode { success, failed }

class UserDatabase {
  static final box = GetStorage();

  static Future<LocalDbResponse> setUser(CustomUser user) async {
    await box.write("user", jsonEncode(user.toJson()));
    return LocalDbResponse(code: ResponseCode.success);
  }

  static bool checkUser() {
    return box.hasData("user");
  }

  static Future<LocalDbResponse> getUser() async {
    final user = CustomUser.fromJson(jsonDecode(box.read("user")));
    return LocalDbResponse(code: ResponseCode.success, data: user);
  }

  static clear() async {
    await box.erase();
  }
}
