import 'package:flutter/material.dart';

import 'package:seller/views/refund/refund_list_content.dart';
import 'package:seller/style/resources.dart';
import 'package:seller/widgets/tab_view.dart';

class RefundsList extends StatefulWidget {
  const RefundsList({
    Key key,
    this.type = '进行中',
  }): super(key: key);

  final String type;

  @override
  _RefundsListState createState() =>  _RefundsListState();
}

class _RefundsListState extends State<RefundsList> with AutomaticKeepAliveClientMixin<RefundsList>, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;
  TabController _tabController;
  int _initIndex = 0;
  List<String> _tabs = ['进行中', '全部'];
  List<Widget> tabs = [
    MyTabView("进行中", "（3）", 0),
    MyTabView("全部", "（15）", 1),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return getWidget();
  }

  @override
  void initState() {
    if (widget.type == '全部') {
      _initIndex = 1;
    } else {
      _initIndex = 0;
    }
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
          title: Text('退款管理')
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
                labelPadding: const EdgeInsets.only(left: 11.0),
                unselectedLabelColor: Colours.text_dark,
                labelColor: Colours.app_main,
                indicatorPadding: const EdgeInsets.only(left: 12.0, right: 36.0),
                tabs: _tabs.map((name) {
                  var snum = 1;
                  if (name == '进行中') {
                    snum = 0;
                  } else {
                    snum = 4;
                  }
                  return MyTabView(name, '（$snum）', 1);
                }).toList(),
              ),
            ),
          Gaps.line,
          Expanded(
            child: TabBarView(
              children: _tabs.map((index) {
                print(index);
                // return CollectListPage(index: 2);
                if (index == '进行中') {
                  return RefundsListContent(index: 1);
                } else {
                  return RefundsListContent(index: 2);
                }
              }).toList(),
            ),
          )
          ],
        )
      )
    );
  }
}
