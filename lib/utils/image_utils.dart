import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:common_utils/common_utils.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:seller/model/image.dart';

class ImageUtils {
  static ImageProvider getAssetImage(String name, {String format: 'png'}) {
    return AssetImage(getImgPath(name, format: format));
  }

  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }


  static uploadImage(File image) async {
    UploadImage uploadData;
    String path = image.path;
    var name = path.substring(path.lastIndexOf('/') + 1, path.length);
    FormData formData = new FormData.fromMap({
      "file": await MultipartFile.fromFile(path, filename: name)
      // "file": await MultipartFile.fromFile("./text.txt",filename: "upload.txt"),
    });
    Dio dio = new Dio();
    var respone = await dio.post<String>("https://ibb.api.aqsea.com/router/rest?method=aqsea.upload.page.image.stream&version=v1&app_type=other", data: formData);
    var response = json.decode(respone.toString());
    uploadData = UploadImage.fromJson(response);
    if (uploadData.data.isSuccess == true) {
      return uploadData.data.picUrl;
    } else {
      return null;
    }
  }

}