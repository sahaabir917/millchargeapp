import 'dart:convert';

import 'package:millchargesystem/models/user/user_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  static SharedPreferences pref;

  void setIsLoggedIn(bool isLogin) async{
    pref = await SharedPreferences.getInstance();
    pref.setBool("isLogin", isLogin);
    pref.commit();
  }

  void setAccessToken(String accessToken) async{
    pref = await SharedPreferences.getInstance();
    pref.setString("accesstoken", accessToken);
    pref.commit();
  }

  void setUserInfo(UserInfoModel userInfo) async {
    pref = await SharedPreferences.getInstance();
    pref.setString("userinfo", jsonEncode(userInfo));
    pref.commit();
  }

  void setHostelId(String hostelId) async{
    pref = await SharedPreferences.getInstance();
    pref.setString("hostelid", hostelId);
    pref.commit();
  }




}