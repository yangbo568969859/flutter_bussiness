
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:seller/style/resources.dart';
import 'package:seller/widgets/my_card.dart';
import 'package:seller/widgets/button/add_button.dart';
import 'package:seller/views/manage/warehouse_add.dart';
import 'package:seller/utils/route_util.dart';
import 'package:seller/model/address.dart';
import 'package:seller/widgets/empty.dart';
import 'package:seller/model/loading_state.dart';
import 'package:seller/widgets/load_widget.dart';
import 'package:seller/utils/toast.dart';
import 'package:seller/api/api.dart';


class ReceivingWarehouseManage extends StatefulWidget {
  const ReceivingWarehouseManage({
    Key key,
    this.type,
  }) : super(key: key);

  final int type;

  @override
  _ReceivingWarehouseManageState createState() => _ReceivingWarehouseManageState();
}

class _ReceivingWarehouseManageState extends State<ReceivingWarehouseManage> {
  Address address;
  AddressData addressData;
  LoadingState _loadingState = LoadingState.Loading;
  int groupValue;
  String title = '';

  _fetchAddress() async {
    String urls = 'logistics.page.address.list.get';
    var res = await httpManager.netFetch(urls, {
      'address_type': widget.type,
    }, null, null);
    print(res);
    var response = json.decode(res.toString());
    address = Address.fromJson(response);
    if (address.data != null) {
      setState(() {
        addressData = address.data;
        _loadingState = LoadingState.NoMore;
      });
      if (addressData.addresses.length > 0) {
        groupValue = addressData.addresses[0].addressId;
      }
    }
  }

  @override
  void initState() {
    print(widget.type);
    if (widget.type == 1) {
      title = '发货仓';
    } else if (widget.type == 2) {
      title = '退货仓';
    }
    super.initState();
    _fetchAddress();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _editAddress(index, address) async {
    Addresses address1 = address;
    final result = await Navigator.of(context).push(
      FadeRouteBuilder(page: WarehouseAdd(type: 'edit', status: widget.type, addressId: address1.addressId, address: address1))
    );
    print(result);
    if (result != null && result['isreplace'] == true) {
      _fetchAddress();
    }
  }

  _delateAddress(index, addressId) {
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
                    child: Text('是否删除该地址', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, decoration: TextDecoration.none, color: Colors.black)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 10, right: 20, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        FlatButton(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(100)
                          ),
                          onPressed: () {
                            // 关闭 Dialog
                            Navigator.pop(_);
                          },
                          child: Text('取消', style: TextStyle(color: Colors.red),)
                        ),
                        FlatButton(
                          color: Colors.red,
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)
                          ),
                          onPressed: () {
                            // 关闭 Dialog
                            // addressData.data.removeAt(index);
                            // setState(() {
                            //   addressData = addressData; 
                            // });
                            // print(addressData.data.length);
                            _handleDelete(index, addressId).then((val) {
                              print(val);
                              Navigator.pop(_);
                            });
                          },
                          child: Text('确认', style: TextStyle(color: Colors.white))
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

  Future _handleDelete(index, addressId) async {
    String urls = 'logistics.page.address.delete';
    var res = await httpManager.netFetch(urls, {
      'address_id': addressId,
    }, null, 'DELETE');
    print(res);
    if (res['data']['is_success'] == true) {
      MyToast.show('删除成功', gravity: 'center');
      addressData.addresses.removeAt(index);
      setState(() {
        addressData = addressData;
      });
      return true;
    } else {
      return false;
    }
  }

  // 封装函数用来发送路由和接收路由返回的数据
  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.of(context).push(
      FadeRouteBuilder(page: WarehouseAdd(type: 'add', status: widget.type))
    );
    if (result != null && result['isreplace'] == true) {
      _fetchAddress();
    }
  }

  /// 设置默认地址
  _settingDefault() async {
    String urls = 'user-java.update.address.default';
    var res = await httpManager.netFetch(urls, {
      'address_id': groupValue,
    }, null, 'PUT');
    if (res['data']['success'] == true) {
      MyToast.show('默认地址设置成功');
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        title: Text('${this.title}管理'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          height: 60,
          alignment: Alignment.center,
          child: Container(
            width: width - 60,
            child: AddButton(
              onPressed: () {
                _navigateAndDisplaySelection(context);
              },
              icon: Icons.add,
              fontSize: 16,          
              label: '新建地址',
            )
          ),
        ),
      ),
      body: address == null ? LoadingWidget(_loadingState) : (
        addressData.addresses.length == 0 ? EmptyPage(type: 'address', text: '没有可用的${this.title}地址哦~') : Container(
          child: ListView.builder(
            itemCount: addressData.addresses.length,
            itemBuilder: (_, int index) {
              var model = addressData.addresses[index];
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                margin: EdgeInsets.only(top: 15),
                child: MyCard(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            // if (widget.type != null && widget.type == 'choice') {
                            //   AddressDataList params = model;
                            //   Navigator.pop(context, {'params': params});
                            // }
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 12),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(model.contactName, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                                    SizedBox(width: 10),
                                    Text(model.mobile, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    // Text(model.state, style: TextStyles.textDark12),
                                    // SizedBox(width: 5),
                                    // Text(model.city, style: TextStyles.textDark12),
                                    // SizedBox(width: 5),
                                    // Text(model.district, style: TextStyles.textDark12),
                                    Text(model.country, style: TextStyles.textDark12),
                                    Gaps.hGap5,
                                    Text(model.address, style: TextStyles.textDark12),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Gaps.vGap10,
                        Gaps.line,
                        Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Radio(
                                      value: model.addressId,
                                      groupValue: groupValue,
                                      onChanged: (v) {
                                        print(v);
                                        setState(() {
                                          this.groupValue = model.addressId;
                                          // _settingDefault();
                                        });
                                      },
                                    ),
                                    Text('设为默认地址', style: TextStyle(fontSize: 12))
                                  ]
                                )
                              ),
                              Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      _editAddress(index, model);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(right: 15),
                                      child: Image.asset('assets/images/icon/icon_edit.png', width: 16, fit: BoxFit.fill),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _delateAddress(index, model.addressId);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 5),
                                      child: Image.asset('assets/images/icon/icon_delate.png', width: 18, fit: BoxFit.fill),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          ),
          // child: Text('1212'),
        ) 
      ),
    );
  }
}
