
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seller/style/resources.dart';

class InputHaveChild extends StatelessWidget {

  const InputHaveChild({
    Key key,
    this.controller,
    @required this.title,
    this.keyboardType: TextInputType.text,
    this.hintText: "",
    this.focusNode,
    this.maxLength: 1,
    this.enabled: true,
    this.child,
  }): super(key: key);

  final TextEditingController controller;
  final String title;
  final String hintText;
  final int maxLength;
  final bool enabled;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      margin:  const EdgeInsets.only(left: 16.0),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: Divider.createBorderSide(context, color: Colours.line, width: 0.6),
          )
      ),
      child: Row(
        children: <Widget>[
          // Padding(
          //   padding: const EdgeInsets.only(right: 16.0),
          //   child: Text(
          //     title,
          //     style: TextStyles.textDark14,
          //   ),
          // ),
          Container(
            padding: const EdgeInsets.only(right: 16.0),
            constraints: BoxConstraints(
              minWidth: 75
            ),
            child: Text(
              title,
              style: TextStyles.textDark14,
            ),
          ),
          Text('￥', style: TextStyle(fontSize: 12)),
          Expanded(
            flex: 1,
            child: TextField(
              focusNode: focusNode,
              keyboardType: keyboardType,
              inputFormatters: _getInputFormatters(),
              controller: controller,
              style: TextStyles.textDark14,
              enabled: enabled,
              // maxLines: 3,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none, //去掉下划线
                hintStyle: TextStyles.textGrayC14,
                // hintMaxLines: maxLength
              )
            ),
          ),
          child,
          Gaps.hGap16
        ],
      ),
    );
  }

  _getInputFormatters(){
    if (keyboardType == TextInputType.numberWithOptions(decimal: true)){
      // return [UsNumberTextInputFormatter()];
    }
    if (keyboardType == TextInputType.number || keyboardType == TextInputType.phone){
      return [WhitelistingTextInputFormatter.digitsOnly];
    }
    return null;
  }
}
