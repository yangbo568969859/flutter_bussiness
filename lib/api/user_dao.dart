

import 'package:seller/api/api.dart';
import 'package:seller/utils/local_storage.dart';

class UserDao {
  static clearAll() async {
    httpManager.clearAuthorization();
    LocalStorage.remove('user');
    LocalStorage.remove('user');
  }
}