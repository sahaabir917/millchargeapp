import 'package:get/get.dart';
import 'package:millchargesystem/helper/api_service.dart';
import 'package:millchargesystem/helper/preference_helper.dart';
import 'package:millchargesystem/models/user/unauthorized/unauthorized_model.dart';
import 'package:millchargesystem/models/user/user_info_model.dart';
import 'package:millchargesystem/models/user_hostel_model.dart';
import 'package:millchargesystem/utils/user_info_utils.dart';

class LoginController extends GetxController {
    ApiService apiService = ApiService();
    var userInfoModel = UserInfoModel().obs;
    PreferenceHelper preferenceHelper = PreferenceHelper();
    UserInfoUtills userInfoUtills = UserInfoUtills();
    var unAuthorizedModel = UnAuthorizedModel().obs;
    var userhostelModel = UserHostelModel().obs;
    Future<bool> loginUser(String email,String password,String type) async{
         var returnedModel = await apiService.userLogin(email, password,type);
         if(returnedModel is UserInfoModel){
           userInfoModel = returnedModel.obs;

           var returnedModel2 = await apiService.getUserHostel(userInfoModel.value.userinfo.id.toString());
           if(returnedModel2 is UserHostelModel){
             userhostelModel = returnedModel2.obs;
             preferenceHelper.setHostelId(userhostelModel.value.userhostel[0].hostelId);
             preferenceHelper.setIsLoggedIn(true);
             preferenceHelper.setUserInfo(userInfoModel.value);
             await userInfoUtills.getUserDetailsInfo();
             print("login data find successfully");

             print("access token is saved value ${userInfoModel.value.accessToken}");
             preferenceHelper.setAccessToken(userInfoModel.value.accessToken);
             return true;
           }

           else if(returnedModel is UnAuthorizedModel){
             print("user hostel not assigned");
             unAuthorizedModel = returnedModel2.obs;
             return false;
           }
         }
         else if(returnedModel is UnAuthorizedModel){
           print("login data failed");
           unAuthorizedModel = returnedModel.obs;
           return false;
         }

    }
}