import 'dart:io';

import 'package:get/get.dart';
import 'package:millchargesystem/helper/Dbhelper.dart';
import 'package:millchargesystem/helper/api_service.dart';
import 'package:millchargesystem/models/credit/add_credit_model.dart';
import 'package:millchargesystem/models/credit/credit_model.dart';
import 'package:millchargesystem/models/credit/credit_sum_model.dart';
import 'package:millchargesystem/models/credit/single_credit_model.dart';
import 'package:millchargesystem/models/credit/single_day_get_credit_model.dart';
import 'package:millchargesystem/models/user/unauthorized/unauthorized_model.dart';
import 'package:millchargesystem/models/user/user_info_model.dart';
import 'package:millchargesystem/utils/common_util.dart';
import 'package:millchargesystem/utils/user_info_utils.dart';

class CreditTransactionController extends GetxController {
  ApiService apiService = ApiService();
  UserInfoUtills userInfoUtills = UserInfoUtills();
  var isLoadingCredit = false.obs;
  var creditInfos = CreditModel().obs;
  var localCreditInfos = List<SingleCreditModel>().obs;
  var calenderSelectedDay = "".obs;
  CommonUtil commonUtil = CommonUtil();
  var creditSumModel = CreditSumModel().obs;
  var selectedMonth = "".obs;
  var isLoadingCreditSum = false.obs;
  var singleDayGetCreditSumModel = SingleDayGetCreditModel().obs;
  var ishide = true.obs;
  var issingleDayGetCreditSumModelLoading = false.obs;

  Future<void> getRecentCreditTransactions() async {
    isLoadingCredit(true);
    await DatabaseHelper.instance.deleteCredits();
    List<SingleCreditModel> localCreditlInfoList =
        await DatabaseHelper.instance.getLocalCredits();
    print("local credit info after delete ${localCreditlInfoList.length}");
    UserInfoModel userInfoModel = await userInfoUtills.getUserDetailsInfo();
    var accessToken = await userInfoModel.accessToken;
    var userId = await userInfoModel.userinfo.id;
    var userHostelId = await userInfoUtills.getUserHostel();
    print("user hostel id is : ${userHostelId}");
    var returnedModel = await apiService.getRecentCreditTransactions(
        accessToken, userHostelId, "yes", "1");
    if (returnedModel is CreditModel) {
      print(" return general info successfully");
      creditInfos = returnedModel.obs;
      var lengthofCreditInfos = creditInfos.value.data.length;

      for (int i = 0; i < lengthofCreditInfos; i++) {
        SingleCreditModel _singleCreditModel = SingleCreditModel(
            id: i.toString(),
            creditDate: creditInfos.value.data[i].creditDate,
            creditAmount: creditInfos.value.data[i].creditAmount,
            creditDescription: creditInfos.value.data[i].creditDescription,
            notes: creditInfos.value.data[i].notes,
            creditMonth: creditInfos.value.data[i].creditMonth,
            creditYear: creditInfos.value.data[i].creditYear,
            creditedBy: creditInfos.value.data[i].name,
            creditHostelId: creditInfos.value.data[i].creditHostelId,
            creditImage: creditInfos.value.data[i].creditImage,
            createdAt: "12334",
            updatedAt: "98742938");
        var a = await DatabaseHelper.instance.addACredit(_singleCreditModel);
        print("credit data save to :$a");
      }

      List<SingleCreditModel> localCreditLists =
          await DatabaseHelper.instance.getLocalCredits();

      if (localCreditLists.length > 0) {
        // print("TOTAL DBIT IS :" +localGeneralInfoLists[0].reactive.value.monthtotaldebit);
        localCreditInfos.clear();
        localCreditInfos = localCreditLists.obs;
        localCreditInfos.refresh();
      } else {
        localCreditInfos.clear();
        localCreditInfos = localCreditInfos.value.obs;
        localCreditInfos.refresh();
      }
    } else {
      UnAuthorizedModel(message: "Session Out");
    }
    isLoadingCredit(false);
  }

  Future<dynamic> addCredit(
      String creditYear,
      String creditMonth,
      String creditDay,
      String creditDescription,
      String creditAmount,
      String creditShortNote,
      String creditDate,
      File selectedFile,
      String pageFrom) async {
    UserInfoModel userInfoModel = await userInfoUtills.getUserDetailsInfo();
    var accessToken = await userInfoModel.accessToken;
    var userId = await userInfoModel.userinfo.id;
    var userHostelId = await userInfoUtills.getUserHostel();
    var returnedModel = await apiService.UploadPicture(
        accessToken,
        userId,
        userHostelId,
        creditYear,
        creditMonth,
        creditDay,
        creditDescription,
        creditAmount,
        creditShortNote,
        creditDate,
        selectedFile,
        pageFrom);
    if (returnedModel is AddCreditModel) {
      print("login sucess");
      return true;
    }
  }

  Future<void> setSelectedDate(String day) async {
    issingleDayGetCreditSumModelLoading(true);
    print("selected date is ${day}");
    calenderSelectedDay = day.obs;
    calenderSelectedDay.refresh();

    var date = commonUtil.getDate(calenderSelectedDay.value);
    var month = commonUtil.getMonth(calenderSelectedDay.value);
    print("selectedMonth is : ${selectedMonth.value}");
    print("selectedMonth is : ${month}");
    var year = commonUtil.getYear(calenderSelectedDay.value);
    UserInfoModel userInfoModel = await userInfoUtills.getUserDetailsInfo();
    var accessToken = await userInfoModel.accessToken;
    var userId = await userInfoModel.userinfo.id;
    var userHostelId = await userInfoUtills.getUserHostel();
    print("user hostel id is : ${userHostelId}");
    if(month !=selectedMonth.value ){
     isLoadingCreditSum(true);
      var returnedModel =
      await apiService.getCreditSum(userHostelId, accessToken, month, year);
      if (returnedModel is CreditSumModel) {
        creditSumModel = returnedModel.obs;
        creditSumModel.refresh();
        selectedMonth = month.obs;
        selectedMonth.refresh();
      }
      isLoadingCreditSum(false);
    }

    var returnedModel1 = await apiService.getCreditByDate(userHostelId,accessToken,calenderSelectedDay.value,"no");

    if(returnedModel1 is SingleDayGetCreditModel){
      singleDayGetCreditSumModel = returnedModel1.obs;
      singleDayGetCreditSumModel.refresh();
      print("singledatGetCreditSumModel is ${singleDayGetCreditSumModel.value}");
    }

    issingleDayGetCreditSumModelLoading(false);
  }

  void setHideOrShow(bool isHide){
    ishide(isHide);
    ishide.refresh();
  }
}
