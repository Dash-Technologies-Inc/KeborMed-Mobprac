import 'package:get_storage/get_storage.dart';

class Preference {
  static GetStorage? box;
  static const sbPreference = "kebormed_preference";
  static const keyIsLogin = 'is_login';
  static const keyRememberCredential = 'key_remember_credential';
  static const keyToken = 'key_token';

  init() async {
    await GetStorage.init(sbPreference);
    box = GetStorage(sbPreference);
  }

  static setIsLogin(bool isLogin) async {
    box?.write(keyIsLogin, isLogin);
  }

  static getIsLogin() {
    if (box != null && box!.hasData(keyIsLogin)) {
      bool cx = box!.read(keyIsLogin);
      return cx;
    }
    return false;
  }

  static void clearPreference() {
    Preference.setIsLogin(false);
  }
}
