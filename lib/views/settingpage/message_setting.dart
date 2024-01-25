import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:seller/style/resources.dart';

class MessageSetting extends StatefulWidget {
  @override
  _MessageSettingState createState() => _MessageSettingState();
}

class _MessageSettingState extends State<MessageSetting> {

  List _listData = [
    {
      'orange': '交易物流',
      'time': '1天前',
      'content': '物流节点不错过，订单到哪都知道',
      'type': 'trade',
      'img': 'https://images.wandougongzhu.cn/GenImg/?type=goods_promote&v=1&key=20',
      'value': true
    },
    {
      'orange': '账户通知',
      'time': '6天前',
      'content': '优惠券等账户信息变动提醒',
      'type': 'user',
      'img': '',
      'value': true
    },
    {
      'orange': '服务通知',
      'time': '6天前',
      'content': '预约抢购，降价通知，到货通知等服务提醒',
      'type': 'message',
      'img': '',
      'value': true
    },
    {
      'orange': '优惠促销',
      'time': '2019-9-22',
      'content': '促销福利，最新活动不错过',
      'type': 'promotion',
      'img': '',
      'value': true
    }
  ];

  Widget _renderItem(item) {
    var assetsUrl = 'assets/images/icon/icon_after-sale.png';
    Color itemcolor = Colors.white;
    var type = item['type'];
    if (type == 'user') {
      assetsUrl = 'assets/images/icon/icon_after-sale.png';
      itemcolor = Color(0xFFFF8519);
    } else if (type == 'coupon') {
      assetsUrl = 'assets/images/icon/icon_pay-success.png';
      itemcolor = Color(0xFF34354C);
    } else if (type == 'trade') {
      assetsUrl = 'assets/images/icon/icon_pay-success.png';
      itemcolor = Color(0xFF0DC557);
    } else if (type == 'message') {
      assetsUrl = 'assets/images/icon/icon_pay-success.png';
      itemcolor = Color(0xFF00C8DE);
    }
    return InkWell(
      onTap: () {
      },
      child: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 15, top: 10, bottom: 10),
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: itemcolor
              ),
              child: Image.asset(assetsUrl, width: 30, height: 30),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: Container(
                height: 70,
                alignment: Alignment.center,
                padding: EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFFf1f1f1),
                      width: 0.5
                    )
                  )
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(item['orange']),
                            ],
                          ),
                          Gaps.vGap4,
                          Text(item['content'], style: TextStyle(fontSize: 12, color: Color(0xFF666666)),maxLines: 1, overflow: TextOverflow.ellipsis,),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ),
            CupertinoSwitch(
              activeColor: Colors.red,
              value: item['value'],
              onChanged: (bool value) {
                print(value);
                setState(() {
                  item['value'] = !item['value'];
                });
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('消息通知'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: _listData.length,
        itemBuilder: (_, index) {
          return _renderItem(_listData[index]);
        },
      )
    );
  }
}