
import 'package:flutter/material.dart';
import 'package:seller/style/resources.dart';
import 'package:seller/widgets/click_item.dart';



/// design/8设置/index.html
class ReturnWarehouseManage extends StatefulWidget {
  @override
  _ReturnWarehouseManageState createState() => _ReturnWarehouseManageState();
}

class _ReturnWarehouseManageState extends State<ReturnWarehouseManage> {
  String _userImage = 'https://img.aqsea.com/wechat/default-head.png';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        title: Text('店铺管理'),
        centerTitle: true,
        actions: <Widget>[
          InkWell(
            onTap: () {
            },
            child: Container(
              width: 64,
              alignment: Alignment.center,
              child: Text('查看店铺', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Gaps.vGap5,
          // ClickItem(
          //   label: '店铺头像',
          //   value: '',
          //   onPressed: () {
          //   }
          // ),
          ClickItemAvater(
            label: '头像',
            value: _userImage,
            type: 'avatar',
            showLine: true,
            onPressed: () {
              // _getImage();
            },
          ),
          ClickItem(
            label: '店铺昵称',
            value: 'ibuybuy',
            onPressed: () {
            }
          ),
          ClickItem(
            label: '店铺公告',
            value: '',
            onPressed: () {
            }
          ),
          ClickItem(
            label: '店铺装修',
            value: '',
            showLine: false,
            onPressed: () {
            }
          ),
          Gaps.vGap8,
          ClickItem(
            label: '微信名片',
            value: '',
            showLine: false,
            onPressed: () {
            }
          ),
          Gaps.vGap8,
          ClickItem(
            label: '物流设置',
            value: '',
            showLine: false,
            onPressed: () {
            }
          ),
        ],
      ),
    );
  }
}
