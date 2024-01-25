import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:seller/style/resources.dart';
import 'package:seller/utils/route_util.dart';
import 'package:seller/widgets/my_card.dart';
import 'package:seller/api/api.dart';
import 'package:seller/model/store.dart';

import 'package:seller/model/loading_state.dart';
import 'package:seller/widgets/load_widget.dart';
import 'package:seller/widgets/load_image.dart';
import 'package:seller/views/store/store_provider.dart';
import 'package:provider/provider.dart';

class StoreDecoration extends StatefulWidget {
  @override
  _StoreDecorationState createState() => _StoreDecorationState();
}

class _StoreDecorationState extends State<StoreDecoration> {
  StoreTemplate storeData;
  ShopTheme shopTheme;
  ShopThemeItem shopThemeItem;
  List<StoreTemplateItem> _listData = [];
  LoadingState _loadingState = LoadingState.Loading;
  final StoreProvider provider = StoreProvider();

  fetchList() async {
    String urls = 'setting.shop.theme.template.page';
    var res = await httpManager.netFetch(urls, {
      'page_no': 1,
      'page_size': 20,
      'v': '9.0.0',
      'title': '',
    }, null, null);
    var response = json.decode(res.toString());
    storeData = StoreTemplate.fromJson(response);
    if (storeData.data != null) {
      setState(() {
        _listData = storeData.data.data.data;
        _loadingState = LoadingState.NoMore;
      });
    }
  }

  fetchStoreInfo() async {
    String urls = 'setting.shop.theme.get';
    var res = await httpManager.netFetch(urls, {
      'shop_id': 29,
    }, null, null);
    var response = json.decode(res.toString());
    shopTheme = ShopTheme.fromJson(response);
    if (shopTheme != null) {
      setState(() {
        shopThemeItem = shopTheme.data.data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.fetchList();
    this.fetchStoreInfo();
    // Future.microtask(() =>
    //   Provider.of<Foo>(context).fetchSomething(someValue);
    // );
    // Future.microtask(() => Provider.of(context)._fetchStore());
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   this.fetchList();
  //   this.fetchStoreInfo();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        title: Text('店铺装修'),
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
            },
            child: Container(
              width: 64,
              alignment: Alignment.center,
              child: Text('查看店铺', style: TextStyle(color: Color(0xFF3233F3), fontSize: 12)),
            ),
          )
        ],
      ),
      body: storeData == null && shopThemeItem == null ? LoadingWidget(_loadingState) : 

      SingleChildScrollView(
        child: Consumer<StoreProvider>(
          builder: (_, StoreProvider provider, __) {
            print(provider.choiceTheme1);
            provider.setShopTheme(shopTheme.data.data);
            // Future.delayed(Duration(microseconds: 100)).then((e) {
            //   provider.setShopTheme(shopTheme.data.data);
            // });
            return Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  alignment: Alignment.centerLeft,
                  child: Text('选择店铺模版', style: TextStyle(color: Color(0xFF787878)),),
                  height: 46,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 15.0),
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.68,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 8
                  ),
                  itemCount: _listData.length,
                  itemBuilder: (context, index) {
                    var model = _listData[index];
                    var isTrue = false;
                    if (shopThemeItem.shopThemeTemplateId == model.shopThemeTemplateId) {
                      isTrue = true;
                    }
                    return MyCard(
                      child: InkWell(
                        onTap: () {
                          provider.setChoiceTheme(model);
                          RouteUtil.routeToStoreThemeDetail(context);
                        },
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Image.network(model.themeImg),
                              ),
                            ),
                            Container(
                              child: isTrue == true ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  LoadAssetImage("icon/selectedv3@2x", width: 16.0, height: 16.0),
                                  Gaps.hGap8,
                                  Text('正在使用', style: TextStyle(fontSize: 12, color: Color(0xFF3233F3)))
                                ],
                              ) : Text(model.title, style: TextStyle(fontSize: 12)),
                              height: 40,
                              alignment: Alignment.center,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            );
          }
        ),
      )


      // ChangeNotifierProvider<StoreProvider>(
      //   builder: (_) => provider,
      //   child: SingleChildScrollView(
      //     child: Consumer<StoreProvider>(
      //       builder: (_, provider, __) {
      //         return Column(
      //           children: <Widget>[
      //             Container(
      //               padding: EdgeInsets.symmetric(horizontal: 15.0),
      //               alignment: Alignment.centerLeft,
      //               child: Text('选择店铺模版', style: TextStyle(color: Color(0xFF787878)),),
      //               height: 46,
      //             ),
      //             GridView.builder(
      //               shrinkWrap: true,
      //               padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 15.0),
      //               physics: NeverScrollableScrollPhysics(),
      //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //                 crossAxisCount: 2,
      //                 childAspectRatio: 0.68,
      //                 mainAxisSpacing: 12,
      //                 crossAxisSpacing: 8
      //               ),
      //               itemCount: _listData.length,
      //               itemBuilder: (context, index) {
      //                 var model = _listData[index];
      //                 var isTrue = false;
      //                 if (provider.shopTheme.shopThemeTemplateId == model.shopThemeTemplateId) {
      //                   isTrue = true;
      //                 }
      //                 return MyCard(
      //                   child: InkWell(
      //                     onTap: () {
      //                       provider.setChoiceTheme(model);
      //                       RouteUtil.routeToStoreThemeDetail(context);
      //                     },
      //                     child: Column(
      //                       children: <Widget>[
      //                         Expanded(
      //                           flex: 1,
      //                           child: Container(
      //                             child: Image.network(model.themeImg),
      //                           ),
      //                         ),
      //                         Container(
      //                           child: isTrue == true ? Row(
      //                             mainAxisAlignment: MainAxisAlignment.center,
      //                             children: <Widget>[
      //                               LoadAssetImage("icon/selectedv3@2x", width: 16.0, height: 16.0),
      //                               Gaps.hGap8,
      //                               Text('正在使用', style: TextStyle(fontSize: 12, color: Color(0xFF3233F3)))
      //                             ],
      //                           ) : Text(model.title, style: TextStyle(fontSize: 12)),
      //                           height: 40,
      //                           alignment: Alignment.center,
      //                         )
      //                       ],
      //                     ),
      //                   ),
      //                 );
      //               },
      //             )
      //           ],
      //         );
      //       }
      //     ),
      //   )
      // )
    );
  }
}