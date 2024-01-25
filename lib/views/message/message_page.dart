import 'package:flutter/material.dart';
import 'package:seller/style/resources.dart';
import 'package:seller/utils/route_util.dart';
import 'package:seller/widgets/pull/my_refresh_list.dart';


class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}
class _MessagePageState extends State<MessagePage> {
  int _pageNo = 1;
  int _maxPage;
  bool _hasMore = false;

  List _listData = [];

  _fetchList() {
    print('开始请求数据');
    _listData = [
      {
        'orange': '促销优惠',
        'time': '1天前',
        'content': '您有超值优惠券即将过期，快来看看吧',
        'type': 'coupon',
        'img': 'https://images.wandougongzhu.cn/GenImg/?type=goods_promote&v=1&key=20',
      },
      {
        'orange': '账户通知',
        'time': '6天前',
        'content': '您有一张价值20元的优惠券即将过期了',
        'type': 'user',
        'img': '',
      },
      {
        'orange': '互动消息',
        'time': '6天前',
        'content': '可以加钙粉泡里面吗',
        'type': 'message',
        'img': '',
      },
      {
        'orange': '交易物流',
        'time': '2019-9-22',
        'content': '订单已完成，期待您的分享商品与评价',
        'type': 'trade',
        'img': '',
      }
    ];
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
    return  Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          RouteUtil.routeToMessageListPage(context, title: item['orange'], pageId: '1212');
        },
        child: Container(
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
                              Text(item['time'], style: TextStyle(fontSize: 12, color: Color(0xFF666666))),
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
              )
            ],
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('消息中心'),
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: DeerListView(
          itemCount: _listData.length,
          stateType: 'normal',
          onRefresh: _onRefresh,
          loadMore: _loadMore,
          hasMore: _hasMore,
          itemBuilder: (_, index){
            return  _renderItem(_listData[index], index);
          }
        ),
      )
    );
  }
}

