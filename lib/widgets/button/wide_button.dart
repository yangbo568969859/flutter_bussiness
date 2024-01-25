import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  final Widget child;
  final Color background;
  final Color shadowColor;
  final bool enabled;

  @required
  final VoidCallback onPressed;

  const WideButton({
    this.child,
    this.onPressed,
    this.background,
    this.shadowColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: const BoxConstraints(minWidth: double.infinity),
      decoration: shadowColor != null ? BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            offset: const Offset(0, 10),
            blurRadius: 10
          ),
        ],
      ): null,
      child: FlatButton(
        padding: EdgeInsets.only(
          left: 15,
          right: 15,
          top: 11,
          bottom: 11
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(55),
        ),
        onPressed: enabled ? onPressed : null,
        color: background,
        child: child,
      ),
    );
  }
}