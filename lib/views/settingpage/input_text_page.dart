import 'package:flutter/material.dart';
import 'package:seller/utils/route_util.dart';
import 'package:seller/style/resources.dart';

class InputTextPage extends StatefulWidget {
  InputTextPage({
    Key key,
    @required this.title,
    this.content,
    this.hintText,
    this.maxLength = 30,
    this.keyboardType: TextInputType.text,
  }) : super(key: key);

  final String title;
  final String content;
  final String hintText;
  final int maxLength;
  final TextInputType keyboardType;

  @override
  _InputTexrPageState createState() => _InputTexrPageState();
}

class _InputTexrPageState extends State<InputTextPage> {

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(fontSize: 16)),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          InkWell(
            onTap: () {
              RouteUtil.goBackWithParams(context, _controller.text);
            },
            child: Container(
              width: 60,
              alignment: Alignment.center,
              child: Text('确定'),
            ),
          )
        ],
      ),
      backgroundColor: Color(0xFFF5F8FA),
      body: Container(
        color: Colors.white,
          child: Padding(
          padding: EdgeInsets.only(top: 11.0, left: 16.0, right: 16.0, bottom: 16.0),
          child: TextField(
            style: TextStyle(fontSize: 14),
            maxLength: widget.maxLength,
            maxLines: 5,
            autofocus: true,
            controller: _controller,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: InputBorder.none,
              hintStyle: TextStyles.textGrayC14
            )
          ),
        ),
      )
    );
  }
}