import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  Future<void> initializeLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('loggedIn')) {
      await prefs.setBool('loggedIn', false);
    }
  }

  Future<void> setLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', true);
  }

  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('loggedIn') ?? false;
  }

  Future<void> clearLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('loggedIn');
  }
}

class PhoneNumber {
  Future<void> initializeLoggedIn(String number) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('phoneNumber')) {
      await prefs.setString('phoneNumber', number);
    }
  }

  Future<String> getNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('phoneNumber') ?? '';
  }

  Future<void> setNumber(String number) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('phoneNumber', number);
  }

  Future<void> removeNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('phoneNumber');
  }
}
