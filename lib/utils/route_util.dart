import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:seller/utils/local_storage.dart';
import 'package:seller/api/interceptors/token.dart';
import 'package:seller/api/user_dao.dart';

import 'package:seller/views/home/home_page.dart';
import 'package:seller/views/login/login_page.dart';
import 'package:seller/views/goods/goods_list.dart';
import 'package:seller/views/refund/refund_list.dart';
import 'package:seller/views/order/order_list.dart';
import 'package:seller/views/order/order_details.dart';
import 'package:seller/views/message/message_page.dart';
import 'package:seller/views/message/message_list.dart';
import 'package:seller/views/settingpage/setting.dart';
import 'package:seller/views/settingpage/message_setting.dart';
import 'package:seller/views/goods/goods_edit_page.dart';
import 'package:seller/views/goods/scan_page.dart';
import 'package:seller/views/goods/scan_result_page.dart';
import 'package:seller/widgets/webview_page.dart';
import 'package:seller/views/store/store_manage.dart';
import 'package:seller/views/manage/receiving_warehouse_manage.dart';
import 'package:seller/views/manage/return_warehouse_manage.dart';


import 'package:seller/views/store/store_decoration.dart';
import 'package:seller/views/store/store_theme_detail.dart';
import 'package:seller/views/store/store_theme_image.dart';

import 'package:seller/views/invite/invite_custom.dart';


