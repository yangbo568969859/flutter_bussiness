import 'package:flutter/material.dart';
import 'package:seller/style/colors.dart';
// import 'package:smooth_star_rating/smooth_star_rating.dart';

Color hexToColor(String s) {
  if (s == null || s.length != 7 || int.tryParse(s.substring(1, 7), radix: 16) == null) {
    s = '#999999';
  }
  return new Color(int.parse(s.substring(1, 7), radix: 16) + 0xFF000000);
}

class BaseStyle {
  static TextStyle textStyleWhite(double fontSize, [bool isBold = false]) {
    return TextStyle(fontSize: fontSize, color: Colours.color_ff, fontWeight: isBold ? FontWeight.bold: FontWeight.normal);
  }

  // 带小圆角图片
  static Widget clipRRectImg(url, double width, double height, double border) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(border),
      child: Image.network(
        url,
        width: width,
        height: height,
        fit: BoxFit.fill
      ),
    );
  }

  // 圆角图片
  static clipOvalImg(url, double size) {
    return ClipOval(
      child: Image.network(
        url,
        width: size,
        height: size,
        fit: BoxFit.fill
      ),
    );
  }
  // 限制行数
  static Widget limitLineText(double width, String text, TextStyle textStyle, int maxLines) {
    return Container(
      width: width,
      child: Text(
        text,
        style: textStyle,
        overflow: TextOverflow.ellipsis,
        maxLines: maxLines,
      ),
    );
  }

  static Widget getIconFontButton(iconFontData, _onPressed) {
    return IconButton(
      icon: Icon(
        IconData(iconFontData, fontFamily: 'iconfont'),
        size: 28,
      ),
      // color: Color(0xffffffff),
      onPressed: _onPressed,
    );
  }
}

// 渐变文字
class GradientText extends StatelessWidget {
 GradientText(this.data, {@required this.gradient, this.style, this.textAlign = TextAlign.left});

 final String data;
 final Gradient gradient;
 final TextStyle style;
 final TextAlign textAlign;

 @override
 Widget build(BuildContext context) {
   return ShaderMask(
    shaderCallback: (bounds) {
      return gradient.createShader(Offset.zero & bounds.size);
    },
    child: Text(
      data,
      textAlign: textAlign,
      style: (style == null)
      ? TextStyle(color: Colors.white)
      : style.copyWith(color: Colors.white),
    ),
   );
 }
}