import 'package:flutter/material.dart';

import 'package:seller/views/order/order_list_content.dart';
import 'package:seller/style/resources.dart';
import 'package:seller/widgets/tab_view_v2.dart';

class OrdersList extends StatefulWidget {
  final int type;
  const OrdersList({
    Key key,
    this.type = 1,
  }): super(key: key);

  @override
  _OrdersListState createState() =>  _OrdersListState();
}

class _OrdersListState extends State<OrdersList> with AutomaticKeepAliveClientMixin<OrdersList>, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;
  TabController _tabController;
  int _initIndex = 0;
  List<String> _tabs = ['全部', '待付款', '待发货', '已发货', '交易成功'];
  List<String> _tabsCode = ['all', 'wait_pay', 'wait_consign', 'wait_sign', 'trade_successed'];
  List<Widget> tabs = [
    MyTabViewV2("进行中", "（3）", 0),
    MyTabViewV2("全部", "（15）", 1),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return getWidget();
  }

  @override
  void initState() {
    _initIndex = widget.type!=null ? widget.type: 0;
    // if (widget.type == '全部') {
    //   _initIndex = 1;
    // } else {
    //   _initIndex = 0;
    // }
    super.initState();
  }

  DefaultTabController getWidget() {
    return DefaultTabController(
      initialIndex: _initIndex,
      length: _tabs.length,
      child: Scaffold(
        backgroundColor: Color(0xFFF7F7F7),
        appBar: AppBar(
          centerTitle: true,
          title: Text('订单管理')
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.white,
              width: double.infinity,
              child: TabBar(
                isScrollable: true,
                controller: _tabController,
                labelStyle: TextStyles.textBoldDark14,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: const EdgeInsets.only(left: 5.0, right: 5.0),
                unselectedLabelColor: Colours.text_dark,
                labelColor: Colours.app_main,
                indicatorPadding: const EdgeInsets.only(left: 12.0, right: 12.0),
                tabs: _tabs.map((name) {
                  var snum = 1;
                  if (name == '进行中') {
                    snum = 0;
                  } else {
                    snum = 4;
                  }
                  return MyTabViewV2(name, '$snum', 1);
                }).toList(),
              ),
            ),
            Gaps.line,
            Expanded(
              child: TabBarView(
                children: _tabsCode.map((index) {
                  return OrdersListContent(index: index);
                }).toList(),
              ),
            )
          ],
        )
      )
    );
  }
}