class RouteUtil {
  /// 商品管理页面
  static void routeToGoodsList(BuildContext context) {
    Navigator.of(context).push(
      FadeRouteBuilder(page: GoodsList())
    );
  }
  /// 退款管理页面
  static void routeToRefundList(BuildContext context) {
    Navigator.of(context).push(
      FadeRouteBuilder(page: RefundsList())
    );
  }
  /// 订单页面
  static void routeToOrderList(BuildContext context, {int type}) {
    Navigator.of(context).push(
      FadeRouteBuilder(page: OrdersList(type: type))
    );
  }
  /// 订单详情页面
  static void routeToOrderDetailPage(BuildContext context, id) {
    Navigator.of(context).push(
      FadeRouteBuilder(page: OrderDetail(id: id))
    );
  }
  static void routeToHomeCloseCurrentPage(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context){
          return HomePage();
        },
      ), (route) => route == null
    );
  }
  /// 扫码页面
  static void routeToScanPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context){
          return ScanPage();
        }
      )
    );
    // Navigator.of(context).push(
    //   FadeRouteBuilder(page: ScanPage())
    // );
  }
  /// 扫码结果页面
  static void routeToScanResultPage(BuildContext context, {String data}) {
    Navigator.of(context).push(
      FadeRouteBuilder(page: ScanResultPage(
        data: data,
      ))
    );
  }
  /// 去web页面
  static void pushWeb(BuildContext context, {String title, String titleId, String url, bool isHome: false}) {
    Navigator.push(context,
    new CupertinoPageRoute<void>( builder: (ctx) => new WebViewPage(
      title: title,
      url: url,
    )));
  }
  /// 编辑商品页面
  static void routeToGoodsEditPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context){
          return GoodsEditPage();
        },
      )
    );
  }
  /// 编辑商品页面
  static void routeToGoodsEditPage1(BuildContext context) {
    Navigator.of(context).push(
      FadeRouteBuilder(page: GoodsEditPage())
    );
  }
  /// 消息通知主页面
  static void routeToMessageSettingPage(BuildContext context) {
    Navigator.of(context).push(
      FadeRouteBuilder(page: MessageSetting())
    );
  }
  /// 去设置主页面
  static void routeToSettingPage(BuildContext context) {
    Navigator.of(context).push(
      FadeRouteBuilder(page: Setting())
    );
  }
  /// 去消息主页面
  static void routeToMessagePage(BuildContext context) {
    Navigator.of(context).push(
      FadeRouteBuilder(page: MessagePage())
    );
  }
  /// 区消息列表页面
  static void routeToMessageListPage(BuildContext context, {String title, String pageId}) {
    Navigator.of(context).push(
      FadeRouteBuilder(page: MessageListPage(
        title: title,
        pageId: pageId
      ))
    );
  }
  /// 店铺设置页面
  static void routeToStoreManagePage(BuildContext context) {
    Navigator.of(context).push(
      FadeRouteBuilder(page: StoreManage())
    );
  }
  static void routeToStoreThemeDetail(BuildContext context) {
    Navigator.of(context).push(
      FadeRouteBuilder(page: StoreThemeDetail())
    );
  }
  static void routeToStoreThemeImage(BuildContext context) {
    Navigator.of(context).push(
      FadeRouteBuilder(page: StoreThemeImage())
    );
  }
  /// 邀请页面
  static void routeToInviteCustom(BuildContext context) {
    Navigator.of(context).push(
      FadeRouteBuilder(page: InviteCustom())
    );
  }
  /// 收货仓管理页面
  static void routeToReceivingWarehouseManage(BuildContext context, {int type}) {
    Navigator.of(context).push(
      FadeRouteBuilder(page: ReceivingWarehouseManage(
        type: type
      ))
    );
  }
  /// 退货仓管理页面
  static void routeToReturnWarehouseManage(BuildContext context) {
    Navigator.of(context).push(
      FadeRouteBuilder(page: ReturnWarehouseManage())
    );
  }
  /// 店铺仓管理页面
  static void routeToStoreDecoration(BuildContext context) {
    Navigator.of(context).push(
      FadeRouteBuilder(page: StoreDecoration())
    );
  }
  /// 登出
  static void routeSignOut(BuildContext context) {
    // LocalStorage.remove('user');
    // LocalStorage.remove('token');
    // final TokenInterceptors _tokenInterceptors = new TokenInterceptors();
    // _tokenInterceptors.clearAuthorization();
    UserDao.clearAll();
    // Navigator.pushReplacementNamed(context, 'login');
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context){
          return LoginPage(isClose: false);
        },
      ), (route) => route == null
    );
  }

  /// 根据参数去不同的页面  
  static void goSwitchPage(BuildContext context, action) {
    var type = action['type'], url = action['url'];
    switch (type) {
      // case 'goods':
      //   routeToGoodsPage(context, url);  
      //   break;
      // case 'coupon':
      //   routeToCouponListPage(context);  
      //   break;
      // case 'trade':
      //   routeToOrderDetailPage(context, url);  
      //   break;
      // case 'activity':
      //   routeToActivityPage(context, url);  
      //   break;
      default:
    }
  }
  /// 返回
  static void goBack(BuildContext context) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }
  /// 带参数返回
  static void goBackWithParams(BuildContext context, result) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context, result);
  }
  static pushResult(BuildContext context, Widget scene, Function(Object) function) {
    Navigator.of(context).push(
      FadeRouteBuilder(page: scene)
    ).then((result){
      // 页面返回result为null
      if (result == null){
        return;
      }
      function(result);
    }).catchError((error) {
      print("$error");
    });
  }
}

/// 路由动画 左到右
class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRouteBuilder({@required this.page})
  : super(
    pageBuilder: (context, animation1, animation2) => page,
    transitionsBuilder : (context, animation1, animation2, child) {
      // return FadeTransition(opacity: animation1, child: child);
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(1.0, 0.0),
          end: Offset(0.0, 0.0)
        ).animate(CurvedAnimation(
          parent: animation1,
          curve: Curves.fastOutSlowIn
        )),
        child: child,
      );
    }
  );
}

/// 路由动画 渐变过度
class CircleCustomRoute<T> extends MaterialPageRoute<T> {
  // final Widget page;
  // CircleCustomRoute({@required this.page}) : super(
  //   pageBui
  // );
  CircleCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    return new FadeTransition(opacity: animation, child: child);
  }
}