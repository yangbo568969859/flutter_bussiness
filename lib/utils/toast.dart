import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyToast {
  static show(String msg, {gravity = 'center'}) {
    var position = ToastGravity.CENTER;
    if (gravity == 'center') {
      position = ToastGravity.CENTER;
    } else if (gravity == 'bottom') {
      position = ToastGravity.BOTTOM;
    } else if (gravity == 'top') {
      position = ToastGravity.TOP;
    }
    return Fluttertoast.showToast(
      msg: msg,
      gravity: position,
      // backgroundColor: Colors.black45,
      // textColor: Colors.white,
      fontSize: 12.0
    );
  }
}

void showShortToast(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM
    );
}