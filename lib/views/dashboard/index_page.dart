import 'package:flutter/material.dart';
import 'package:seller/style/resources.dart';
import 'package:seller/utils/route_util.dart';
import 'package:seller/widgets/load_image.dart';
import 'package:seller/widgets/my_card.dart';
import 'package:seller/utils/image_utils.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  Future<Null> _pullToRefresh() async {
    print('下拉刷新');
    // curPage = 1;
    // getPageData();
    // getNewsList(false);
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFf5f5f5),
      // appBar: AppBar(
      //   title: Text('iBuyBuy'),
      //   centerTitle: true,
      //   actions: <Widget>[
      //     InkWell(
      //       onTap: () {
      //       },
      //       child: Container(
      //         width: 60,
      //         alignment: Alignment.center,
      //         child: Icon(
      //           Icons.crop_free,
      //           color: Colors.white,
      //         ),
      //       ),
      //     )
      //   ],
      // ),
      body: RefreshIndicator(
        onRefresh: _pullToRefresh,
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: _sliverBuilder(),
        ),
      )
    );
  }

  List<Widget> _sliverBuilder() {
    return <Widget>[
      SliverAppBar(
        leading: Gaps.empty,
        backgroundColor: Color(0xFF5D93F7),
        elevation: 0,
        centerTitle: true,
        expandedHeight: 120.0,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          background: const LoadAssetImage("statistic/statistic_bg",
            width: double.infinity,
            height: 120.0,
            fit: BoxFit.fill,
          ),
          titlePadding: const EdgeInsetsDirectional.only(start: 16.0, bottom: 14.0),
          title: const Text('统计'),
        ),
      ),
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
          DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ImageUtils.getAssetImage("statistic/statistic_bg1"),
                fit: BoxFit.fill
              )
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: <Widget>[
                  MyCard(
                    child: Container(
                      alignment: Alignment.center,
                      height: 80.0,
                      child: Row(
                        children: <Widget>[
                          _StatisticsTab(title: '待发货的订单', content: '10', onPressed: () {RouteUtil.routeToOrderList(context, type: 2);}),
                          _StatisticsTab(title: '待处理的退款单', content: '2', onPressed: () {RouteUtil.routeToRefundList(context);}),
                          // _StatisticsTab('待处理的退款单', '2',  () {RouteUtil.routeToOrderList(context)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ), 100.0
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        sliver: SliverGrid.count(
          crossAxisCount: 4,
          childAspectRatio: 1.0,
          children: <Widget>[
            _StatisticsItems(title: '商品管理', content: '1', img: 'goods_manage', onPressed: () {RouteUtil.routeToGoodsList(context);}),
            _StatisticsItems(title: '店铺管理', content: '1', img: 'shop_manage', onPressed: () {RouteUtil.routeToStoreManagePage(context);},),
            _StatisticsItems(title: '订单管理', content: '1', img: 'order_manage', onPressed: () {RouteUtil.routeToOrderList(context);}),
            _StatisticsItems(title: '客户管理', content: '1', img: 'custom_manage', onPressed: () {RouteUtil.routeToInviteCustom(context);}),
            _StatisticsItems(title: '发货仓管理', content: '1', img: 'warehouse_manage', onPressed: () {RouteUtil.routeToReceivingWarehouseManage(context, type: 1);}),
            _StatisticsItems(title: '退货仓管理', content: '1', img: 'warehouse_manage', onPressed: () {RouteUtil.routeToReceivingWarehouseManage(context, type: 2);}),
            _StatisticsItems(title: '采购清单', content: '1', img: 'purchase_list'),
            _StatisticsItems(title: '退款售后', content: '1', img: 'refund_list', onPressed: () {RouteUtil.routeToRefundList(context);}),
          ],
        ),
      ),
    ];
  }
}


class _StatisticsTab extends StatelessWidget {
  const _StatisticsTab({Key key, this.title, this.content, this.onPressed}) : super(key: key);

  final String title;
  final String content;
  @required
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Gaps.vGap4,
            Text(title, style: TextStyles.textDark14),
            Gaps.vGap8,
            Text(content, style: const TextStyle(fontSize: Dimens.font_sp18, color: Colours.text_dark)),
          ],
        ),
      )
    );
  }
}

class _StatisticsItems extends StatelessWidget {
  const _StatisticsItems({
    Key key,
    this.title,
    this.content,
    this.img,
    this.onPressed,
  }) : super(key: key);

  final String title;
  final String content;
  final String img;
  @required
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onPressed,
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/order/$img.png', width: 25, height: 25),
                  SizedBox(height: 5),
                  Text(title, style: TextStyle(fontSize: 12))
                ],
              ),
            ),
            // Positioned(
            //   right: 26,
            //   top: 16,
            //   child: Container(
            //     alignment: Alignment.center,
            //     width: 16,
            //     height: 16,
            //     decoration: BoxDecoration(
            //       image: DecorationImage(image: NetworkImage('https://img.aqsea.com/iBuyBuy/wechat/icon/num_tips.png'), fit: BoxFit.cover)
            //     ),
            //     child: Text('${this.content}', style: TextStyle(fontSize: 12)),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final double height;
  SliverAppBarDelegate(this.widget, this.height);

  // minHeight 和 maxHeight 的值设置为相同时，header就不会收缩了
  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return true;
  }
}