

import 'package:flutter/material.dart';
import 'package:seller/style/resources.dart';

class BaseDialog extends StatelessWidget{

  const BaseDialog({
    Key key,
    this.title,
    this.onPressed,
    this.hiddenTitle : false,
    @required this.child
  }) : super(key : key);

  final String title;
  final Function onPressed;
  final Widget child;
  final bool hiddenTitle;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(//创建透明层
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      // 键盘弹出收起动画过渡
      body: AnimatedContainer(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeInCubic,
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            width: width - 80,
            padding: const EdgeInsets.only(top: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Offstage(
                  offstage: hiddenTitle,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      hiddenTitle ? "" : title,
                      style: TextStyles.textBoldDark16,
                    ),
                  ),
                ),
                Flexible(child: child),
                Gaps.vGap8,
                Gaps.line,
                Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 48.0,
                        child: FlatButton(
                          child: const Text(
                            "取消",
                            style: TextStyle(
                              fontSize: Dimens.font_sp16
                            ),
                          ),
                          textColor: Colours.text_gray,
                          onPressed: (){
                            FocusScope.of(context).unfocus();
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 48.0,
                      width: 0.6,
                      child: const DecoratedBox(decoration: BoxDecoration(color: Colours.line)),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 48.0,
                        child: FlatButton(
                          child: const Text(
                            "确定",
                            style: TextStyle(
                                fontSize: Dimens.font_sp16
                            ),
                          ),
                          textColor: Colours.app_main,
                          onPressed: (){
                            onPressed();
                          },
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
        ),
      ),
    );
  }
}