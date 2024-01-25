import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:seller/api/api.dart';
import 'package:seller/style/resources.dart';

import 'package:seller/model/refund.dart';

import 'package:seller/model/loading_state.dart';
import 'package:seller/widgets/load_widget.dart';

import 'package:seller/widgets/pull/my_refresh_list.dart';

class RefundsListContent extends StatefulWidget {

  RefundsListContent({Key key, this.index}) : super(key: key);

  final index;

  @override
  _RefundsListContentState createState() => _RefundsListContentState();
}

class _RefundsListContentState extends State<RefundsListContent> with AutomaticKeepAliveClientMixin<RefundsListContent> {
  @override
  bool get wantKeepAlive => true;

  Refund refund;
  List<Refunds> _listData = [];
  LoadingState _loadingState = LoadingState.Loading;

  int _pageNo = 1;
  int _maxPage;
  bool _hasMore = false;
  String refund_status = '';

  _fetchList() async {
    String urls = 'refund.page.receive.list.get';
    var res = await httpManager.netFetch(urls, {
      'page_no': 1,
      'page_size': 10,
      'refund_id': '',
      'refund_status': this.refund_status,
      'q': '',
      'start_create_time': '',
      'end_create_time': '',
      'refund_type': '',
    }, null, null);
    var response = json.decode(res.toString());
    refund = Refund.fromJson(response);
    print(refund);
    if (refund.data != null) {
      if (_pageNo == 1) {
        setState(() {
          _listData = refund.data.refunds;
          _loadingState = LoadingState.NoMore;
          _maxPage = refund.data.totalPage;
        });
      } else {
        setState(() {
          _listData.addAll(refund.data.refunds);
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

  @override
  void initState() {
    if (widget.index == 1) {
      refund_status = 'recreated';
    } else {
      refund_status = '';
    }
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
      print('到底了');
      setState(() {
        _hasMore = false;
      });
      return;
    }
    _pageNo++;
    _fetchList();
  }

  _cancelCollect(itemId, index)async {
    // String urls = 'item.page.favorite.delete';
    // var res = await httpManager.netFetch(urls, {
    //   'item_id': itemId,
    // }, null, new Options(method: 'DELETE'));
    // print(res);
    // if (res['data']['is_success'] == true) {
    //   _listData.removeAt(index);
    //   setState(() {
    //     _listData = _listData;
    //   });
    //   MyToast.show('取消成功');
    // } else {
    //   MyToast.show(res['data']['msg']);
    // }
  }

  _renderItem(item, index) {
    Refunds model = item;
    return Material(
      child: Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            height: 36,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('订单单号： ${model.orderId}', style: TextStyles.textGray12,),
                Row(
                  children: <Widget>[
                    Text('退货', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))
                  ],
                )
              ],
            ),
          ),
          Gaps.line,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            // alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(model.picUrl, width: 60, height: 60),
                    ),
                    Gaps.hGap8,
                    Expanded(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 32,
                          child: Text(model.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyles.textDark12),
                        ),
                        Row(
                          children: <Widget>[
                            Text('申请数量：', style: TextStyle(fontSize: 10, color: Color(0xFF999999)),),
                            Gaps.hGap4,
                            Text('${1}', style: TextStyle(fontSize: 10),)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('退款金额：', style: TextStyle(fontSize: 10, color: Color(0xFF999999)),),
                            Gaps.hGap4,
                            Text('￥${model.price}', style: TextStyle(fontSize: 10, color: Colors.red),)
                          ],
                        )
                      ],
                    ),
                    )
                  ],
                ),
                Gaps.vGap12,
                InkWell(
                  onTap: () {
                    print(1);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(6)
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(model.refundType.value, style: TextStyles.textDark12,),
                        Gaps.hGap10,
                        Text(model.refundStatus.value, style: TextStyles.textGray12,),
                        Expanded(
                          child: Gaps.empty,
                        ),
                        Image.asset('assets/images/icon/icon_arrow_right.png', width: 16, height: 16,)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
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
                            _cancelCollect(itemId, index);
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
    return  refund == null ? LoadingWidget(_loadingState) : DeerListView(
      itemCount: _listData.length,
      stateType: 'normal',
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