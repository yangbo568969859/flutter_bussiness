import 'package:flutter/material.dart';
import 'package:seller/utils/route_util.dart';
import 'package:seller/widgets/text_field_item.dart';
import 'package:seller/style/resources.dart';

class WechatCard extends StatefulWidget {
  @override
  _WechatCardState createState() => _WechatCardState();
}

class _WechatCardState extends State<WechatCard> {
  TextEditingController _nameController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();

  String wechatImage = 'https://img.aqsea.com/wl/other/20190626181358451-1847918077.jpg';
  String wechatNick = 'Chloe~';

  @override
  void initState() {
    super.initState();
    _nameController.text = wechatNick;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        title: Text('微信名片'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        textTheme: TextTheme(
          title: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          InkWell(
            onTap: () {
              RouteUtil.goBackWithParams(context, _nameController.text);
            },
            child: Container(
              width: 64,
              alignment: Alignment.center,
              child: Text('完成', style: TextStyle(color: Color(0xFF3233F3), fontSize: 13, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              height: 40,
              child: Text('填写微信号', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      offset: const Offset(0, 10),
                      blurRadius: 10,
                      spreadRadius: 0),
                ], 
              ),
              child: Column(
                children: <Widget>[
                  TextFieldItem(
                    title: "微信号",
                    hintText: "请输入微信号",
                    focusNode: _nodeText1,
                    controller: _nameController,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 16.0),
                        height: 50,
                        constraints: BoxConstraints(
                          minWidth: 75,
                          minHeight: 50
                        ),
                        child: Text(
                          '图例',
                          style: TextStyles.textDark14,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Image.network('https://img.aqsea.com/iBuyBuy/wechat/other/wechat-card_example.png', width: double.infinity),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: 40,
              child: Text('上传微信二维码', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Container(
              height: 220,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    offset: const Offset(0, 10),
                    blurRadius: 10,
                    spreadRadius: 0),
                ], 
              ),
              child: Container(
                child: this.wechatImage == '' ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      size: 44,
                    ),
                    Text('上传微信二维码')
                  ],
                ) : Padding(
                  padding: EdgeInsets.all(4),
                  child: Image.network(wechatImage),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}