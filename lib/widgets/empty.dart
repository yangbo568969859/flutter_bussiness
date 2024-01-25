import 'package:flutter/material.dart';

class EmptyPage extends StatefulWidget {
  final String type;
  final String text;
  final Widget child;

  const EmptyPage({
    Key key,
    this.type = 'normal',
    this.text = '暂无数据',
    this.child,
  }) : super(key: key);

  @override
  _EmptyPageState createState()=> _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {
  var image = "empty/no-data";
  @override
  void initState() {
    switch (widget.type) {
      case 'normal':
        image = "empty/no-data";
        break;
      case 'coupon':
        image = "empty/coupon_no-data";
        break;
      case 'order':
        image = "empty/order_no-data";
        break;
      case 'collect':
        image = "empty/collect_no-data";
        break;
      case 'address':
        image = "empty/address_no-data";
        break;
      case 'contact':
        image = "empty/contact_no-data";
        break;
      case 'idcard':
        image = "empty/idcard_no-data";
        break;
      case 'shopcart':
        image = "empty/shopcart_no-data";
        break;
      default:
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/${this.image}.png', width: 140, fit: BoxFit.fill),
            SizedBox(height: 20),
            Text(widget.text, style: TextStyle(fontSize: 13, color: Color(0xFF666666))),
            Container(
              child: widget.child,
            ),
          ],
        )
      ),
    );
  }
}