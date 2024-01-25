import 'dart:async';
import 'dart:convert' as convert;

// import 'package:shared_preferences/shared_preferences.dart';
import 'package:seller/utils/local_storage.dart';

class DataUtils {
  static Future<bool> isLogin() async {
    // SharedPreferences sp = await SharedPreferences.getInstance();
    // print(sp);
    String token = await LocalStorage.get('token');
    DateTime startTime;
    if (token == null) {
      return false;
    } else {
      Map<String, dynamic> token2 = convert.jsonDecode(token);
      print(token2);
      startTime = DateTime.now();
      print(startTime.microsecondsSinceEpoch);
      // if (startTime <= token2['expiresTime']) {
      //   return false;
      // }
      return true;
    }
  }
}