import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:seller/utils/toast.dart';

import 'package:seller/style/base_style.dart';

import 'package:seller/views/dashboard/index_page.dart';
import 'package:seller/views/mine/mine_page.dart';

import 'package:seller/views/home/add_button_page.dart';


class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<Widget> _viewList; //创建视图数组
  int _index = 0; //数组索引，通过改变索引值改变视图
  @override
  void initState() {
    super.initState();
    _viewList = List();
    _viewList
      ..add(IndexPage())
      ..add(MinePage());
  }

  _openNewPage() {
    Navigator.of(context).push(TransparentRoute(
      builder: (context) => AddingButtonPage(),
    ));
  }

  static const double offset = 10.0; // offset为正时，表示往下偏移；offset为负时，表示往上偏移

  /// 按返回两次退出app
  DateTime  _lastTime;
  Future<bool> _isExit() {
    if (_lastTime == null || DateTime.now().difference(_lastTime) > Duration(milliseconds: 2500)) {
      _lastTime = DateTime.now();
      MyToast.show('再按一次退出APP', gravity: 'bottom');
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _isExit,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _openNewPage,
          elevation: 0,
          tooltip: '发布新商品',
          child: Icon(
            Icons.add,
            color: Colors.white,
          )),
        floatingActionButtonLocation:
          // 请一定要加const，否则每次点击bottomNavigationBar，floatingActionButton会重建
          const _CenterDockedFloatingActionButtonLocation(offset),
        //和底栏进行融合
        bottomNavigationBar: BottomAppBar(
          notchMargin: 6,
          color: Colors.white, //底部工具栏的颜色。
          shape: CircularRaisedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _buildBottomItem(_index, 0, 'home', "首页"),
              _buildBottomItem(_index, -1, null, ""),
              _buildBottomItem(_index, 1, 'mine', "我的"),
            ],
          ),
        ),
        body: _viewList[_index],
      ),
    );
  }

  Widget _buildBottomItem(
    int selectIndex, int index, String iconData, String title) {
    //未选中状态的样式
    EdgeInsetsGeometry padding = EdgeInsets.only(top: 8.0);
    var getGradient = LinearGradient(colors: [Color(0xFF999999), Color(0xFF999999)]);
    if (selectIndex == index) {
      iconData = iconData+'_active';
      getGradient = LinearGradient(colors: [Color(0xFF3133F4), Color(0xFFFE4987)]);
    }
    Widget padItem = SizedBox();
    if (iconData != null) {
      padItem = Padding(
        padding: padding,
        child: Container(
          color: Colors.white,
          child: Center(
            // child: Stack(
            //   children: <Widget>[
            //     Positioned(
            //       top: -10,
            //       left: 0,
            //       right: 0,
            //       child: Image.asset('assets/tab/$iconData.png', width: 60.0, height: 60.0),
            //     )
            //   ],
            // ),
            child: Column(
              children: <Widget>[
                Image.asset('assets/tab/$iconData.png', width: 22.0, height: 22.0),
                SizedBox(height: 5),
                GradientText(
                  title,
                  gradient: getGradient,
                  style: TextStyle(
                    fontSize: 11.0,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
    Widget item = Expanded(
      flex: 1,
      child: new GestureDetector(
        onTap: () {
          if (index != _index) {
            setState(() {
              _index = index;
            });
          }
        },
        child: SizedBox(
          height: 62,
          child: padItem,
        ),
      ),
    );
    return item;
  }
}

// 路由动画
class TransparentRoute extends PageRoute<void> {
  TransparentRoute({
    @required this.builder, RouteSettings settings,
  }) : assert(builder != null),
    super(settings: settings, fullscreenDialog: false);

  final WidgetBuilder builder;

  @override
  bool get opaque => false;
  @override
  Color get barrierColor => null;
  @override
  String get barrierLabel => null;
  @override
  bool get maintainState => true;
  @override
  Duration get transitionDuration => Duration.zero;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    final result = builder(context);
    return Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: result,
    );
  }
}

class CircularRaisedRectangle extends NotchedShape {
  const CircularRaisedRectangle();

  @override
  Path getOuterPath(Rect host, Rect guest) {
    if (guest == null || !host.overlaps(guest)) return Path()..addRect(host);

    // The guest's shape is a circle bounded by the guest rectangle.
    // So the guest's radius is half the guest width.
    final double notchRadius = guest.width / 2.0;
    return Path()
      ..moveTo(host.left, host.top)
      ..lineTo(guest.left, host.top)
      ..arcTo(
          Rect.fromLTWH(
            guest.left,
            guest.top,
            notchRadius * 2,
            notchRadius * 2,
          ),
          math.asin(1 - (host.top - guest.top) / notchRadius) + degToRad(180),
          math.acos(1 - (host.top - guest.top) / notchRadius) * 2,
          false)
      ..lineTo(guest.right, host.top)
      ..lineTo(host.right, host.top)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();
  }
}

abstract class _DockedFloatingActionButtonLocation
    extends FloatingActionButtonLocation {
  const _DockedFloatingActionButtonLocation();

  @protected
  double getDockedY(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double contentBottom = scaffoldGeometry.contentBottom;
    final double bottomSheetHeight = scaffoldGeometry.bottomSheetSize.height;
    final double fabHeight = scaffoldGeometry.floatingActionButtonSize.height;
    final double snackBarHeight = scaffoldGeometry.snackBarSize.height;

    double fabY = contentBottom - fabHeight / 2.0;
    if (snackBarHeight > 0.0)
      fabY = math.min(
          fabY,
          contentBottom -
              snackBarHeight -
              fabHeight -
              kFloatingActionButtonMargin);
    if (bottomSheetHeight > 0.0)
      fabY =
          math.min(fabY, contentBottom - bottomSheetHeight - fabHeight / 2.0);

    final double maxFabY = scaffoldGeometry.scaffoldSize.height - fabHeight;
    return math.min(maxFabY, fabY);
  }
}

/// offset值用来控制偏移量。
/// 在bottomNavigationBar中，0坐标为控件左上角，
/// 因此offset为正时，表示往下偏移；offset为负时，表示往上偏移
class _CenterDockedFloatingActionButtonLocation
    extends _DockedFloatingActionButtonLocation {
  const _CenterDockedFloatingActionButtonLocation(this.offset);

  final double offset;

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX = (scaffoldGeometry.scaffoldSize.width -
            scaffoldGeometry.floatingActionButtonSize.width) /
        2.0;
    return Offset(fabX, getDockedY(scaffoldGeometry) + offset);
  }

  @override
  String toString() => 'FloatingActionButtonLocation.centerDocked';
}

num degToRad(num deg) => deg * (math.pi / 180.0);

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
//   @override
//   bool get wantKeepAlive => true;
//   static Color currentThemeColor = ThemeUtils.currentThemeColor;
//   static const double bottomBarHeight = 64.4;

//   var _pageList;
//   var _tabImages;
//   var _appBarTitles = ['工作台', '我的'];
//   int _tabIndex = 0;
//   // var _body;
//   final _pageController = PageController();

//   List<BottomNavigationBarItem> _list;

//   Image getTabImage(path) {
//     return Image.asset(path, width: 20.0, height: 20.0);
//   }

//   @override
//   void initState() {
//     super.initState();
//     initData();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _preCacheImage();
//     });
//   }

//   /// 预先缓存图片
//   _preCacheImage() {
//     precacheImage(AssetImage('assets/tab/home.png'), context);
//     precacheImage(AssetImage('assets/tab/shopcart.png'), context);
//     precacheImage(AssetImage('assets/tab/mine.png'), context);
//   }

//   Image getTabIcon(int curIndex) {
//     if (curIndex == _tabIndex) {
//       return _tabImages[curIndex][1];
//     }
//     return _tabImages[curIndex][0];
//   }

//   LinearGradient getGradient(int curIndex) {
//     print(curIndex);
//     print(_tabIndex);
//     if (curIndex == _tabIndex) {
//       return LinearGradient(colors: [Color(0xFF3133F4), Color(0xFFFE4987)]);
//     }
//     return LinearGradient(colors: [Color(0xFF999999), Color(0xFF999999)]);
//   }
//   getTabTitle(int curIndex) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 5.0),
//       child: GradientText(
//         _appBarTitles[curIndex],
//         gradient: getGradient(curIndex),
//         // gradient: LinearGradient(colors: [Color(0xFF3133F4), Color(0xFFFE4987)]),
//         style: TextStyle(
//           fontSize: 11.0,
//         ),
//       ),
//     );
//   }

//   void initData() {
//     _pageList = [
//       IndexPage(),
//       MinePage(),
//     ];

//     _tabImages = [
//       [
//         // const LoadAssetImage("home/icon_Order_n"),
//         // const LoadAssetImage("home/icon_Order_s"),
//         getTabImage('assets/tab/home.png'),
//         getTabImage('assets/tab/home_active.png'),
//       ],
//       [
//         getTabImage('assets/tab/shopcart.png'),
//         getTabImage('assets/tab/shopcart_active.png'),
//       ],
//     ];

//     _list = List.generate(4, (i) {
//       return BottomNavigationBarItem(
//         icon: _tabImages[i][0],
//         activeIcon: _tabImages[i][1],
//         title: getTabTitle(i),
//         // title: Padding(
//         //   padding: const EdgeInsets.only(top: 5.0),
//         //   child: Text(_appBarTitles[i]),
//         // )
//       );
//     });
//   }

//   /// 按返回两次退出app
//   DateTime  _lastTime;
//   Future<bool> _isExit() {
//     if (_lastTime == null || DateTime.now().difference(_lastTime) > Duration(milliseconds: 2500)) {
//       _lastTime = DateTime.now();
//       MyToast.show('再按一次退出APP', gravity: 'bottom');
//       return Future.value(false);
//     }
//     return Future.value(true);
//   }

//   @mustCallSuper
//   Widget build(BuildContext context) {
//     // _body = IndexedStack(
//     //   children: _pageList,
//     //   index: _tabIndex,
//     // );
//     return WillPopScope(
//       onWillPop: _isExit,
//       child: Scaffold(
//         bottomNavigationBar: BottomNavigationBar(
//           // items: _list,
//           items: <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: getTabIcon(0),
//               title: getTabTitle(0)),
//             BottomNavigationBarItem(
//               icon: getTabIcon(1),
//               title: getTabTitle(1)),
//           ],
//           currentIndex: _tabIndex,
//           selectedFontSize: Dimens.font_sp10,
//           unselectedFontSize: Dimens.font_sp10,
//           backgroundColor: Colors.white,
//           onTap: (index) {
//             if (index == 2) {
//               return;
//             }
//             _pageController.jumpToPage(index);
//             // setState((){
//             //   _tabIndex = index;
//             // });
//           },
//         ),
//         // floatingActionButton: SizedBox(
//         //   width: 56.0,
//         //   height: 40.0,
//         //   child: FloatingActionButton(
//         //     child: Icon(Icons.add, size: Constants.suSetSp(30.0)),
//         //     onPressed: () {},
//         //     mini: true,
//         //     isExtended: false,
//         //   ),
//         // ),
//         // floatingActionButtonLocation: FloatingActionButtonLocation,
//         floatingActionButton: SizedBox(
//           width: 56.0,
//           height: 40.0,
//           child: FloatingActionButton(
//             child: Icon(Icons.add, size: 30.0),
//             tooltip: '发布新商品',
//             foregroundColor: Colors.white,
//             backgroundColor: currentThemeColor,
//             elevation: 0,
//             onPressed: () {
//               print('发布新商品');
//             },
//             mini: false,
//             isExtended: true,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
//           ),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         // body: _body,
//         body: PageView(
//           controller: _pageController,
//           onPageChanged: _onPageChanged,
//           children: _pageList,
//           physics: NeverScrollableScrollPhysics(),  // 禁止滑动
//         ),
//       ),
//     );
//   }

//   void _onPageChanged(int index) {
//     setState((){
//       _tabIndex = index;
//     });
//   }
// }


