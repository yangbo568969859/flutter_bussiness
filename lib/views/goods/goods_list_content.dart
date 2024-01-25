import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:seller/api/api.dart';
import 'package:seller/model/goods.dart';
import 'package:seller/model/loading_state.dart';
import 'package:seller/utils/route_util.dart';
import 'package:seller/widgets/load_widget.dart';
import 'package:seller/widgets/pull/my_refresh_list.dart';
import 'package:seller/widgets/dialogs/tip_dialog.dart';
import 'package:seller/style/resources.dart';
import 'package:seller/utils/toast.dart';
import 'package:seller/widgets/load_image.dart';

class GoodsListContent extends StatefulWidget{

  GoodsListContent({
    Key key,
    this.index,
    this.isEdit = false,
  }) : super(key: key);

  final index;
  final isEdit;

  @override
  _GoodsListContentState createState() => _GoodsListContentState();
}


class _GoodsListContentState extends State<GoodsListContent> with AutomaticKeepAliveClientMixin<GoodsListContent> {
  @override
  bool get wantKeepAlive => true;

  Goods goods;
  List<Items> _listData = [];
  LoadingState _loadingState = LoadingState.Loading;
  int _pageNo = 1;
  int _maxPage;
  bool _hasMore = false;
  bool _isAllSelected = false;

  var approve_status = 1;

