
import 'package:flutter/material.dart';
import 'package:seller/style/resources.dart';
import 'package:seller/utils/route_util.dart';
import 'package:seller/utils/dialog_utils.dart';
import 'package:seller/widgets/click_item.dart';

import 'package:seller/views/settingpage/input_text_page.dart';
import 'package:seller/widgets/dialogs/transparency_dialog.dart';
import 'package:seller/views/store/wechat_card.dart';


/// design/8设置/index.html
class StoreManage extends StatefulWidget {
  @override
  _StoreManageState createState() => _StoreManageState();
}

class _StoreManageState extends State<StoreManage> {
  String _userImage = 'https://img.aqsea.com/wechat/default-head.png';
  String _shopIntroduction = '';
  String _shopWechatNick = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        title: Text('店铺管理', style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          InkWell(
            onTap: () {
            },
            child: Container(
              width: 64,
              alignment: Alignment.center,
              child: Text('查看店铺', style: TextStyle(color: Colors.black, fontSize: 12)),
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Listener(
            onPointerDown: (d) {

            },
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      RouteUtil.routeToSettingPage(context);
                    },
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 15.0, 15.0, 15.0),
                        constraints: BoxConstraints(
                          maxHeight: double.infinity,
                          minHeight: 70.0
                        ),
                        width: double.infinity,
                        child: Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network('https://img.aqsea.com/wl/other/20191028162804536-274528800.png', width: 50,height: 50, fit: BoxFit.cover,)
                            ),
                            // const Spacer(),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0, left: 16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text('店铺名称', style: TextStyles.textBoldDark14),
                                        Gaps.hGap8,
                                        Image.asset('assets/images/shop/tryout.gif', height: 15,)
                                      ],
                                    ),
                                    Gaps.vGap4,
                                    Text('试用期有效期至2019.06.20', style: TextStyle(color: Color(0xFFEB5D44), fontSize: 11))
                                  ],
                                )
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 0.0),
                              child: Image.asset('assets/images/icon/icon_arrow_right.png', width: 16, height: 16,),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gaps.vGap8,
                  ClickItem(
                    label: '店铺认证',
                    value: '',
                    hintText: '未认证',
                    onPressed: () {
                    }
                  ),
                  ClickItem(
                    label: '极速回款',
                    value: '',
                    hintText: '未开通',
                    showLine: false,
                    onPressed: () {
                    }
                  ),
                  Gaps.vGap8,
                  ClickItem(
                    label: '店铺装修',
                    value: '经典样式1',
                    hintText: '未设置',
                    onPressed: () {
                      RouteUtil.routeToStoreDecoration(context);
                    }
                  ),
                  ClickItem(
                    label: '微信设置',
                    value: _shopWechatNick,
                    hintText: '未设置',
                    onPressed: () {
                      RouteUtil.pushResult(context, WechatCard(), (result) {
                        _shopWechatNick = result.toString();
                      });
                    }
                  ),
                  ClickItem(
                    label: '店铺公告',
                    value: _shopIntroduction,
                    hintText: '未设置',
                    showLine: false,
                    onPressed: () {
                      RouteUtil.pushResult(context, InputTextPage(
                        title: "修改店铺公告",
                        hintText: "店铺简介…",
                        content: _shopIntroduction,
                        maxLength: 200,
                      ), (result) {
                        setState(() {
                          _shopIntroduction = result.toString();
                        });
                      });
                    }
                  ),
                  Gaps.vGap8,
                  ClickItem(
                    label: '支付设置',
                    value: '',
                    onPressed: () {
                      showElasticDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return TransParencyDialog(
                            backgroundImage: 'https://img.aqsea.com/iBuyBuy/seller/ad/2019-10-30_140943.png',
                            onPressed: () {
                              print('object');
                            }
                          );
                        }
                      );
                    }
                  ),
                  ClickItem(
                    label: '交易设置',
                    value: '',
                    onPressed: () {
                    }
                  ),
                  ClickItem(
                    label: '物流设置',
                    value: '',
                    showLine: false,
                    onPressed: () {
                    }
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              height: 50,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        child: Text('店铺二维码'),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)
                      ),
                      color: Color(0xFF3233F3),
                      textColor: Colors.white,
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        child: Text('推广店铺'),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )
      // bottomNavigationBar: BottomAppBar(
      //   notchMargin: 0,
      //   child: Container(
      //     height: 45,
      //     child: Row(
      //       children: <Widget>[
      //         Expanded(
      //           flex: 1,
      //           child: MaterialButton(
      //             child: Text('店铺二维码'),
      //             onPressed: () {},
      //           ),
      //         ),
      //         Expanded(
      //           flex: 1,
      //           child: MaterialButton(
      //             child: Text('推广店铺'),
      //             onPressed: () {},
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
