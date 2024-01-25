import 'package:flutter/material.dart';

import 'package:seller/widgets/dialogs/base_dialog.dart';
import 'package:seller/style/resources.dart';
import 'package:seller/utils/toast.dart';
import 'package:seller/utils/route_util.dart';


class TextareaDialog extends StatefulWidget{

  TextareaDialog({
    Key key,
    this.title,
    this.onPressed,
  }) : super(key : key);

  final String title;
  final Function(String) onPressed;
  
  @override
  _TextareaDialog createState() => _TextareaDialog();
  
}

class _TextareaDialog extends State<TextareaDialog>{

  TextEditingController _controller = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: widget.title,
      child: Container(
        height: 50.0,
        margin: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: TextField(
          autofocus: true,
          controller: _controller,
          maxLines: 2,
          style: TextStyles.textDark14,
          // keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0, bottom: 8.0),
            border: InputBorder.none,
            hintText: "输入${widget.title}",
            hintStyle: TextStyles.textGrayC14,
          ),
        ),
      ),
      onPressed: (){
        if (_controller.text.isEmpty){
          showShortToast("请输入${widget.title}");       
          return;
        }
        RouteUtil.goBack(context);
        widget.onPressed(_controller.text);
      },
    );
  }
}