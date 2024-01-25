import 'dart:convert' as convert;
import 'package:dio/dio.dart';
import 'package:seller/utils/local_storage.dart';

class TokenInterceptors extends InterceptorsWrapper {
  String _token;
  static const TOKEN_KEY = "token";
  @override
  onRequest(RequestOptions options) async {
    // print('>>>>>>>>>>>>onRequest开始');
    if (_token == null) {
      var authorizationCode = await getAuthorization();
      if (authorizationCode != null) {
        _token = authorizationCode;
      } 
    }
    options.headers["Authorization"] = _token;
    // print('>>>>>>>>>>>>onRequest结束');
    // print(options.headers["Authorization"]);
    return options;
  }

  @override
  onResponse(Response response) async {
    try {
      var responseJson = response.data;
      if (response.statusCode == 201 && responseJson["token"] != null) {
        _token = 'token ' + responseJson["token"];
        await LocalStorage.save(TOKEN_KEY, _token);
      }
    } catch (e) {
      print(e);
    }
    return response;
  }
  ///清除授权
  clearAuthorization() {
    this._token = null;
    LocalStorage.remove(TOKEN_KEY);
  }
  getAuthorization() async {
    String token = 'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IkQ1QkFEQzlCQzdEOUYyRjg1MjA1MDZBQTBCMTgzQkIzRkZCOUMwMTUiLCJ0eXAiOiJKV1QiLCJ4NXQiOiIxYnJjbThmWjh2aFNCUWFxQ3hnN3NfLTV3QlUifQ.eyJuYmYiOjE1Njk0ODgwOTgsImV4cCI6MTU3MDc4NDA5OCwiaXNzIjoiaHR0cDovLzEyNy4wLjAuMTo0NzMzOCIsImF1ZCI6WyJodHRwOi8vMTI3LjAuMC4xOjQ3MzM4L3Jlc291cmNlcyIsImFjY291bnQiLCJjYXRlZ29yeV9icmFuZCIsImRpc2NvdmVyeSIsImZ1bmQiLCJpdGVtIiwibG9naXN0aWNzIiwicGF5bWVudCIsInNldHRpbmciLCJzaG9wIiwidHJhZGVfcmVmdW5kIiwidXNlciJdLCJjbGllbnRfaWQiOiJhcHAiLCJzdWIiOiIxMDU4IiwiYXV0aF90aW1lIjoxNTY5NDg4MDk4LCJpZHAiOiJsb2NhbCIsInJvbGUiOiJidXllciIsImlkIjoiMTA1OCIsIm5hbWUiOiIxODQwNDkwNTg1MiIsIm5pY2siOiIxODQwNDkwNTg1MiIsInNob3BfaWQiOiI0MyIsImZvbGxvd191c2VyX2lkIjoiMTI4OCIsInNjb3BlIjpbIm9wZW5pZCIsInByb2ZpbGUiLCJhY2NvdW50IiwiY2F0ZWdvcnlfYnJhbmQiLCJkaXNjb3ZlcnkiLCJmdW5kIiwiaXRlbSIsImxvZ2lzdGljcyIsInBheW1lbnQiLCJzZXR0aW5nIiwic2hvcCIsInRyYWRlX3JlZnVuZCIsInVzZXIiLCJvZmZsaW5lX2FjY2VzcyJdLCJhbXIiOlsid2VjaGF0Il19.hi_xDR4WJ7mLq01CNCKFiP9C6_9VBiE-CF0FBh5bVTKgDWWoZjb9-X82o9PetkPlLjKqQqksguazqBqVBKKf7Z_eEE0XQtsll0mp1Qxu-ybeoc6fOjddqF4ds6A6MtoKVht7-MNsJrtEwQSVe--nEoAANAvLkGytrahXLzWvvIDoq4uGanAf7l1yiNkVdOLZUpu8PI7F6NCxY95iMCJxT1F3VxnJGjr_-Lb-8V4EIuPvq2o6SkAGbvuXlqajNOOVWlnV59iQ4Z3VYTExEFIVH74JhVFC8Fk93R_yTbOcAE4Ml2F6DliHH3Hwkay8z3f_phKNRXllag2gBu7z0lQENw';
    String token1 = await LocalStorage.get('token');
    // print('getAuthorization');
    // print(token1);
    if (token1 != null) {
      Map<String, dynamic> token2 = convert.jsonDecode(token1);
      return token2['token_type'] + ' ' + token2['access_token'];
    } else {
      return token;
    }
  }
}