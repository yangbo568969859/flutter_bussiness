import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:seller/utils/toast.dart';

import 'package:seller/widgets/button/add_button.dart';
import 'package:seller/widgets/text_field_item.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:seller/api/api.dart';
import 'package:seller/model/address.dart';
import 'package:seller/style/resources.dart';


class WarehouseAdd extends StatefulWidget {
  final String type;
  final int status;
  final addressId;
  final address;

  WarehouseAdd({Key key, this.type, this.status, this.addressId, this.address}) : super(key: key);

  @override
  _WarehouseAddState createState() => _WarehouseAddState();
}

class _WarehouseAddState extends State<WarehouseAdd> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _regionController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _companyController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();
  final FocusNode _nodeText4 = FocusNode();
  final FocusNode _nodeText5 = FocusNode();
  final FocusNode _nodeText6 = FocusNode();
  bool _check = false;
  String _state = "";
  String _city = "";
  String _district = "";
  KeyboardActionsConfig _config;
  Addresses address;
  Addresses addressData;
  String title = '添加';

  @override
  void initState() {
    if (widget.status == 1) {
      title = '添加发货仓';
    } else {
      title = '添加退货仓';
    }
    super.initState();
    if (widget.type == 'edit') {
      addressData = widget.address;
      _nameController.text = addressData.contactName;
      _phoneController.text = addressData.mobile;
      _descController.text = addressData.address;
      _companyController.text = addressData.company;
      _countryController.text = addressData.country;
      _check = addressData.isDef;
      _state = addressData.state;
      _city = addressData.city;
      _district = addressData.district;
      // _fetchAddress();
    }
  }

  /// 请求编辑的地址信息
  // _fetchAddress()async {
  //   String urls = 'user-java.address.get';
  //   var res = await httpManager.netFetch(urls, {
  //     'address_id': widget.addressId,
  //   }, null, null);
  //   var response = json.decode(res.toString());
  //   address = AddressDetailModel.fromJson(response);
  //   if (address.data.success == true) {
  //     setState(() {
  //       addressData = address.data.data;
  //     });
  //     _nameController.text = addressData.contactName;
  //     _phoneController.text = addressData.mobile;
  //     _descController.text = addressData.address;
  //     _companyController.text = addressData.identityId;
  //     _check = addressData.isDefault;
  //     _state = addressData.state;
  //     _city = addressData.city;
  //     _district = addressData.district;
  //   }
  // }

  /// 提交
  _submitData() async {
    _checkData().then((res) async {
      if (res == true) {
        if (widget.type == 'add' || widget.type =='' || widget.type == null) {
          String urls = 'logistics.page.address.add';
          var res = await httpManager.netFetch(urls, {
            "address_type": widget.status,
            "contact_name": _nameController.text,
            "mobile": _phoneController.text,
            "address": _descController.text,
            "company": _companyController.text,
            "country": _countryController.text,
            'is_def': _check,
            "state": _state,
            "city": _city,
            "district": _district,
          }, null, 'POST');
          if (res['data']['is_success'] == false) {
            MyToast.show('ibuybuy：添加失败', gravity: 'center');
          } else if (res['data']['is_success'] == true) {
            MyToast.show('ibuybuy：添加成功', gravity: 'center');
            // RouteUtil.goBackWithParams(context, true);
            Navigator.pop(context, {'isreplace': true});
          }
        } else if (widget.type == 'edit') {
          String urls = 'logistics.page.address.update';
          var res = await httpManager.netFetch(urls, {
            "contact_name": _nameController.text,
            "mobile": _phoneController.text,
            "address": _descController.text,
            "company": _companyController.text,
            "country": _countryController.text,
            "address_id": widget.addressId,
            'is_def': _check,
            "state": _state,
            "city": _city,
            "district": _district,
          }, null, 'PUT');
          if (res['data']['is_success'] == false) {
            MyToast.show('ibuybuy：修改失败', gravity: 'center');
          } else if (res['data']['is_success'] == true) {
            MyToast.show('ibuybuy：修改成功', gravity: 'center');
            // RouteUtil.goBackWithParams(context, true);
            Navigator.pop(context, {'isreplace': true});
          }
        }
      }
    });

  }
  Future _checkData() async {
    var flag = true;
    if (_nameController.text == '') {
      MyToast.show('请填写收货人姓名', gravity: 'center');
      flag = false;
      return flag;
    }
    if (_phoneController.text == '') {
      MyToast.show('请输入手机号码', gravity: 'center');
      flag = false;
      return flag;
    }
    if (_countryController.text == '') {
      MyToast.show('请输入所在地区', gravity: 'center');
      flag = false;
      return flag;
    }
    if (_descController.text == '') {
      MyToast.show('请输入详细地址，如街道，门牌号等', gravity: 'center');
      flag = false;
      return flag;
    }
    if (_companyController.text == '') {
      MyToast.show('请填写仓库名称', gravity: 'center');
      flag = false;
      return flag;
    }
    return flag;
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        title: Text('$title'),
        centerTitle: true,
        actions: <Widget>[
          InkWell(
            onTap: () {
              _submitData();
            },
            child: Container(
              width: 60,
              alignment: Alignment.center,
              child: Text('保存', style: TextStyle(fontSize: 13)),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                physics: BouncingScrollPhysics(),
                child: Container(
                  color: Colors.white,
                  child: Column(
                  children: <Widget>[
                    TextFieldItem(
                      title: "仓库名称",
                      hintText: "请输入仓库名称",
                      focusNode: _nodeText5,
                      controller: _companyController,
                    ),
                    TextFieldItem(
                      title: "联系人",
                      hintText: "请输入联系人",
                      focusNode: _nodeText1,
                      controller: _nameController,
                    ),
                    TextFieldItem(
                      title: "手机号码",
                      hintText: "请输入手机号码",
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      focusNode: _nodeText2,
                      controller: _phoneController,
                    ),
                    TextFieldItem(
                      title: "所在地区",
                      hintText: "请填写所在地区",
                      focusNode: _nodeText6,
                      controller: _countryController,
                    ),
                    TextFieldItem(
                      title: "详细地址",
                      hintText: "请输入详细地址",
                      focusNode: _nodeText4,
                      controller: _descController,
                      maxLength: 3
                    ),
                    Container(
                      height: 15,
                      color: Color(0xFFF7F7F7),
                    ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.only(left: 15, right: 15),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('设为默认地址'),
                          CupertinoSwitch(
                            activeColor: Colours.app_main,
                            value: _check,
                            onChanged: (bool val) {
                              setState(() {
                                _check = !_check;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                )
              ),
            )
          ],
        ),
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
                print(_nameController.text);
                _submitData();
                // RouteUtil.routeToAddressDetailPage(context);
              },
              fontSize: 15,
              label: '保存',
            )
          ),
        ),
      ),
    );
  }
}