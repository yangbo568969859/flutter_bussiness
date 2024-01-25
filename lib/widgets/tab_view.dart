import 'package:flutter/material.dart';
import 'package:seller/style/resources.dart';

class MyTabView extends StatelessWidget {
  const MyTabView(this.tabName, this.tabSub, this.index);

  final String tabName;
  final String tabSub;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: SizedBox(
        width: 78.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(tabName),
            Offstage(
              offstage: false,
              child: Padding(
                padding: const EdgeInsets.only(top: 1.0),
                child: Text(tabSub, style: TextStyle(fontSize: Dimens.font_sp12)),
              )),
          ],
        ),
      )
    );
  }
}
