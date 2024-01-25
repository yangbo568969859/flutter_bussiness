import 'package:flutter/material.dart';

import 'package:seller/style/resources.dart';

import 'package:seller/views/goods/goods_list_content.dart';
import 'package:seller/widgets/tab_view.dart';

class GoodsList extends StatefulWidget {

  @override
  _GoodsListState createState() => _GoodsListState();
}

class _GoodsListState extends State<GoodsList> with SingleTickerProviderStateMixin{
  TabController _tabController;
  PageController _pageController = PageController(initialPage: 0);
  List<Widget> tabs = [
    MyTabView("在售", " (3件)", 0),
    MyTabView("下架", " (15件)", 1),
    MyTabView("草稿", " (26件)", 2),
  ];
  bool isEdit = false;

  setEdit() {
    setState(() {
      isEdit = !isEdit;
    });
  }

  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品管理'),
        centerTitle: true,
        actions: <Widget>[
          InkWell(
            onTap: setEdit,
            child: Container(
              width: 64,
              alignment: Alignment.center,
              child: Text(this.isEdit==true?'完成':'编辑', style: TextStyle(color: Colors.white, fontSize: 14)),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: TabBar(
              isScrollable: true,
              controller: _tabController,
              labelStyle: TextStyles.textBoldDark14,
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: const EdgeInsets.only(left: 11.0),
              unselectedLabelColor: Colours.text_dark,
              labelColor: Colours.app_main,
              indicatorPadding: const EdgeInsets.only(left: 12.0, right: 36.0),
              tabs: tabs,
              onTap: (index){
                if (!mounted){
                  return;
                }
                _pageController.jumpToPage(index);
              },
            ),
          ),
          Gaps.line,
          Expanded(
            child: PageView.builder(
              itemCount: 3,
              onPageChanged: _onPageChange,
              controller: _pageController,
              itemBuilder: (BuildContext context, int index) {
                print(index);
                return GoodsListContent(index: index, isEdit: isEdit);
              },
            ),
          )
        ],
      ),
    );
  }

  _onPageChange(int index) {
    _tabController.animateTo(index);
  }
}