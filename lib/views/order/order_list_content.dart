import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:seller/api/api.dart';
import 'package:seller/style/resources.dart';
import 'package:seller/utils/route_util.dart';
import 'package:seller/utils/toast.dart';

import 'package:seller/model/order.dart';

import 'package:seller/model/loading_state.dart';
import 'package:seller/widgets/load_widget.dart';
import 'package:seller/widgets/my_card.dart';
import 'package:seller/widgets/dialogs/other_dialog.dart';

import 'package:seller/widgets/pull/my_refresh_list.dart';

class OrdersListContent extends StatefulWidget {

  OrdersListContent({Key key, this.index}) : super(key: key);

  final index;

  @override
  _OrdersListContentState createState() => _OrdersListContentState();
}

class _OrdersListContentState extends State<OrdersListContent> with AutomaticKeepAliveClientMixin<OrdersListContent> {
  @override
  bool get wantKeepAlive => true;

  Order order;
  List<Trades> _listData = [];
  LoadingState _loadingState = LoadingState.Loading;

  int _pageNo = 1;
  int _pageSize = 10;
  int _maxPage;
  bool _hasMore = false;
  String refund_status = '';

  _fetchList() async {
    String urls = 'trade.page.seller.list.get';
    var res = await httpManager.netFetch(urls, {
      'page_no': 1,
      'page_size': 10,
      'trade_id': '',
      'q': '',
      'outer_trade_id': '',
      'tab_code': widget.index,
      'trade_model': '',
      'start_consign_time': '',
      'end_consign_time': '',
      'start_endtime': '',
      'end_endtime': '',
      'own_delivery': -1,
      'page_size': _pageSize,
      'page_no': _pageNo,
    }, null, null);
    var response = json.decode(res.toString());
    order = Order.fromJson(response);
    if (order.data != null) {
      if (mounted) {
        if (_pageNo == 1) {
          setState(() {
            _listData = order.data.trades;
            _loadingState = LoadingState.NoMore;
            _maxPage = order.data.totalPage;
          });
        } else {
          setState(() {
            _listData.addAll(order.data.trades);
          });
        }
        if (_pageNo >= _maxPage) {
          setState(() {
            _hasMore = false;
          });
        } else {
          setState(() {
            _hasMore = true;
          });
        }
        print(_hasMore);
      }
      }
  }

  @override
  void initState() {
    super.initState();
    _fetchList();
  }


  @override
  void dispose() {
    super.dispose();
  }

  Future _onRefresh() async {
    _pageNo = 1;
    _fetchList();
    return null;
  }

  Future _loadMore() async {
    if (_pageNo >= _maxPage) {
      setState(() {
        _hasMore = false;
      });
      return;
    }
    _pageNo++;
    _fetchList();
  }

  /// 设置商家备注
  _setMark(value, trade_id) async {
    String urls = 'trade.page.seller.remark.modify';
    var res = await httpManager.netFetch(urls, {
      'seller_memo': value,
      'trade_id': trade_id
    }, null, 'PUT');
    if (res['data']['is_success'] == true) {
      MyToast.show('ibuybuy：修改备注成功', gravity: 'bottom');
    } else {
      MyToast.show('ibuybuy：${res['data']['msg']}', gravity: 'bottom');
    }
  }

  pressedes() {
    print(1212);
  }

