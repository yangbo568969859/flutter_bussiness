import 'package:flutter/material.dart';
import 'package:seller/utils/route_util.dart';
import 'package:seller/widgets/dialogs/base_dialog.dart';


// class TransParencyDialog extends StatefulWidget {
//   @override
//   _TransParencyDialogState createState() => _TransParencyDialogState();
// }

class TransParencyDialog extends StatelessWidget {

  const TransParencyDialog({
    Key key,
    this.backgroundImage,
    this.onPressed,
  }) : super(key : key);

  final String backgroundImage;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: AnimatedContainer(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeInCubic,
        child: Container(
          width: width - 80,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    GestureDetector(
                      onTap: onPressed,
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(backgroundImage),
                        ),
                      ),
                    )
                  ],
                ),
              )),
              GestureDetector(
                onTap: () {
                  RouteUtil.goBack(context);
                },
                child: Container(
                  width: 200,
                  height: 60,
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/icon/icon_circle-close.png', width: 36, height: 36),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}