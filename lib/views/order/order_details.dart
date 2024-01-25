import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seller/api/api.dart';

import 'package:seller/model/loading_state.dart';
import 'package:seller/model/order.dart';
import 'package:seller/style/resources.dart';

import 'package:seller/utils/toast.dart';

import 'package:seller/widgets/my_card.dart';
import 'package:seller/widgets/load_image.dart';
import 'package:seller/widgets/load_widget.dart';


class OrderDetail extends StatefulWidget {
  final id;

  OrderDetail({@required this.id});

  @override
  _OrderDetailState createState() => _OrderDetailState(id: this.id);
}

class _OrderDetailState extends State<OrderDetail> {
  final id;
  OrderDetails orderDetails;
  Trade _tradeData;
  LoadingState _loadingState = LoadingState.Loading;
  // TradeStatus _obj;
  _OrderDetailState({@required this.id});

  String tips1 = '';
  String tips2 = 'order/icon-color-wait_pay';
  String tips3 = '';

  _fetchData() async {
    print('初始化数据');
    String urls = 'trade.page.manager.detail.get';
    var res = await httpManager.netFetch(urls, {
      'trade_id': id,
    }, null, null);
    var response = json.decode(res.toString());
    orderDetails = OrderDetails.fromJson(response);
    if (orderDetails.data != null) {
      setState(() {
        _tradeData = orderDetails.data.trade;
        _loadingState = LoadingState.NoMore;
      });
      switch (_tradeData.status.key) {
        case 'wait_buyer_pay':
            setState(() {
              tips1 = '待付款';
              tips2 = 'order/icon-color-wait_pay';
            });
           
          break;
        case 'wait_seller_send_goods':
            tips1 = '待发货';
            tips2 = 'order/icon-color-wait_send';
            tips3 = '订单还未发货，请耐心等待哦!';
          break; 
        case 'seller_consigned_part':
            tips1 = '待发货';
            tips2 = 'order/icon-color-wait_send';
            tips3 = '订单部分商品已发货，剩余商品会尽快发出的哦!';
          break;
        case 'wait_buyer_confirm_goods':
            tips1 = '待收货';
            tips2 = 'order/icon-color-wait_take';
            tips3 = '订单已发货，等待确认收货!';
          break;
        case 'trade_finished':
            tips1 = '交易成功';
            tips3 = '订单已完成，谢谢您的惠顾!';
          break;
        case 'trade_closed_automatical':
            tips1 = '交易关闭';
            tips3 = '订单超时关闭';
          break;
        case 'trade_colsed_by_user':
            tips1 = '交易关闭';
            tips3 = _tradeData.markDesc;
          break;
        default:
          break;
      }
    }
  }


