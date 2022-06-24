import 'dart:convert';

import 'package:millchargesystem/models/user/user_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoUtills{
  Future<String> getAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jwttoken = sharedPreferences.getString("accesstoken");
    return jwttoken;
  }

  Future<bool> isLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getBool("isLogin");
    return userId;
  }

  Future<UserInfoModel> getUserDetailsInfo() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    var userinfos = await sharedPreferences.getString("userinfo");
    Map json = jsonDecode(userinfos);
    var user = UserInfoModel.fromJson(json);
    print("userinfo first name is : ${user.accessToken}");
    return user;
  }

  Future<String> getUserHostel() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var hostelId = sharedPreferences.getString("hostelid");
    return hostelId;
  }
}