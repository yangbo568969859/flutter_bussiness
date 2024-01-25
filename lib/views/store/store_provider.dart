import 'package:flutter/material.dart';
import 'package:seller/model/store.dart';

class StoreProvider extends ChangeNotifier {
  /// shop列表
  StoreProvider() {
    _fetchStore();
  }

  Future<void> _fetchStore() async {
    print('_fetchStore');
  }

  ShopThemeItem _shopThemeP;
  ShopThemeItem get shopThemeP => _shopThemeP;
  StoreTemplateItem _choiceTheme;
  StoreTemplateItem get choiceTheme => _choiceTheme;
  void setShopTheme(obj) {
    print('setShopTheme');
    _shopThemeP = obj;
    notifyListeners();
  }
  void setChoiceTheme(obj) {
    print('setChoiceTheme');
    _choiceTheme = obj;
    notifyListeners();
  }
  void setImage(url) {
    print('我是地址${url}');
    _choiceTheme.bgImg = url;
  }
  ShopThemeItem _choiceTheme1;
  ShopThemeItem get choiceTheme1 => _choiceTheme1;
  set choiceTheme1(ShopThemeItem value) {
    _choiceTheme1 = value;
    notifyListeners();
  }
}