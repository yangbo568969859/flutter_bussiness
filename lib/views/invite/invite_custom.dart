import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:seller/style/resources.dart';
import 'package:seller/api/api.dart';

class InviteCustom extends StatefulWidget {
  @override
  _InviteCustomState createState() => _InviteCustomState();
}

class _InviteCustomState extends State<InviteCustom> {

  @override
  void initState() {
    super.initState();
    this.fetchList();
  }

  fetchList() async {
    // String urls = 'user-java.fans';
    // var res = await httpManager.netFetch(urls, null, null, null);
    // print(res);
  }

  renderItem(model) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(left: 15.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white
        ),
        height: 77,
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network('https://img.aqsea.com/wl/avatar/20190823143054255-1217564382.PNG', width: 50, height: 50),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: const BorderSide(
                      width: 0.5,
                      color: Color(0xFFf2f2f2),
                      style: BorderStyle.solid
                    )
                  )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('用户昵称', style: TextStyle(fontWeight: FontWeight.w500)),
                    Row(
                      children: <Widget>[
                        Text('微信号：shetuan321', style: TextStyle(fontSize: 13, color: Color(0xFF787878)))
                      ],
                    )
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('查看客户'),
      //   backgroundColor: Colors.white,
      //   iconTheme: IconThemeData(color: Colors.black),
      //   textTheme: TextTheme(
      //     title: TextStyle(
      //       color: Colors.black,
      //       fontSize: 16.0,
      //     ),
      //   ),
      //   centerTitle: true,
      //   actions: <Widget>[
      //     InkWell(
      //       onTap: () {
      //       },
      //       child: Container(
      //         width: 64,
      //         alignment: Alignment.center,
      //         child: Text('邀请客户', style: TextStyle(color: Color(0xFF3233F3), fontSize: 12)),
      //       ),
      //     )
      //   ],
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar( // 类似AppBar，但是可以设置滚动效果
            title: Text('查看客户'), // 导航栏标题
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.black),
            textTheme: TextTheme(
              title: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
            elevation: 0,
//            pinned: true, // 设置为true就会固定在顶部
            floating: true, // 下拉显示效果
            expandedHeight: 178.0, // 设置顶部向下伸展的高度
            flexibleSpace: FlexibleSpaceBar( // 向下伸展的部分
              title: Container(
                color: Colours.color_f5,
                // width: double.infinity,
                // alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('客户总数', style: TextStyle(color: Color(0xFF3233F3), fontSize: 12)),
                    Gaps.hGap12,
                    Text('0', style: TextStyle(color: Color(0xFF3233F3), fontSize: 12))
                  ],
                ),
              ),
              background: Image.network('http://w.kl.126.net/public/mykaola-mobile/6d111bc9fc56e0026c4093e47e330116.png',
                fit: BoxFit.cover,
              ),
            ),
            actions: <Widget>[
              InkWell(
                onTap: () {
                },
                child: Container(
                  width: 64,
                  alignment: Alignment.center,
                  child: Text('邀请客户', style: TextStyle(color: Color(0xFF3233F3), fontSize: 12)),
                ),
              )
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var model = '';
                return renderItem(model);
              },
              childCount: 10,
            )
          )
        ],
      ),
    );
  }
}