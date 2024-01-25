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

void showDeleteDialog(context, {
  String title, 
  String content, 
  bool showCancel = true, 
  String cancelText = '取消', 
  Color cancelColor = Colors.red,
  String confirmText = '确定',
  Color confirmColor = Colors.red,
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
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                title != null ? Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, decoration: TextDecoration.none, color: Colors.black)),
                ) : Container(),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(content, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, decoration: TextDecoration.none, color: Color(0xFF848484))),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 10, right: 20, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      if (showCancel == true) Expanded(
                        flex: 1,
                        child: FlatButton(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: cancelColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(100)
                          ),
                          onPressed: () {
                            // 关闭 Dialog
                            Navigator.pop(_);
                          },
                          child: Text(cancelText, style: TextStyle(color: cancelColor), overflow: TextOverflow.ellipsis,  maxLines: 1,)
                        ),
                      ),
                      if (showCancel == true) Gaps.hGap12,
                      // showCancel == false ? Container() : Gaps.hGap12,
                      Expanded(
                        flex: 1,
                        child: FlatButton(
                          color: confirmColor,
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            success();
                          },
                          child: Text(confirmText, style: TextStyle(color: Colors.white))
                        ),
                      )
                    ],
                  )
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}