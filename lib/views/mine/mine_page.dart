import 'package:flutter/material.dart';

import 'package:seller/style/resources.dart';

import 'package:seller/utils/route_util.dart';

import 'package:seller/widgets/click_item.dart';
import 'package:seller/widgets/my_card.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: false,
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: 160,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  // margin: EdgeInsets.only(left: 15.0, right: 15.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // borderRadius: new BorderRadius.all(new Radius.circular(8.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.03),
                        offset: Offset(0, 10),
                        blurRadius: 10,
                        spreadRadius: 0
                      ),
                    ],
                    image: new DecorationImage(
                      image: new NetworkImage('http://w.kl.126.net/public/mykaola-mobile/6d111bc9fc56e0026c4093e47e330116.png'),
                      // centerSlice: new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                      fit: BoxFit.cover
                    ),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 30,
                        right: 50,
                        child: InkWell(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Image.asset('assets/images/icon/icon_setting.png', width: 20, height: 20),
                          ),
                          onTap: () {
                            RouteUtil.routeToSettingPage(context);
                          },
                        ),
                      ),
                      Positioned(
                        top: 30,
                        right: 10,
                        child: InkWell(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Image.asset('assets/images/icon/icon_message.png', width: 20, height: 20),
                              ),
                              Positioned(
                                top: 3,
                                right: 3,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Colors.red
                                  ),
                                ),
                              )
                            ],
                          ),
                          onTap: () {
                            RouteUtil.routeToMessagePage(context);
                          },
                        ),
                      ),
                      Positioned(
                        top: 60,
                        left: 20,
                        child: InkWell(
                          onTap: () {
                            RouteUtil.routeToSettingPage(context);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(75),
                                // https://img.aqsea.com/iBuyBuy/wechat/avater/default_shop-avater.png
                                child: Image.network('https://img.aqsea.com/wl/avatar/20190702185245437-12544153.png', width: 75, height: 75, fit: BoxFit.cover),
                              ),
                              Gaps.hGap12,
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('爱琴嗨购官方旗舰店铺', style: TextStyles.textBoldDark16),
                                    Gaps.vGap4,
                                    Text('15669089859', style: TextStyles.textGray14),
                                  ],
                                ),
                              ),
                              // _islogin == false ? InkWell(
                              //   onTap: () {
                              //   },
                              //   child: Container(
                              //     alignment: Alignment.centerLeft,
                              //     height: 60,
                              //     width: 160,
                              //     child: Text('登录/注册', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                              //   ),
                              // ) : Text(_user.nick, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
                            ],
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // SliverToBoxAdapter(
            //   child: Container(
            //     color: Colors.white,
            //     padding: EdgeInsets.all(15.0),
            //     child: Row(
            //       children: <Widget>[
            //         Expanded(
            //           flex: 1,
            //           child: MyCard(
            //             child: Container(
            //               padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: <Widget>[
            //                   Text('资产'),
            //                   Gaps.vGap8,
            //                   Text('福利， 资产', style: TextStyle(fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis)
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ),
            //         SizedBox(width: 5),
            //         Expanded(
            //           flex: 1,
            //           child: MyCard(
            //             child: Container(
            //               padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: <Widget>[
            //                   Text('邀好友', style: TextStyle(fontSize: 16)),
            //                   Gaps.vGap8,
            //                   Text('邀好友，享优惠', style: TextStyle(fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis)
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ),
            //         SizedBox(width: 5),
            //         Expanded(
            //           flex: 1,
            //           child: MyCard(
            //             child: Container(
            //               padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: <Widget>[
            //                   Text('钱包'),
            //                   Gaps.vGap8,
            //                   Text('福利， 借钱', style: TextStyle(fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis)
            //                 ],
            //               ),
            //             ),
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0)
                ),
                child: Image.network('https://img.aqsea.com/iBuyBuy/seller/ad/equity_certification.png', width: double.infinity),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                ClickItem(
                  label: '账号安全',
                  value: '',
                  onPressed: () {
                  }
                ),
                ClickItem(
                  label: '帮助中心',
                  value: '',
                  onPressed: () {
                  }
                ),
                ClickItem(
                  label: '关于我们',
                  value: '',
                  showLine: false,
                  onPressed: () {
                  }
                ),
              ]),
            )
          ],
        ),
    );
  }
}