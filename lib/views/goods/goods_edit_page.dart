import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:seller/style/resources.dart';

import 'package:seller/widgets/text_field_item.dart';
import 'package:seller/widgets/click_item.dart';
import 'package:seller/views/goods/widgets/input_have_child.dart';

class GoodsEditPage extends StatefulWidget {
  @override
  _GoodsEditPageState createState() => _GoodsEditPageState();
}

class _GoodsEditPageState extends State<GoodsEditPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _regionController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _idcardController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();
  final FocusNode _nodeText4 = FocusNode();
  final FocusNode _nodeText5 = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      appBar: AppBar(
        title: Text('添加商品'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                // padding: EdgeInsets.symmetric(vertical: 16.0),
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Gaps.vGap16,
                          // const Padding(
                          //   padding: const EdgeInsets.only(left: 16.0),
                          //   child: const Text(
                          //     "基本信息",
                          //     style: TextStyles.textBoldDark18,
                          //   ),
                          // ),
                          TextFieldItem(
                            title: "商品标题",
                            hintText: "商品名称和型号（最多60个字）",
                            focusNode: _nodeText1,
                            controller: _nameController,
                          ),
                          TextFieldItem(
                            title: "商品简介",
                            hintText: "描述商品卖点信息",
                            focusNode: _nodeText2,
                            controller: _phoneController,
                          )
                        ],
                      ),
                    ),
                    Gaps.vGap8,
                    ClickItem(
                      label: '类目',
                      value: '美妆个护 - 面部护理 - 面部精华',
                      onPressed: () {
                      }
                    ),
                    Gaps.vGap8,
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          ClickItem(
                            label: '品牌',
                            value: '请选择',
                            onPressed: () {
                            }
                          ),
                          TextFieldItem(
                            title: "货号",
                            hintText: "请填写货号",
                            focusNode: _nodeText1,
                            controller: _nameController,
                          ),
                        ],
                      ),
                    ),
                    Gaps.vGap8,
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Stack(
                            alignment: Alignment.centerRight,
                            children: <Widget>[
                              TextFieldItem(
                                controller: _idcardController,
                                title: "商品条码",
                                hintText: "选填",
                              ),
                              Positioned(
                                right: 16.0,
                                child: GestureDetector(
                                  child: Icon(Icons.crop_free, size: 20, color: Color(0xFFcccccc)),
                                  onTap: () {},
                                ),
                              )
                            ],
                          ),
                          InputHaveChild(
                            title: "市场价",
                            hintText: "0.00",
                            focusNode: _nodeText1,
                            controller: _nameController,
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  Text('需高于零售价', style: TextStyles.textGray14),
                                ],
                              ),
                            )
                          ),
                          InputHaveChild(
                            title: "物流费用",
                            hintText: "0.00",
                            focusNode: _nodeText1,
                            controller: _nameController,
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  Text('包邮', style: TextStyles.textGray14),
                                  Gaps.hGap8,
                                  CupertinoSwitch(
                                    activeColor: Colors.red,
                                    value: false,
                                    onChanged: (bool value) {
                                      print(value);
                                      setState(() {
                                        // item['value'] = !item['value'];
                                      });
                                    },
                                  )
                                ],
                              ),
                            )
                          ),
                          InputHaveChild(
                            title: "清关税费",
                            hintText: "0.00",
                            focusNode: _nodeText1,
                            controller: _nameController,
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  Text('包税', style: TextStyles.textGray14),
                                  Gaps.hGap8,
                                  CupertinoSwitch(
                                    activeColor: Colors.red,
                                    value: false,
                                    onChanged: (bool value) {
                                      print(value);
                                      setState(() {
                                        // item['value'] = !item['value'];
                                      });
                                    },
                                  )
                                ],
                              ),
                            )
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                      child: Container(color: Color(0xFFf5f5f5)),
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Stack(
                            alignment: Alignment.centerRight,
                            children: <Widget>[
                              TextFieldItem(
                                controller: _idcardController,
                                title: "商品条码",
                                hintText: "选填",
                              ),
                              Positioned(
                                right: 16.0,
                                child: GestureDetector(
                                  child: Icon(Icons.crop_free, size: 20, color: Color(0xFFcccccc)),
                                  onTap: () {},
                                ),
                              )
                            ],
                          ),
                          InputHaveChild(
                            title: "市场价",
                            hintText: "0.00",
                            focusNode: _nodeText1,
                            controller: _nameController,
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  Text('需高于零售价', style: TextStyles.textGray14),
                                ],
                              ),
                            )
                          ),
                          InputHaveChild(
                            title: "物流费用",
                            hintText: "0.00",
                            focusNode: _nodeText1,
                            controller: _nameController,
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  Text('包邮', style: TextStyles.textGray14),
                                  Gaps.hGap8,
                                  CupertinoSwitch(
                                    activeColor: Colors.red,
                                    value: false,
                                    onChanged: (bool value) {
                                      print(value);
                                      setState(() {
                                        // item['value'] = !item['value'];
                                      });
                                    },
                                  )
                                ],
                              ),
                            )
                          ),
                          InputHaveChild(
                            title: "清关税费",
                            hintText: "0.00",
                            focusNode: _nodeText1,
                            controller: _nameController,
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  Text('包税', style: TextStyles.textGray14),
                                  Gaps.hGap8,
                                  CupertinoSwitch(
                                    activeColor: Colors.red,
                                    value: false,
                                    onChanged: (bool value) {
                                      print(value);
                                      setState(() {
                                        // item['value'] = !item['value'];
                                      });
                                    },
                                  )
                                ],
                              ),
                            )
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: <Widget>[
                
              ],
            )
          ],
        ),
      ),
    );
  }
}