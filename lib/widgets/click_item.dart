import 'package:flutter/material.dart';
import 'package:seller/style/resources.dart';

class ClickItem extends StatelessWidget {
  const ClickItem({
    Key key,
    this.type,
    this.label,
    this.hintText = '',
    this.value = '',
    this.showLine = true,
    this.onPressed,
  }) : super(key: key);

  final String label;
  final String hintText;
  final String value;
  final String type;
  final bool showLine;
  @required
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 15.0),
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 15.0, 15.0, 15.0),
          constraints: BoxConstraints(
            maxHeight: double.infinity,
            minHeight: 52.0
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: showLine == true ? Divider.createBorderSide(context, color: Colours.line, width: 0.6) : Divider.createBorderSide(context, color: Colors.transparent, width: 0.0),
            )
          ),
          width: double.infinity,
          child: Row(
            children: <Widget>[
              Text(
                label,
                style: TextStyles.textDark14,
              ),
              const Spacer(),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 16.0),
                  child: Text(
                    this.value != '' ? this.value : this.hintText,
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: this.value != '' ? Color(0xFF000000) : Color(0xFF787878), fontSize: 14),
                  ),
                ),
              ),
              Opacity(
                // 无点击事件时，隐藏箭头图标
                opacity: this.onPressed == null ? 0 : 1,
                child: Padding(
                  padding: EdgeInsets.only(top: 0.0),
                  child: Image.asset('assets/images/icon/icon_arrow_right.png', width: 16, height: 16,),
                ),
              ),
              // Icon(Icons.keyboard_arrow_right, size: 24, color: Color.fromRGBO(153, 153, 153, 1))
            ],
          ),
        ),
      ),
    );
  }
}


class ClickItemAvater extends StatelessWidget {
  final String label;
  final String hintText;
  final String value;
  final String type;
  final bool showLine;
  final num borderRadius;
  final double width;
  @required
  final VoidCallback onPressed;

  const ClickItemAvater({
    Key key,
    this.type,
    this.label,
    this.hintText,
    this.value,
    this.showLine = true,
    this.borderRadius = 50.0,
    this.width = 50.0,
    this.onPressed,
  }) : super(key: key);

  BoxDecoration get workListItemDecoration => BoxDecoration(
    boxShadow: [
      BoxShadow(
          color: Colors.black.withOpacity(0.03),
          offset: const Offset(0, 10),
          blurRadius: 10,
          spreadRadius: 0),
    ],
    borderRadius: const BorderRadius.all(Radius.circular(9)),
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 15.0),
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 15.0, 15.0, 15.0),
          constraints: BoxConstraints(
            maxHeight: double.infinity,
            minHeight: 70.0
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: showLine == true ? Divider.createBorderSide(context, color: Colours.line, width: 0.6) : Divider.createBorderSide(context, color: Colors.transparent, width: 0.0),
            )
          ),
          width: double.infinity,
          child: Row(
            children: <Widget>[
              Text(
                label,
                style: TextStyles.textDark14,
              ),
              const Spacer(),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(this.borderRadius),
                        child: value != null ? 
                          Image.network('${this.value}', width: this.width, height: 50,) : 
                          Container(),
                      ),
                    ],
                  )
                ),
              ),
              Opacity(
                // 无点击事件时，隐藏箭头图标
                opacity: this.onPressed == null ? 0 : 1,
                child: Padding(
                  padding: EdgeInsets.only(top: 0.0),
                  child: Image.asset('assets/images/icon/icon_arrow_right.png', width: 16, height: 16,),
                ),
              ),
              // Icon(Icons.keyboard_arrow_right, size: 24, color: Color.fromRGBO(153, 153, 153, 1))
            ],
          ),
        ),
      ),
    );
  }
}