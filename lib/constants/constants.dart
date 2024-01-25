import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class Constants {

  static double suSetSp(double size) {
    double value = ScreenUtil.getInstance().setSp(size) * 1.95;
    print(value);
    if (Platform.isIOS) {
      if (ScreenUtil.screenWidthDp <= 414.0) {
        value = size / 1.25;
      } else if (ScreenUtil.screenWidthDp > 414.0 && ScreenUtil.screenWidthDp > 750.0) {
        value = size;
      }
    }
    return value;
  }
}