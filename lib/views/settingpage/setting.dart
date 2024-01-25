import 'dart:io';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:seller/utils/route_util.dart';
import 'package:seller/views/settingpage/input_text_page.dart';
import 'package:seller/widgets/click_item.dart';
import 'package:seller/style/resources.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  String _shopIntroduction = '';
  File _imageFile;
  String _userImage = 'https://img.aqsea.com/wechat/default-head.png';

  void _getImage() async {
    try{
      _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 800, imageQuality: 95);
      _upLoadImage(_imageFile);
    } catch(e) {

    }
  }
  /// 上传图片
  _upLoadImage(File image) async {
    // var imags = await ImageUtils.uploadImage(image);
    // setState(() {
    //  _userImage =  imags;
    // });
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    MyMaterial(
                      label: '头像',
                      value: _userImage,
                      type: 'avatar',
                      showLine: true,
                      onPressed: () {
                        _getImage();
                      },
                    ),
                    ClickItem(
                      label: '昵称',
                      value: _shopIntroduction,
                      onPressed: () {
                        RouteUtil.pushResult(context, InputTextPage(
                          title: "修改昵称",
                          hintText: "店铺简介…",
                          content: '',
                        ), (result) {
                          setState(() {
                            _shopIntroduction = result.toString();
                          });
                        });
                      }
                    ),
                    ClickItem(
                      label: '实名认证',
                      value: '',
                      onPressed: () {
                        // RouteUtil.routeToVerifiedPage(context, {});
                      }
                    ),
                    ClickItem(
                      label: '收货地址',
                      value: '',
                      onPressed: () {
                        // RouteUtil.routeToAddressPage(context, {});
                      }
                    ),
                    ClickItem(
                      label: '微信名片',
                      value: '',
                      onPressed: () {}
                    ),
                    SizedBox(height: 10),
                    ClickItem(
                      label: '账户安全',
                      value: '',
                      showLine: false,
                      onPressed: () {

                      }
                    ),
                    SizedBox(height: 10),
                    ClickItem(
                      label: '关于我们',
                      value: '',
                      onPressed: () {
                        // https://m.wandougongzhu.cn/user/rulesdown?act_id=422
                        // RouteUtil.pushWeb(context, url: 'https://m.wandougongzhu.cn/user/electricityrules', title: '关于我们');
                      }
                    ),
                    ClickItem(
                      label: '消息通知设置',
                      value: '',
                      onPressed: () {
                        RouteUtil.routeToMessageSettingPage(context);
                      }
                    ),
                    ClickItem(
                      label: '系统权限设置',
                      value: '',
                      onPressed: () {
                        PermissionHandler().openAppSettings();
                      }
                    ),
                    ClickItem(
                      label: '当前版本',
                      value: '1.4.0',
                      showLine: false,
                      onPressed: () {
                        _showUpdateDialog();
                      }
                    ),
                    SizedBox(height: 10),
                    Material(
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {
                          print('登出');
                          return showCupertinoDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text('登出'),
                              content: Text('确定登出？'),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('取消', style: TextStyle(color: Colors.red))),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    RouteUtil.routeSignOut(context);
                                  },
                                  child: Text('确定', style: TextStyle(color: Colors.blue)))
                              ],
                            )
                          );
                          // RouteUtil.routeToLoginPage(context);
                        },
                        child: Container(
                          padding: EdgeInsets.only(right: 5, left: 12),
                          height: 52,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('退出登录', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
  void _showUpdateDialog() {
    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (BuildContext context) {
    //       return UpdateDialog();
    //     }
    // );
  }
}

class MyMaterial extends StatelessWidget {
  final String label;
  final String value;
  final String type;
  final bool showLine;
  @required
  final VoidCallback onPressed;

  const MyMaterial({
    Key key,
    this.type,
    this.label,
    this.value,
    this.showLine = true,
    this.onPressed,
  }) : super(key: key);

  BoxDecoration get workListItemDecoration => BoxDecoration(
    boxShadow: [
      BoxShadow(
          color: Colors.black.withOpacity(0.03),
          offset: const Offset(0, 10),
          blurRadius: 10,
          spreadRadius: 0),
    ],
    borderRadius: const BorderRadius.all(Radius.circular(9)),
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 15.0),
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 15.0, 15.0, 15.0),
          constraints: BoxConstraints(
            maxHeight: double.infinity,
            minHeight: 76.0
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: showLine == true ? Divider.createBorderSide(context, color: Colours.line, width: 0.6) : Divider.createBorderSide(context, color: Colors.transparent, width: 0.0),
            )
          ),
          width: double.infinity,
          child: Row(
            children: <Widget>[
              Text(
                label,
                style: TextStyles.textDark14,
              ),
              const Spacer(),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: value != null ? 
                          Image.network('${this.value}', width: 50,height: 50, fit: BoxFit.cover,) : 
                          Container(),
                      ),
                    ],
                  )
                ),
              ),
              Opacity(
                // 无点击事件时，隐藏箭头图标
                opacity: this.onPressed == null ? 0 : 1,
                child: Padding(
                  padding: EdgeInsets.only(top: 0.0),
                  child: Image.asset('assets/images/icon/icon_arrow_right.png', width: 16, height: 16,),
                ),
              ),
              // Icon(Icons.keyboard_arrow_right, size: 24, color: Color.fromRGBO(153, 153, 153, 1))
            ],
          ),
        ),
      ),
    );
  }
}