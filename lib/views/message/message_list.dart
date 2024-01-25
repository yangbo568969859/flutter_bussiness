import 'package:flutter/material.dart';
import 'package:seller/utils/route_util.dart';
import 'package:seller/widgets/my_card.dart';
import 'package:seller/widgets/pull/my_refresh_list.dart';


class MessageListPage extends StatefulWidget {
  const MessageListPage({
    Key key,
    this.title,
    this.pageId,
  }) : super(key: key);

  final String title;
  final String pageId;
  @override
  _MessagePageState createState() => _MessagePageState();
}
class _MessagePageState extends State<MessageListPage> {
  int _pageNo = 1;
  int _maxPage;
  bool _hasMore = false;
  List _listData = [];

  _fetchList() {
    print('开始请求数据');
    print(widget.title);
    switch(widget.title) {
      case '促销优惠' :
        _listData = [
          {
            'orange': 'iPhone 11现货抢购！',
            'time': '1天前',
            'content': '三只松鼠坚果大礼包8袋 每日坚果网红零食干果礼盒夏威夷果碧根果节日送礼1473g/1419g（新老套餐随机发货）',
            'type': 'coupon',
            'img': 'https://ossimg.wandougongzhu.cn/898dcdf1accc0bc64cc6e9e71102bee5.jpg@750w_402h_1l.webp',
            'action': {
              'type': 'activity',
              'url': '2'
            }
          },
          {
            'orange': '看这里，下一个奶宠就是你',
            'time': '3天前',
            'content': '华美华夏尊礼月饼礼袋',
            'type': 'coupon',
            'img': 'https://ossimg.wandougongzhu.cn/d39819e27b4aa66afed2d0787adefb4b.png@750w_402h_1l.webp',
            'action': {
              'type': 'activity',
              'url': '3'
            }
          },
          {
            'orange': '恭喜你赶上了冬枣促销！',
            'time': '6天前',
            'content': '恭喜您账户得到升级',
            'type': 'user',
            'img': 'https://ossimg.wandougongzhu.cn/9aa326e9263da9e885fcee7489ee0aa9.jpg@750w_402h_1l.webp',
            'action': {
              'type': 'coupon',
              'url': ''
            }
          }
        ];
        break;
      case '账户通知' :
        _listData = [
          {
            'orange': '优惠券即将过期',
            'time': '1天前',
            'content': '您有超值优惠券即将过期，快来看看吧',
            'type': 'coupon',
            'img': 'https://images.wandougongzhu.cn/GenImg/?type=goods_promote&v=1&key=20',
            'action': {
              'type': 'coupon',
              'url': ''
            }
          },
          {
            'orange': '优惠券到账',
            'time': '3天前',
            'content': '您昨日收到4张优惠券，快来看看吧',
            'type': 'coupon',
            'img': 'https://images.wandougongzhu.cn/GenImg/?type=goods_promote&v=1&key=20',
            'action': {
              'type': 'coupon',
              'url': ''
            }
          },
          {
            'orange': '优惠券过期提醒',
            'time': '3天前',
            'content': '您有两张优惠券到账，优惠总额100元，最高可满39减20元，近日就花掉他吧~',
            'type': 'coupon',
            'img': 'https://images.wandougongzhu.cn/GenImg/?type=goods_promote&v=1&key=20',
            'action': {
              'type': 'coupon',
              'url': ''
            }
          },
          {
            'orange': '用户等级提升',
            'time': '6天前',
            'content': '恭喜您账户得到升级',
            'type': 'user',
            'img': '',
          }
        ];
        break;
      case '互动消息' :
        _listData = [
          {
            'orange': '有人向你提问',
            'time': '1天前',
            'content': '可以加钙粉泡里面吗？',
            'type': 'coupon',
            'img': 'http://img10.360buyimg.com/mobilecms/s234x234_jfs/t1/10697/22/15579/252390/5c948743E3a9fd372/f91e62a928d03f96.jpg!q70.dpg.webp',
          },
          {
            'orange': '有人向你提问',
            'time': '3天前',
            'content': '里面都有哪些坚果',
            'type': 'coupon',
            'img': '//img10.360buyimg.com/mobilecms/s234x234_jfs/t1/67841/38/11230/220492/5d89c79bEe274eb25/dee77244e92eaf89.jpg!q70.dpg.webp',
          },
        ];
        break;
      case '交易物流' :
        _listData = [
          {
            'orange': '您的订单已完成',
            'time': '1天前',
            'content': ' 【酒厂直营】沱牌舍得 品味舍得小酒版 38度 100ml 浓香型白酒',
            'type': 'coupon',
            'img': 'http://img10.360buyimg.com/mobilecms/s234x234_jfs/t1/50444/2/9064/63367/5d663ef4eefbe7264/8768d6d974ee59c9.jpg!q70.dpg.webp',
            'action': {
              'type': 'trade',
              'url': '1568190693261058'
            }
          },
          {
            'orange': '您的订单已完成',
            'time': '3天前',
            'content': '三只松鼠坚果大礼包8袋 每日坚果网红零食干果礼盒夏威夷果碧根果节日送礼1473g/1419g（新老套餐随机发货）',
            'type': 'coupon',
            'img': 'https://img10.360buyimg.com/mobilecms/s234x234_jfs/t1/56862/26/11582/313685/5d89c890ea994137c/812cae15e6edacb3.jpg!q70.dpg.webp',
            'action': {
              'type': 'trade',
              'url': '1568702491721058'
            }
          },
          {
            'orange': '您的订单已完成',
            'time': '6天前',
            'content': '华美华夏尊礼月饼礼袋',
            'type': 'user',
            'img': 'http://img10.360buyimg.com/mobilecms/s234x234_jfs/t1/52029/15/6353/55244/5d3ebcf8efdcea264/041c1c575980dd51.jpg!q70.dpg.webp',
            'action': {
              'type': 'goods',
              'url': '10004613'
            }
          }
        ];
        break;
    }
  }
  @override
  void initState() {
    super.initState();
    _fetchList();
  }