  _fetchList() async {
    if (widget.index == 0) {
      approve_status = 1;
    } else if (widget.index == 1) {
      approve_status = 0;
    } else if (widget.index == 2) {
      approve_status = -1;
    }
    // print('初始化数据');
    String urls = 'item.seller.list.get';
    var res = await httpManager.netFetch(urls, {
      'page_no': 1,
      'page_size': 10,
      'item_id': '',
      'cat_path': '',
      'trade_model': '',
      'q': '',
      'brand_id': '',
      'item_no': '',
      'approve_status': approve_status,
      'is_draft': 0,
    }, null, null);
    var response = json.decode(res.toString());
    goods = Goods.fromJson(response);
    if (goods.data != null) {
      if (_pageNo == 1) {
        setState(() {
          _listData = goods.data.items;
          _loadingState = LoadingState.NoMore;
          _maxPage = goods.data.totalPage;
        });
      } else {
        setState(() {
          _listData.addAll(goods.data.items);
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
    }
  }

  // 下架
  _delisting(item_ids, index) async {
    String urls = 'item.page.seller.items.delisting';
    var res = await httpManager.netFetch(urls, {
      'item_ids': item_ids,
    }, null, 'PUT');
    if (res['data']['is_success'] == true) {
      MyToast.show('ibuybuy：下架成功', gravity: 'bottom');
      _listData.removeAt(index);
      setState(() {
        _listData = _listData;
      });
    } else {
      MyToast.show('ibuybuy：下架失败', gravity: 'bottom');
    }
  }
  // 批量下架
  _batchDelisting() async {
    var selectedArr = [];
    _listData.forEach((item) {
      if (item.selected == true) {
        selectedArr.add(item.itemId);
      }
    });
    print(selectedArr);
    String urls = 'item.page.seller.items.delisting';
    var res = await httpManager.netFetch(urls, {
      'item_ids': selectedArr,
    }, null, 'PUT');
    print(res);
  }
  // 上架
  _listing(item_ids, index) async {
    String urls = 'item.page.seller.items.listing';
    var res = await httpManager.netFetch(urls, {
      'item_ids': item_ids,
    }, null, 'PUT');
    print(res);
    if (res['data']['is_success'] == true) {
      MyToast.show('ibuybuy：上架成功', gravity: 'bottom');
      _listData.removeAt(index);
      setState(() {
        _listData = _listData;
      });
    } else {
      MyToast.show('ibuybuy：上架失败', gravity: 'bottom');
    }
  }
  _batchListing() async {
    var selectedArr = [];
    _listData.forEach((item) {
      if (item.selected == true) {
        selectedArr.add(item.itemId);
      }
    });
    String urls = 'item.page.seller.items.listing';
    var res = await httpManager.netFetch(urls, {
      'item_ids': selectedArr,
    }, null, 'PUT');
    if (res['data']['is_success'] == true) {
      MyToast.show('ibuybuy：批量上架成功', gravity: 'bottom');
      removeAt(selectedArr);
      setState(() {
        _listData = _listData;
      });
    } else {
      MyToast.show('ibuybuy：批量上架失败', gravity: 'bottom');
    }
  }

  // _deleteGoods
  _deleteGoods(item_ids, index) async {
    String urls = 'item.page.delete';
    var res = await httpManager.netFetch(urls, {
      'item_ids': item_ids,
    }, null, 'DELETE');
    print(res);
    if (res['data']['is_success'] == true) {
      MyToast.show('ibuybuy：删除成功', gravity: 'bottom');
      _listData.removeAt(index);
      setState(() {
        _listData = _listData;
      });
    } else {
      MyToast.show('ibuybuy：${res['data']['msg']}', gravity: 'bottom');
    }
  }

  removeAt(list) {
    _listData.forEach((item) {
      list.forEach((li) {
        if (item.itemId == li) {
          print(item.itemId);
          // _listData.remove(item);
        }
      });
    });
  }

  allSelected() {
    setState(() {
      _isAllSelected = !_isAllSelected; 
    });
    for(var item in _listData) {
      item.selected=_isAllSelected;
    }
  }

  /// 点击列表子商品选中
  _childSelected(itemId) {
    for(var item in _listData) {
      if (item.itemId == itemId) {
        if (item.selected == true) {
          item.selected = false;
        } else {
          item.selected = true;
        }
      }
    }
    setState(() {
      _listData = _listData;
    });
    // _listData.forEach((items) {
    //   if (items.itemId == itemId) {
    //     if (items.selected == true) {
    //       items.selected = false;
    //     } else {
    //       items.selected = true;
    //     }
    //   }
    // });
    // setState(() {
    //   _listData = _listData;
    // });
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

  _renderItem(item, index) {
    Items model = item;
    return InkWell(
      onLongPress: () {
        // _showDialog(index, model.itemId);
      },
      onTap: () {
        RouteUtil.routeToGoodsEditPage1(context);
      },
      child: Container(
        // height: 164,
        // padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFEEEEEE),
              width: 0.5
            )
          )
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 138,
              padding: EdgeInsets.fromLTRB(0, 14, 14, 14),
              // padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      _childSelected(model.itemId);
                    },
                    child: Offstage(
                      offstage: !widget.isEdit,
                      child: Container(
                        margin: EdgeInsets.only(left: 14),
                        width: 30,
                        alignment: Alignment.center,
                        child: LoadAssetImage(model.selected ? "icon/selectedv3@2x" : "icon/no-selectedv3@2x", width: 20.0, height: 20.0, fit: BoxFit.cover,),
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Gaps.hGap12,
                        Image.network(model.picUrl, width: 80, height: 80)
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(model.brandName,maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyles.textBoldDark14),
                        Text(model.title,maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyles.textDark12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text('市场价', style: TextStyle(fontSize: 12, color: Color(0xFF787878))),
                                Gaps.hGap4,
                                Text('￥${model.retailPrice}', style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('零售价', style: TextStyle(fontSize: 12, color: Color(0xFF787878))),
                                Gaps.hGap4,
                                Text('￥${model.price}', style: TextStyle(fontSize: 12, color: Color(0xFF3233F3))),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text('库存', style: TextStyle(fontSize: 12, color: Color(0xFF787878))),
                                Gaps.hGap4,
                                Text('${model.num}', style: TextStyle(fontSize: 12, color: Color(0xFF787878))),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('${model.modified}', style: TextStyle(fontSize: 12, color: Color(0xFF787878))),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 36,
              color: Color(0xFFF7F7F7),
              alignment: Alignment.centerRight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(flex: 1,child: Container()),
                  Offstage(
                    offstage: approve_status == 0,
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            showTipDialog(
                              context,
                              content: '是否下架商品？',
                              success: () {
                                _delisting([model.itemId], index);
                              },
                            );
                          },
                          child: Container(
                            width: 70,
                            alignment: Alignment.center,
                            child: Text('下架', style: TextStyle(fontSize: 13)),
                          ),
                        ),
                        Container(padding: EdgeInsets.symmetric(vertical: 8), child: VerticalDivider(color: Colors.grey)),
                      ],
                    )
                  ),
                  Offstage(
                    offstage: approve_status == 1,
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            _listing([model.itemId], index);
                          },
                          child: Container(
                            width: 70,
                            alignment: Alignment.center,
                            child: Text('上架', style: TextStyle(fontSize: 13)),
                          ),
                        ),
                        Container(padding: EdgeInsets.symmetric(vertical: 8), child: VerticalDivider(color: Colors.grey)),
                      ],
                    ),
                  ),
                  Offstage(
                    offstage: approve_status == 0,
                    child: InkWell(
                      onTap: () {
                      },
                      child: Container(
                        width: 70,
                        alignment: Alignment.center,
                        child: Text('分享', style: TextStyle(fontSize: 13)),
                      ),
                    ),
                  ),
                  // InkWell(
                  //   child: Container(
                  //     width: 70,
                  //     alignment: Alignment.center,
                  //     child: Text('分享', style: TextStyle(fontSize: 13)),
                  //   ),
                  // ),
                  Offstage(
                    offstage: approve_status == -1 || approve_status == 1,
                    child: InkWell(
                      onTap: () {
                        showTipDialog(
                          context,
                          content: '是否删除商品？',
                          success: () {
                            _deleteGoods(model.itemId, index);
                          },
                        );
                      },
                      child: Container(
                        width: 70,
                        alignment: Alignment.center,
                        child: Text('删除', style: TextStyle(fontSize: 13)),
                      ),
                    ),
                  ),
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
    return goods == null ? LoadingWidget(_loadingState) : Stack(
      children: <Widget>[
        DeerListView(
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
        ),
        Offstage(
          offstage: !widget.isEdit,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colours.bg_gray, width: 0.6)
                )
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: allSelected,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: <Widget>[
                            LoadAssetImage(_isAllSelected ? "icon/selectedv3@2x" : "icon/no-selectedv3@2x", width: 20.0, height: 20.0, fit: BoxFit.cover,),
                            Gaps.hGap8,
                            Text('全选', style: TextStyle(fontSize: 13))
                          ],
                        ),
                      ),
                    )
                  ),
                  Offstage(
                    offstage: approve_status != 1,
                    child: Container(
                      width: 100,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)
                        ),
                        color: Color(0xFF3233F3),
                        textColor: Colors.white,
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          // child: Text('正在使用'),
                          child: Text('下架'),
                        ),
                        onPressed: _batchDelisting,
                      ),
                    ),
                  ),
                  Offstage(
                    offstage: approve_status != 0,
                    child: Container(
                      width: 100,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)
                        ),
                        color: Color(0xFF3233F3),
                        textColor: Colors.white,
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          // child: Text('正在使用'),
                          child: Text('上架'),
                        ),
                        onPressed: _batchListing,
                      ),
                    ),
                  ),
                  Offstage(
                    offstage: approve_status != -1,
                    child: Container(
                      width: 100,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)
                        ),
                        color: Color(0xFF3233F3),
                        textColor: Colors.white,
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          // child: Text('正在使用'),
                          child: Text('删除'),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ),
      ],
    );
  }
}