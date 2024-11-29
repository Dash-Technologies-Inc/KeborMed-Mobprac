import 'package:get_storage/get_storage.dart';

class Preference {
  static GetStorage? box;
  static const sbPreference = "kebormed_preference";
  static const keyRememberEmail = 'key_remember_email';
  static const keyRememberPassword = 'key_remember_password';
  static const keyToken = 'key_token';

  init() async {
    await GetStorage.init(sbPreference);
    box = GetStorage(sbPreference);
  }

  static setToken(String token) async {
    box?.write(keyToken, token);
  }

  static String getToken() {
    if (box != null && box!.hasData(keyToken)) {
      String cx = box!.read(keyToken);
      return cx;
    }
    return "";
  }

  static setRememberEmail(String email) async {
    box?.write(keyRememberEmail, email);
  }

  static String getRememberEmail() {
    if (box != null && box!.hasData(keyRememberEmail)) {
      String cx = box!.read(keyRememberEmail);
      return cx;
    }
    return "";
  }
  static setRememberPassword(String password) async {
    box?.write(keyRememberPassword, password);
  }

  static String getRememberPassword() {
    if (box != null && box!.hasData(keyRememberPassword)) {
      String cx = box!.read(keyRememberPassword);
      return cx;
    }
    return "";
  }


  static void clearPreference() {
    Preference.setToken("");
  }
}
