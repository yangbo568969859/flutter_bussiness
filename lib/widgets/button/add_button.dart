import 'package:flutter/material.dart';
import 'package:seller/widgets/button/wide_button.dart';
import 'package:seller/style/colors.dart';

const TextStyle buttonTextStyle = TextStyle(
  fontFamily: 'MontserratMedium',
  fontSize: 16,
  color: Color.fromRGBO(38, 38, 47, 1),
);

class AddButton extends StatefulWidget {
  final Widget child;
  final Color background;
  final IconData icon;
  final String label;
  final double fontSize;
  @required
  final VoidCallback onPressed;

  const AddButton({
    Key key,
    this.child,
    this.onPressed,
    this.background = Colours.app_main,
    this.icon,
    this.label,
    this.fontSize = 12,
  }) : super(key: key);

  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  Animation<Color> _colorTween;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 3100));
    _colorTween = ColorTween(begin: widget.background, end: widget.background).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => WideButton(
        onPressed: widget.onPressed,
        background: _colorTween.value,
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              widget.icon == null ? Container() : Padding(
                padding: const EdgeInsets.only(right: 13),
                child: Icon(
                  widget.icon,
                  size: widget.fontSize,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              Text(
                widget.label,
                style: buttonTextStyle.apply(
                  color: Colors.white,
                  fontSizeDelta:
                  widget.fontSize - buttonTextStyle.fontSize
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}