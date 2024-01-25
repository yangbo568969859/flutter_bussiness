import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:seller/utils/route_util.dart';
import 'package:seller/api/api.dart';
import 'package:seller/model/login.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:seller/utils/local_storage.dart';
import 'package:seller/utils/toast.dart';

class LoginPage extends StatefulWidget {

  LoginPage({Key key, this.isClose: true}) : super();

  final bool isClose;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  var _userName = "";
  var _password = "";

  TextEditingController pwController;
  TextEditingController userController;

  var _eyeColor = Colors.black;
  var _isObscure = true;
  AnimationController _controller2;
  List<Color> btnColors = [Colors.blue, Colors.blue[300]];
  Color btnColor;

  int index = 0;
  Tween<double> _scaleTween;
  Tween<double> _widthTween;
  Animation<double> _animation;
  AnimationController _controller;
  AnimationController _widthController;
  Animation<double> _widthAnimation;
  
  @override
  void initState() {
    // userController.value = new TextEditingValue(text: _userName ?? "");
    // pwController.value = new TextEditingValue(text: _password ?? "");
    _controller2 = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 200));
    super.initState();
    btnColor = btnColors[0];
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _widthController = AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _scaleTween = Tween(begin: 0, end: 1);
    _widthTween = Tween(end: 45, begin: 400);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack);
    _widthAnimation = CurvedAnimation(parent: _widthController, curve: Curves.easeInOutBack).drive(_widthTween);
  }

  Future _submitLogin() async {
    if (_userName == '') {
      MyToast.show('请输入用户名', gravity: 'center');
      return false;
    } else if (_password == '') {
      MyToast.show('请输入密码', gravity: 'center');
      return false;
    }
    String urls = 'auth.token.get';
    var res = await httpManager.netFetch(urls, {
      "client_id":"app",
      "client_secret":"dbb60e2b545334c",
      "scope":"openid profile category_brand shop discovery item logistics user trade_refund fund account payment setting offline_access",
      "user_name": _userName,
      "password": _password,
      "grant_type":"password"
    }, null, 'POST');
    Login loginRes = Login.fromJson(res);
    if (loginRes.data.token != null) {
      LocalStorage.save('user', json.encode(loginRes.data.user.toJson()));
      LocalStorage.save('token', json.encode(loginRes.data.token.toJson()));
      return true;
    } else {
      return loginRes.data.msg;
    }
  }

  @override
  void dispose() {
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(
          // image: backgroundImage,
        ),
        child: Container(
          child: ListView(
            children: <Widget>[
              new Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.centerLeft,
                        height: 28,
                        child: widget.isClose == true ? InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            size: 28,
                          ),
                        ) : Container(),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Image.network('https://img.aqsea.com/iBuyBuy/wechat/logo/ibuybuy_logo.png', width: 70, height: 70),
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            buildUserTextField(),
                            SizedBox(height: 12),
                            buildPasswordTextField(context),
                            SizedBox(height: 22),
                            new Container(
                              height: 45.0,
                              margin: EdgeInsets.only(top: 30.0, bottom: 30.0),
                              child: GestureDetector(
                                onTapDown: (d) {
                                  setState(() {
                                    btnColor = btnColors[1];
                                  });
                                },
                                onTapUp: (d) {
                                  Future.delayed(Duration(milliseconds: 60), () {
                                    _submitLogin().then((va) {
                                      if (va == true) {
                                        print(LocalStorage.get('token'));
                                        print('获取token');
                                        setState(() {
                                          index = 1;  
                                          btnColor = btnColors[0];
                                        });
                                        _widthController.forward();
                                        Future.delayed(Duration(milliseconds: 200), () {
                                          _controller.forward().then((va) {
                                            // Navigator.pop(context);
                                            RouteUtil.routeToHomeCloseCurrentPage(context);
                                          });
                                        });
                                      } else {
                                        MyToast.show(va, gravity: 'center');
                                      }
                                    });
                                  });
                                },
                                onTapCancel: () {
                                  setState(() {
                                    btnColor = btnColors[0];
                                  });
                                },
                                child: AnimatedBuilder(
                                  animation: _widthAnimation,
                                  builder: (BuildContext context, Widget child) {
                                    return Container(
                                      width: _widthAnimation.value,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(40)),
                                        color: btnColor,
                                      ),
                                      height: 50.0,
                                      child: IndexedStack(
                                        alignment: Alignment.center,
                                        index: index,
                                        children: <Widget>[
                                          Text('登 录', style: TextStyle(fontSize: 16, color: Colors.white)),
                                          ScaleTransition(
                                            scale: _scaleTween.animate(_animation),
                                            child: Icon(Icons.check, size: 24, color: Colors.white),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  GestureDetector(
                                    child: Text('密码登录', style: TextStyle(color: Color(0xFF999999))),
                                  )
                                ],
                              ),
                            ),
                            buildSigninRule()
                          ],
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  TextField buildPasswordTextField(BuildContext context) {
    return TextField(
      obscureText: _isObscure,
      onChanged: (String value) {
        _password = value;
      },
      decoration: InputDecoration(
        labelText: '密码',
        labelStyle: new TextStyle(color: Color(0xFF999999)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFEFEFEF), //边线颜色为黄色
            width: 1, //边线宽度为2
          ),
        ),
        enabledBorder:  UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFEFEFEF), //边线颜色为黄色
            width: 1, //边线宽度为2
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.remove_red_eye,
            color: _eyeColor,
          ),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
              _eyeColor = _isObscure
                  ? Colors.grey
                  : Theme.of(context).iconTheme.color;
            });
          })),
    );
  }
  TextField buildUserTextField() {
    return TextField(
      decoration: InputDecoration(
        // hasFloatingPlaceholder: false,
        labelText: '请输入手机号码',
        labelStyle: new TextStyle(color: Color(0xFF999999)),
        hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFEFEFEF), //边线颜色为黄色
            width: 1, //边线宽度为2
          ),
        ),
        enabledBorder:  UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFEFEFEF), //边线颜色为黄色
            width: 1, //边线宽度为2
          ),
        ),
      ),
      onChanged: (String value) {
        _userName = value;
      },
    );
  }
  FlatButton buildSigninRule() {
    return FlatButton(
      padding: const EdgeInsets.only(
        top: 160.0,
      ),
      onPressed: null,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('登录即代表您已同意', style: TextStyle(fontSize: 12)),
          GestureDetector(
            onTap: () {},
            child: Text('《隐私政策》', style: TextStyle(color: Colors.red, fontSize: 12)),
          ),
          GestureDetector(
            onTap: () {},
            child: Text('《用户服务协议》', style: TextStyle(color: Colors.red, fontSize: 12)),
          )
        ],
      ),
    );
  }
  // Positioned buildSigninRule() {
  //   return Positioned(
  //     bottom: 20,
  //     left: 0,
  //     right: 0,
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         Text('登录即代表您已同意', style: TextStyle(fontSize: 12)),
  //         GestureDetector(
  //           onTap: () {},
  //           child: Text('《隐私政策》', style: TextStyle(color: Colors.red, fontSize: 12)),
  //         ),
  //         GestureDetector(
  //           onTap: () {},
  //           child: Text('《用户服务协议》', style: TextStyle(color: Colors.red, fontSize: 12)),
  //         )
  //       ],
  //     )
  //   );
  // }
}

class SignUpArrowButton extends StatelessWidget {
  final IconData icon;
  final Function onTap;
  final double iconSize;
  final double height;
  final double width;
  final Color iconColor;

  SignUpArrowButton({
    this.icon,
    this.iconSize,
    this.onTap,
    this.height = 50.0,
    this.width = 50.0,
    this.iconColor = const Color(0xFFdbedb0),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 15,
                spreadRadius: 0,
                offset: Offset(0.0, 16.0)),
          ],
          gradient: LinearGradient(begin: FractionalOffset.centerLeft,
              stops: [
                0.2,
                1
              ], colors: [
            Color(0xff000000),
            Color(0xff434343),
          ]),
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: iconColor,
        ),
      ),
    );
  }
}