import 'package:flutter/material.dart';

class MyTabViewV2 extends StatelessWidget {
  const MyTabViewV2(this.tabName, this.tabSub, this.index);

  final String tabName;
  final String tabSub;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: SizedBox(
        width: 68.0,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Text(tabName),
            // Positioned(
            //   right: 0,
            //   top: 0,
            //   child: Container(
            //     alignment: Alignment.center,
            //     width: 16,
            //     height: 16,
            //     decoration: BoxDecoration(
            //       image: DecorationImage(image: NetworkImage('https://img.aqsea.com/iBuyBuy/wechat/icon/num_tips.png'), fit: BoxFit.cover)
            //     ),
            //     child: Text('${this.tabSub}', style: TextStyle(fontSize: 12)),
            //   ),
            // )
            // Offstage(
            //   offstage: false,
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 1.0),
            //     child: Text(tabSub, style: TextStyle(fontSize: Dimens.font_sp12)),
            //   )
            // ),
          ],
        ),
      )
    );
  }
}