  @override
  void initState() {
    super.initState();
    _fetchData();
  }
  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        title: Text('订单详情', style: TextStyle(fontSize: 18)),
        elevation: 0,
        centerTitle: true,
      ),
      body: _tradeData == null ? LoadingWidget(_loadingState) : Stack(
        children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Gaps.vGap10,
                    MyCard(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                LoadAssetImage(tips2, width: 20.0, height: 20.0),
                                SizedBox(width: 10),
                                Text(tips1),
                              ],
                            ),
                            Gaps.vGap10,
                            Text(tips3 ?? '', style: TextStyles.textGray12,)
                          ],
                        ),
                      )
                    ),
                    Gaps.vGap10,
                    MyCard(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        child: Row(
                          children: <Widget>[
                            LoadAssetImage('order/icon_remarks', width: 20.0, height: 20.0),
                            Gaps.hGap8,
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  print('点击添加备注');
                                },
                                child: Container(
                                  child: Text(_tradeData.remark == '' || _tradeData.remark == null ? '（未添加备注，点击添加备注）' : _tradeData.remark, style: TextStyles.textGray12),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ),
                    Gaps.vGap10,
                    MyCard(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(_tradeData.shippingAddress.receiverName, style: TextStyles.textDark14,),
                                      Gaps.hGap8,
                                      Text(_tradeData.shippingAddress.mobile, style: TextStyles.textBoldDark14)
                                    ],
                                  ),
                                  Gaps.vGap8,
                                  Text(_tradeData.shippingAddress.detailAddress, style: TextStyles.textDark12),
                                  Gaps.vGap10,
                                  Gaps.line,
                                  Gaps.vGap10,
                                ],
                              ),
                            ),
                            _buildOrderList(),
                          ],
                        )
                      )
                    ),
                    Gaps.vGap10,
                    MyCard(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        child: Column(
                          children: <Widget>[
                            getGoodsInfoItem("商品总额", "¥${_tradeData.totalFee}"),
                            getGoodsInfoItem("运费", "¥${_tradeData.postFee}"),
                            getGoodsInfoItem("税费", "¥${_tradeData.taxFee}"),
                            _tradeData.promotions.length>0 ? getGoodsInfoItem("优惠券", "-¥2.5", contentTextColor: Colours.text_red) : Container(),
                            Gaps.vGap5,
                            Gaps.line,
                            Gaps.vGap5,
                            getGoodsInfoItem("订单总额", "¥${_tradeData.totalFee}"),
                          ],
                        ),
                      )
                    ),
                    Gaps.vGap10,
                    MyCard(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        child: Column(
                          children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  getOrderInfoItem("订单编号：", "${_tradeData.tradeId}"),
                                  Positioned(
                                    right: 0,
                                    child: InkWell(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(
                                          text: '${_tradeData.tradeId}',
                                        ));
                                        showShortToast("ibuybuy：订单号已复制");
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 40,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF5F5F5),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text('复制', style: TextStyle(fontSize: 10),),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              getOrderInfoItem("下单时间：", "${_tradeData.created}"),
                              (_tradeData.status.key == 'wait_seller_send_goods' || 
                              _tradeData.status.key == 'wait_seller_send_goods' || 
                              _tradeData.status.key == 'trade_finished' || 
                              _tradeData.status.key == 'trade_finished') == true ? getOrderInfoItem("支付时间：", "${_tradeData.payTime}") : Container(),
                              (_tradeData.status.key == 'trade_finished') ? getOrderInfoItem("成交时间：", "${_tradeData.endTime}") : Container(),
                              (_tradeData.status.key == 'trade_finished') ? getOrderInfoItem("支付方式：", "${_tradeData.payType.value}") : Container(),
                          ],
                        ),
                      )
                    ),
                    Gaps.vGap15
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Color(0x80DCE7FA), offset: Offset(0.0, 2.0), blurRadius: 8.0, spreadRadius: 0.0),
          ] 
        ),
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        alignment: Alignment.centerRight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            OrderItemButton(
              text: '联系客服',
              textColor: Colours.text_dark,
              bgColor: Colours.bg_gray,
              onTap: (){},
            ),
            _tradeData!=null && _tradeData.status.key == 'wait_seller_send_goods' ? Gaps.hGap12 : Container(),
            _tradeData!=null && _tradeData.status.key == 'wait_seller_send_goods' ? OrderItemButton(
              text: '去发货',
              textColor: Colors.white,
              bgColor: Colours.app_main,
              onTap: (){},
            ) : Container(),
          ],
        ),
      )
    );
  }

  Widget _buildOrderList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _tradeData.orders.length,
      itemBuilder: (_, index){
        var model = _tradeData.orders[index];
        return Container(
          // decoration: BoxDecoration(
          //   border: Border(
          //     bottom: BorderSide(
          //       width: 0.5,
          //       color: Colours.text_gray_c
          //     )
          //   )
          // ),
          child: Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Image.network(model.picUrl, width: 80.0, height: 80.0),
                  margin: const EdgeInsets.only(top: 0.0),
                ),
                Gaps.hGap8,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 5,
                              child: Container(
                                height: 40,
                                child: Text(
                                  model.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.textDark12
                                ),
                              )
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text("¥${model.price}", style: TextStyles.textDark12),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text("x${model.num}", style: TextStyles.textDark12),
                        ],
                      ),
                      Gaps.vGap8,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          model.propertiesName== '' ? Container() : Text("规格：${model.propertiesName}", style: TextStyles.textGray12),
                        ],
                      ),
                      // Gaps.vGap8,
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget getOrderInfoItem(String title, String content){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          Text(title, style: TextStyles.textGray14),
          Gaps.hGap8,
          Text(content, style: TextStyles.textDark14)
        ],
      ),
    );
  }
  Widget getGoodsInfoItem(String title, String content, {Color contentTextColor = Colours.text_dark}){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title, style: TextStyles.textDark14),
          Text(content, style: TextStyle(
            color: contentTextColor,
            fontWeight: FontWeight.bold
          ))
        ],
      ),
    );
  }
}

class OrderItemButton extends StatelessWidget {
  
  const OrderItemButton({
    Key key,
    this.bgColor,
    this.textColor,
    this.text,
    this.onTap
  }): super(key: key);
  
  final Color bgColor;
  final Color textColor;
  final GestureTapCallback onTap;
  final String text;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(4.0)
        ),
        constraints: BoxConstraints(
            minWidth: 64.0,
            maxHeight: 30.0,
            minHeight: 30.0
        ),
        child: Text(text, style: TextStyle(fontSize: Dimens.font_sp14, color: textColor),),
      ),
      onTap: onTap,
    );
  }
}