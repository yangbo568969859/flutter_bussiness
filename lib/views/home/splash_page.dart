import 'package:flutter/material.dart';
import 'package:seller/views/home/home_page.dart';
import 'package:seller/views/login/login_page.dart';

import 'package:seller/utils/data_utils.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  // int _status = 0;
  AnimationController _controller;
  Animation _animation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 2000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkOnline();
        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (route) => route == null);
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void checkOnline() {
    DataUtils.isLogin().then((isLogin) {
      print(isLogin);
      if (isLogin == false) {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage(isClose: false)), (route) => route == null);
      } else {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (route) => route == null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FadeTransition(
        opacity: _animation,
        child: Stack(
          children: <Widget>[
            Image.asset('assets/images/statistic/seller_register.jpg', width: double.infinity, scale: 2.0, fit: BoxFit.cover)
          ],
        ),
      ),
    );
  }

}