  _renderItem(item, index) {
    Trades model = item;
    return  Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 10),
        child: MyCard(
          child: InkWell(
            onTap: () {
              RouteUtil.routeToOrderDetailPage(context, model.tradeId);
            },
            child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                height: 36,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('买家：${model.sellerNick}', style: TextStyles.textDark14,),
                    Row(
                      children: <Widget>[
                        Text(model.status.value, style: TextStyles.textGray12),
                        Gaps.hGap4,
                        // Container(
                        //   padding: EdgeInsets.all(3),
                        //   decoration: BoxDecoration(
                        //     color: Color(0xFFF5F5F5),
                        //     borderRadius: BorderRadius.circular(20)
                        //   ),
                        //   child: Icon(
                        //     Icons.delete,
                        //     size: 18,
                        //     color: Colors.grey,
                        //   ),
                        // )
                      ],
                    )
                  ],
                ),
              ),
              Gaps.line,
              model.orders.length == 1 ? Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(4),
                        //   child: Image.network(model.orders[0].picUrl, width: 80, height: 80),
                        // ),
                        Image.network(model.orders[0].picUrl, width: 80, height: 80),
                        Gaps.hGap12,
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text(model.orders[0].title, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyles.textDark14),
                              ),
                              // Text(model.orders[0].title, maxLines: 2, overflow: TextOverflow.ellipsis,),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Row(
                                  children: <Widget>[
                                    Text('￥', style: TextStyle(fontSize: 12)),
                                    Text('${model.totalFee}')
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ) : Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                height: 110,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: model.orders.length,
                        itemBuilder: (_, index) {
                          var modelChild = model.orders[index];
                          return Container(
                            margin: EdgeInsets.only(right: 5),
                            child: Image.network(modelChild.picUrl, width: 80, height: 80),
                          );
                        },
                      ),
                    ),
                    Opacity(
                      opacity: 0.5,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(

                        ),
                        constraints: BoxConstraints(
                          minWidth: 70
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text('￥', style: TextStyle(fontSize: 10),),
                                Text('${model.totalFee}'),
                              ],
                            ),
                            Text('共13件', style: TextStyles.textGray12)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                height: 30,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Gaps.empty,
                    ),
                    ItemButton(
                      label: '商家备注',
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return TextareaDialog(
                              title: "商家备注",
                              onPressed: (value){
                                _setMark(value, model.tradeId);
                              },
                            );
                          });
                      }
                    ),
                    widget.index == 'wait_consign' ?  Gaps.hGap10 : Container(),
                    widget.index == 'wait_consign' ? ItemButton(
                      label: '去发货',
                      mainColor: Color(0xFFE93B3D),
                      onPressed: () {}
                    ): Container()
                  ],
                ),
              ),
              Gaps.vGap16
            ],
          ),
          )
        )
      );
  }

  _showDialog(index, itemId) {
    return showDialog(
      // 传入 context
      context: context,
      // 构建 Dialog 的视图
      builder: (_) => Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text('操作', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, decoration: TextDecoration.none, color: Colors.black)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 15, right: 20, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.grey[400],
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(100)
                          ),
                          onPressed: () {
                            // 关闭 Dialog
                            Navigator.pop(_); 
                          },
                          child: Text('取消关注')
                        ),
                      ],
                    )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return  order == null ? LoadingWidget(_loadingState) : DeerListView(
      itemCount: _listData.length,
      stateType: 'order',
      onRefresh: _onRefresh,
      loadMore: _loadMore,
      hasMore: _hasMore,
      itemBuilder: (_, index){
        return Container(
          child: _renderItem(_listData[index], index),
        );
      }
    );
  }
}

class ItemButton extends StatelessWidget {

  final Widget child;
  final Color background;
  final Color mainColor;
  final bool enabled;
  final String label;
  @required
  final VoidCallback onPressed;

  const ItemButton({
    this.child,
    this.onPressed,
    this.background,
    this.mainColor,
    this.enabled = true,
    this.label,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 82,
      child: OutlineButton(
        padding: EdgeInsets.only(
          left: 0,
          right: 0,
          top: 5,
          bottom: 5
        ),
        borderSide: BorderSide(width: 0.5, color: mainColor ?? Colours.text_gray),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(55),
        ),
        onPressed: onPressed,
        color: mainColor,
        child: Text(label, style: TextStyle(fontSize: 12, color: mainColor ?? Colors.black)),
      ),
    );
  }
}