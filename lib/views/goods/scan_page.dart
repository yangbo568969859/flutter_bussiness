import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qr_reader/qrcode_reader_view.dart';

import 'package:seller/utils/route_util.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  GlobalKey<QrcodeReaderViewState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget backdrop({double width, double height, Widget child}) => Container(
    width: width ?? double.infinity,
    height: height ?? double.infinity,
    color: Color(0x99000000),
    child: child ?? null,
  );

  static bool isChinaPhoneLegal(String str) {
    return RegExp(
        r"^([hH][tT]{2}[pP]:\/\/|[hH][tT]{2}[pP][sS]:\/\/)(([A-Za-z0-9-~]+).)+([A-Za-z0-9-~\/])+$")
    .hasMatch(str);
  }

  Future onScan(String data) async {
    print(isChinaPhoneLegal(data));
    if (isChinaPhoneLegal(data) == true) {
      Navigator.pop(context);
      RouteUtil.pushWeb(context, url: data);
    } else {
      Navigator.pop(context);
      RouteUtil.routeToScanResultPage(context, data: data);
    }
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('识别二维码'),
      ),
      body: QrcodeReaderView(key: _key, onScan: onScan),
    );
  }
}