  @override
  void dispose() {
    super.dispose();
  }

  Future _onRefresh() async {
    _pageNo = 1;
    _fetchList();
    return null;
  }

  Future _loadMore() async {
    if (_pageNo >= _maxPage) {
      setState(() {
        _hasMore = false;
      });
      return;
    }
    _pageNo++;
    _fetchList();
  }
  _renderItem(item, index) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: MyCard(
        child: InkWell(
          onTap: () {
            if (item['action'] != null) {
              RouteUtil.goSwitchPage(context, item['action']);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            // margin: EdgeInsets.only(bottom: 10),
            child: Column(
              children: <Widget>[
                Container(
                  height: 22,
                  child: Row(
                    children: <Widget>[
                      Text('${item['orange']}', style: TextStyle(fontSize: 13)),
                      Expanded(flex: 1, child: Container()),
                      Text('${item['time']}', style: TextStyle(fontSize: 11, color: Colors.grey[500]))
                    ],
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                    minHeight: 50
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: Text('${item['content']}', overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: Color(0xFF959595)), maxLines: 3),
                        ),
                      ),
                      SizedBox(width: 10),
                      item['img'] != '' ? Image.network(item['img'], width: 50, height: 50) : Container()
                    ],
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: <Widget>[
                    Text('查看详情', style: TextStyle(fontSize: 11, color: Colors.grey[500]))
                  ],
                )
              ],
            ),
          ),
        )
      ),
    );
  }
  /// 促销优惠
  _renderItem1(item, index) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              child: Text(item['time'], style: TextStyle(color: Colors.white, fontSize: 11)),
            ),
          ),
          MyCard(
            child: InkWell(
              onTap: () {
                if (item['action'] != null) {
                  RouteUtil.goSwitchPage(context, item['action']);
                }
              },
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        image: DecorationImage(image: NetworkImage(item['img']), fit: BoxFit.cover)
                      ),
                    ),
                    Container(
                      width: 400,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(item['orange'], overflow: TextOverflow.ellipsis, maxLines: 1),
                          SizedBox(height: 4),
                          Text(item['content'], overflow: TextOverflow.ellipsis, maxLines: 2, style: TextStyle(fontSize: 12, color: Color(0xFF6E6E6E)),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title != '' ? widget.title:'消息中心'),
        centerTitle: true,
        elevation: 0,
      ),
      body: DeerListView(
        itemCount: _listData.length,
        stateType: 'normal',
        onRefresh: _onRefresh,
        loadMore: _loadMore,
        hasMore: _hasMore,
        itemBuilder: (_, index){
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: widget.title == '促销优惠' ? _renderItem1(_listData[index], index) : _renderItem(_listData[index], index),
          );
        }
      )
    );
  }
}

