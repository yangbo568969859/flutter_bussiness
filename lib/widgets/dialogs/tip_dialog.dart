import 'package:flutter/material.dart';
import 'package:seller/style/resources.dart';

/// 发起网络请求
/// [ title ] 提示的标题
/// [ content ] 提示的内容
/// [ showCancel ] 是否显示取消按钮
/// [ cancelText ] 取消按钮的文字，最多 4 个字符
/// [ cancelColor ] 取消按钮的文字颜色，必须是 16 进制格式的颜色字符串
/// [ confirmText ] 确认按钮的文字，最多 4 个字符
/// [ confirmColor ] 确认按钮的文字颜色，必须是 16 进制格式的颜色字符串
/// [ success ] 接口调用成功的回调函数
/// [ fail ] 接口调用失败的回调函数

void showTipDialog(context, {
  String title, 
  String content, 
  bool showCancel = true, 
  String cancelText = '取消', 
  Color cancelColor = const Color(0xFF000000),
  String confirmText = '确定',
  Color confirmColor = const Color(0xFF3233F3),
  VoidCallback success,
  VoidCallback fail,

}) {
  showDialog(
    // 传入 context
    context: context,
    // 构建 Dialog 的视图
    builder: (_) => Padding(
      padding: EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12.0))
            ),
            child: Column(
              children: <Widget>[
                Gaps.vGap16,
                title != null ? Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, decoration: TextDecoration.none, color: Colors.black)),
                ) : Container(),
                Padding(
                  padding: EdgeInsets.only(top: 14, bottom: 30),
                  child: Text(content, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, decoration: TextDecoration.none, color: Color(0xFF000000))),
                ),
                Gaps.line,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 48.0,
                        child: FlatButton(
                          child: Text(
                            cancelText,
                            style: TextStyle(
                              fontSize: Dimens.font_sp16,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          textColor: cancelColor,
                          onPressed: (){
                            Navigator.pop(_);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 48.0,
                      width: 0.6,
                      child:  DecoratedBox(decoration: BoxDecoration(color: Colours.line)),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 48.0,
                        child: FlatButton(
                          child: Text(
                            confirmText,
                            style: TextStyle(
                              fontSize: Dimens.font_sp16,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          textColor: confirmColor,
                          onPressed: (){
                            Navigator.pop(context);
                            success();
                          },
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}