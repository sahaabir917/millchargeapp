import 'package:get/get.dart';
import 'package:millchargesystem/helper/Dbhelper.dart';
import 'package:millchargesystem/helper/api_service.dart';
import 'package:millchargesystem/models/generalinfo/general_info_model.dart';
import 'package:millchargesystem/models/generalinfo/local_general_info_model.dart';
import 'package:millchargesystem/models/user/user_info_model.dart';
import 'package:millchargesystem/utils/user_info_utils.dart';

class GeneralController extends GetxController {
  ApiService apiService = ApiService();
  var isgeneralinfoLoading = true.obs;
  var generalInfoModel = GeneralInfoModel().obs;
  var generalInfos = GeneralInfoModel().obs;
  var localgeneralInfos = List<LocalGeneralInfoModel>().obs;
  UserInfoUtills userInfoUtills = UserInfoUtills();
  var isLoading = true.obs;

  Future<void> getAllGeneralInfo() async {
    isLoading(true);
    await DatabaseHelper.instance.deleteLocalGeneralInfo();
    List<LocalGeneralInfoModel> localGeneralInfoList = await DatabaseHelper
        .instance.getLocalGeneralInfo();
    print("local general info after delete ${localGeneralInfoList.length}");
    UserInfoModel userInfoModel = await userInfoUtills.getUserDetailsInfo();
    var accessToken = await userInfoModel.accessToken;
    var userId = await userInfoModel.userinfo.id;
    var userHostel = await userInfoUtills.getUserHostel();
    print("user hostel id is : ${userHostel}");
    var returnedModel = await apiService.getUserGeneralInfo(
        userId, userHostel, accessToken);
    if (returnedModel is GeneralInfoModel) {
      print(" return general info successfully");
      generalInfos = returnedModel.obs;
      LocalGeneralInfoModel _localgeneralModel = LocalGeneralInfoModel(
          addmore: generalInfos.value.addmore,
          mytotalcredit: generalInfos.value.mytotalcredit[0].myTotalCredit,
          back: generalInfos.value.back,
          name: generalInfos.value.mytotalcredit[0].name,
          cashinhand: generalInfos.value.cashinhand,
          currentmillcharge: generalInfos.value.currentMillCharge,
          monthtotalcredit: generalInfos.value.monthTotalCredit.monthTotalCredit.toString(),
          monthtotaldebit: generalInfos.value.monthTotaldebit.monthTotalDebit.toString(),
          mytotalcost: generalInfos.value.mytotalcost,
          mytotaldebit: generalInfos.value.mytotaldebit.myTotalDebit.toString(),
          mytotalmills: generalInfos.value.mytotalmill.toString(),
          totalmills: generalInfos.value.monthsTotalMill.toString()
      );
     var a = await DatabaseHelper.instance.addLocalGeneralInfo(_localgeneralModel);
    print(" data save to :$a");

      List<LocalGeneralInfoModel> localGeneralInfoLists = await DatabaseHelper
          .instance.getLocalGeneralInfo();

      if(localGeneralInfoLists.length >0){
        // print("TOTAL DBIT IS :" +localGeneralInfoLists[0].reactive.value.monthtotaldebit);
        localgeneralInfos.clear();
        localgeneralInfos = localGeneralInfoLists.obs;
        localgeneralInfos.refresh();
      }
      else{
        localgeneralInfos.clear();
        localgeneralInfos = localgeneralInfos.value.obs;
        localgeneralInfos.refresh();
      }
    }
    else {
      //show a toast;
      //for unauthorized model
    }
    isLoading(false);
  }

}