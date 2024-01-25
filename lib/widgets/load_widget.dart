import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:seller/model/loading_state.dart';

class LoadingWidget extends StatelessWidget {
  final LoadingState _loadingState;

  LoadingWidget(this._loadingState);

  @override
  Widget build(BuildContext context) {
    if (_loadingState == LoadingState.Error || _loadingState == LoadingState.NoMore) {
      return Container(
        color: Colors.transparent,
        child: RaisedButton(
          onPressed: () {},
          child: Center(
            child: Column(
              children: <Widget>[
                Icon(
                  IconData(0xe639,fontFamily: 'iconfont'),
                  size: 40,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Text(
                      _loadingState == LoadingState.Error ? "重新加载" : '没有数据',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none
                      )
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SpinKitRing(
            color: Colors.black,
            size: 40,
            lineWidth: 6,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14),
            child: Text("正在加载中",style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              decoration: TextDecoration.none
            )),
          )
        ],
      ),
    );
  }
}

const loadingFooterHeight = 40.0;
class LoadingFooterWidget extends StatelessWidget {
  final LoadingState _loadingState;
  LoadingFooterWidget(this._loadingState);

  @override
  Widget build(BuildContext context) {
    if (_loadingState == LoadingState.Error || _loadingState == LoadingState.NoMore) {
      return Container(
        height: loadingFooterHeight,
        child: FlatButton(
          onPressed: () {
            // if (_loadingState == LoadingState.Error) this.reLoad();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Visibility(
                child: Icon(
                  IconData(0xe639,fontFamily: 'iconfont'),
                  size: 32,
                  color: Color(0xFF666666),
                ),
                visible: _loadingState == LoadingState.Error,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Text(
                  _loadingState == LoadingState.Error ? "重新加载" : "没有更多了～",
                  style: TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 12,
                    decoration: TextDecoration.none
                  )
                ),
              )
            ],
          ),
        ),
      );
    }
    return Container(
      height: loadingFooterHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SpinKitRing(
            color: Color(0xFF666666),
            size: 26,
            lineWidth: 4,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Text("正在加载下一页",style: TextStyle(
              color: Color(0xFF666666),
              fontSize: 12,
              decoration: TextDecoration.none
            )),
          )
        ],
      ),
    );
  }
}
