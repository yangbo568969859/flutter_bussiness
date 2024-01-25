import 'package:flutter/material.dart';
import 'package:seller/style/gaps.dart';
import 'package:seller/utils/route_util.dart';

import 'package:seller/views/store/store_provider.dart';
import 'package:provider/provider.dart';
import 'package:seller/widgets/click_item.dart';

class StoreThemeDetail extends StatefulWidget {
  @override
  _StoreThemeDetailState createState() => _StoreThemeDetailState();
}

class _StoreThemeDetailState extends State<StoreThemeDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StoreProvider>(
      builder: (_, provider, __) {
        var isDisabled = provider.choiceTheme.shopThemeTemplateId == provider.shopThemeP.shopThemeTemplateId;
        return Scaffold(
          backgroundColor: Color(0xFFF7F7F7),
          appBar: AppBar(
            title: Text(provider.choiceTheme.title),
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            textTheme: TextTheme(
              title: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
            centerTitle: true,
          ),
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ClickItemAvater(
                      label: '封面图片',
                      value: provider.choiceTheme.bgImg,
                      type: 'avatar',
                      showLine: true,
                      borderRadius: 6.0,
                      width: 100.0,
                      onPressed: () {
                        RouteUtil.routeToStoreThemeImage(context);
                        // _getImage();
                      },
                    ),
                    // ClickItem(
                    //   label: '封面图片',
                    //   value: '',
                    //   onPressed: () {
                    //   }
                    // ),
                    ClickItem(
                      label: '商品样式',
                      value: '',
                      showLine: false,
                      onPressed: () {
                      }
                    ),
                    Gaps.vGap10,
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 20.0),
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 40,
                            alignment: Alignment.centerLeft,
                            child: Text('选择店铺模板', style: TextStyle(color: Color(0xFF787878), fontSize: 13)),
                          ),
                          Image.network(provider.choiceTheme.themeImg)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  height: 50,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            // child: Text('正在使用'),
                            child: Text(isDisabled ? '正在使用' : '立即使用'),
                          ),
                          onPressed: isDisabled ? null : () {},
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)
                          ),
                          color: Color(0xFF3233F3),
                          textColor: Colors.white,
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            child: Text('预览效果'),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        );
      },
    );
  }
}