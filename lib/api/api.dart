import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:seller/api/net_code.dart';
import 'package:seller/api/interceptors/token.dart';
// http请求
class HttpManager {
  static const CONTENT_TYPE_JSON = 'application/json';
  static const CONTENT_TYPE_FORM = 'application/x-www-form-urlencoded';

  Dio _dio = new Dio();

  final TokenInterceptors _tokenInterceptors = new TokenInterceptors();
  HttpManager() {
    print('初始化HttpManager');
    _dio.interceptors.add(_tokenInterceptors);
  }

  /// 发起网络请求
  /// [ url ] 请求url
  /// [ params ] 请求参数
  /// [ header ] 外加头
  /// [ option ] 请求方式
  netFetch(url, params, Map<String, dynamic> header, option, {noTip = false}) async {
    const bool inProduction = const bool.fromEnvironment("dart.vm.product");
    if (url != null) {
      if (inProduction == true) {
        url = 'https://ibb.api.aqsea.com/router/rest?method=aqsea.'+url+'&version=v1';
      } else {
        url = 'https://ibb.api.aqsea.com/router/rest?method=aqsea.'+url+'&version=v1';
      }
    }
    Map<String, dynamic> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }
    Options options;
    if (option != null) {
      options = new Options(method: '$option');
      options.headers = headers;
    } else {
      options = new Options(method: 'get', responseType: ResponseType.plain);
      options.headers = headers;
    }
    if (options.headers["Authorization"] == null) {
      print('options.headers["Authorization"] 不存在');
      final TokenInterceptors _tokenInterceptors = new TokenInterceptors();
      _dio.interceptors.add(_tokenInterceptors);
    }
    resultError(DioError e) {
      Response errorResponse;
      if (e.response != null && e.response.statusCode == 401) {
        if (e.response != null) {
          errorResponse = e.response;
        } else if (e.response.statusCode == 401) {
          print(e.response.statusCode);
          _dio.lock();
          // Dio dio = DioUtil().dio;
          // dio.lock();
        }
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT || e.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      }
      print(errorResponse.statusCode);
      // return new ResultData(Code.errorHandleFunction(errorResponse.statusCode, e.message, noTip), false, errorResponse.statusCode);
    }
    // print(options.method);
    // print(url);
    // print(params);

    Response response;
    try {
      if (options.method == 'get' || options.method == 'DELETE') {
        response = await _dio.request(url, queryParameters: params, options: options);
      } else {
        response = await _dio.request(url, data: params, options: options);
      }
    } on DioError catch(e) {
      return resultError(e);
    }
    if(response.data is DioError) {
      return resultError(response.data);
    }
    return response.data;
  }

  ///清除授权
  clearAuthorization() {
    _tokenInterceptors.clearAuthorization();
  }

  ///获取授权token
  getAuthorization() async {
    return _tokenInterceptors.getAuthorization();
  }
}

final HttpManager httpManager = new HttpManager();
