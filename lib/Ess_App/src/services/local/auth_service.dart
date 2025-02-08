import 'dart:convert';

import 'package:ess/Ess_App/src/models/api_response_models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class AuthService with ReactiveServiceMixin {
  static late SharedPreferences prefs;
  ReactiveValue<User?> _user = ReactiveValue<User?>(null);

  User? get user => _user.value;

  final String _prefKey = "USER_LOGIN_DATA";

  AuthService() {
    listenToReactiveValues([_user]);
    _restoreUserFromLocal();
  }

  set user(User? user) {
    _user.value = user;
    _storeLocally();
  }

  logout() {
    _clearUserFromLocal();
  }

  _storeLocally() async {
    if (_user.value == null) return;
    prefs.setString(_prefKey, jsonEncode(_user.value?.toJson() ?? {}));
  }

  _restoreUserFromLocal() async {
    if (!prefs.containsKey(_prefKey)) return;
    user = User.fromJson(jsonDecode(prefs.getString(_prefKey) ?? "{}"));
  }

  _clearUserFromLocal() async {
    if (!prefs.containsKey(_prefKey)) return;
    prefs.remove(_prefKey);
    _user.value = null;
    print(_user);

  }

}
