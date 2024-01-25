import 'package:flutter/material.dart';
import 'package:seller/style/resources.dart';

class ScanResultPage extends StatefulWidget {

  const ScanResultPage({
    Key key,
    this.data,
  }) : super(key: key);

  final String data;

  @override
  _ScanResultPageState createState() => _ScanResultPageState();
}

class _ScanResultPageState extends State<ScanResultPage> {

  @override
  Widget build(BuildContext context) {
    print(widget.data);
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.only(top: 10, left: 15.0, right: 15.0, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('清风牌面巾纸', style: TextStyle(fontSize: 18), maxLines: 2, overflow: TextOverflow.ellipsis),
                  Gaps.vGap4,
                  Text('某某有限公司', style: TextStyle(fontSize: 13, color: Color(0xFF666666)), maxLines: 2, overflow: TextOverflow.ellipsis),
                  Gaps.vGap4,
                  Text('暂无建议零售价', style: TextStyle(fontSize: 11, color: Color(0xFF666666)), maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Text('${widget.data}')
          ],
        ),
      ),
    );
  }
}