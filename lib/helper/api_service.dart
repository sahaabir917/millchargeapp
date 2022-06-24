import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:millchargesystem/models/credit/add_credit_model.dart';
import 'package:millchargesystem/models/credit/credit_model.dart';
import 'package:millchargesystem/models/credit/credit_sum_model.dart';
import 'package:millchargesystem/models/credit/single_day_get_credit_model.dart';
import 'package:millchargesystem/models/generalinfo/general_info_model.dart';
import 'package:millchargesystem/models/notices/all_note_model.dart';
import 'package:millchargesystem/models/notices/notice_model.dart';
import 'package:millchargesystem/models/user/unauthorized/unauthorized_model.dart';
import 'package:millchargesystem/models/user/user_info_model.dart';
import 'package:millchargesystem/models/user_hostel_model.dart';

class ApiService {
  final String BaseUrl = 'https://millcharge.xixotech.net/public/api/auth';
  final String UnAuthorizedBaseUrl =
      'https://millcharge.xixotech.net/public/api';

  static var client = http.Client();
  UserInfoModel _userInfoModel = UserInfoModel();
  UserHostelModel _userHostelModel = UserHostelModel();
  UnAuthorizedModel _unAuthorizedModel = UnAuthorizedModel();
  GeneralInfoModel _generalInfoModel = GeneralInfoModel();
  CreditModel _creditModel = CreditModel();
  AddCreditModel _addCreditModel = AddCreditModel();
  NoticeModel _noticeModel = NoticeModel();
  AllNotesModel _allNotesModel = AllNotesModel();
  CreditSumModel _creditSumModel = CreditSumModel();
  SingleDayGetCreditModel _singleDayGetCreditModel = SingleDayGetCreditModel();

  Future<dynamic> userLogin(String email, String password, String type) async {
    var body = {"email": email, "password": password, "type": type};

    print("user/authenticate body : ${body}");

    var response = await client
        .post(Uri.parse(BaseUrl + "/login"), body: jsonEncode(body), headers: {
      "Content-Type": "application/json",
    });

    print(response.statusCode);

    if (response.statusCode == 200) {
      // _userAuthenticateModel = userAuthenticateModelFromJson(response.body);
      // print(BaseUrl + "user/authenticate");
      // print("user/authenticate result" + response.body);
      //
      // return _userAuthenticateModel;
      print(BaseUrl + "login");
      print("/login result" + response.body);
      _userInfoModel = userInfoModelFromJson(response.body);

      return _userInfoModel;
    } else {
      // print(BaseUrl + "user/authenticate");
      // print("response code is : ${response.statusCode}");
      // _userAuthenticateModel = userAuthenticateModelFromJson(response.body);
      // return _userAuthenticateModel;
      _unAuthorizedModel = unAuthorizedModelFromJson(response.body);
      print(response.body);
      return _unAuthorizedModel;
    }
  }

  Future<dynamic> getUserHostel(String userId) async {
    var body = {"user_id": userId};

    print("/userhostel body : ${body}");

    var response = await client.post(
        Uri.parse(UnAuthorizedBaseUrl + "/userhostel"),
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
        });

    print(response.statusCode);

    if (response.statusCode == 200) {
      // _userAuthenticateModel = userAuthenticateModelFromJson(response.body);
      // print(BaseUrl + "user/authenticate");
      // print("user/authenticate result" + response.body);
      //
      // return _userAuthenticateModel;
      print(UnAuthorizedBaseUrl + "/userhostel");
      print("/login result" + response.body);
      _userHostelModel = userHostelModelFromJson(response.body);

      return _userHostelModel;
    } else {
      // print(BaseUrl + "user/authenticate");
      // print("response code is : ${response.statusCode}");
      // _userAuthenticateModel = userAuthenticateModelFromJson(response.body);
      // return _userAuthenticateModel;
      _unAuthorizedModel = UnAuthorizedModel(message: "Hostel is not assigned");
      return _unAuthorizedModel;
    }
  }

  Future<dynamic> getUserGeneralInfo(int userId, String userHostel,
      String accessToken) async {
    var body = {"user_id": userId, "hostel_id": userHostel};

    print("user/authenticate body : ${body}");

    var response = await client.post(Uri.parse(BaseUrl + "/generalinfo"),
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        });

    if (response.statusCode == 200) {
      print("response of /generalinfo is :${response.body}");
      _generalInfoModel = generalInfoModelFromJson(response.body);
      return _generalInfoModel;
    } else {
      return UnAuthorizedModel(message: "session expired");
    }
  }

  Future<dynamic> getRecentCreditTransactions(String accessToken,
      String userHostelId, String iscurrentMonth, String page) async {
    var body = {"hostel_id": userHostelId, "is_current_month": iscurrentMonth};

    print("user/authenticate body : ${body}");

    var response = await client.post(
        Uri.parse(BaseUrl + "/getcredit?page=${page}"),
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        });

    print("${BaseUrl}/getcredit?page=${page} response is : ${response.body}");

    if (response.statusCode == 200) {
      _creditModel = creditModelFromJson(response.body);
      return _creditModel;
    }
  }

  Future<dynamic> UploadPicture(String accessToken,
      int userId,
      String userHostelId,
      String creditYear,
      String creditMonth,
      String creditDay,
      String creditDescription,
      String creditAmount,
      String creditShortNote,
      String creditDate,
      File selectedFile,
      String pageFrom) async {
    if (pageFrom == "credit") {
      var postUri = Uri.parse(BaseUrl + "/addcredit");
      var headers = {'Authorization': 'Bearer $accessToken'};
      http.MultipartRequest request =
      new http.MultipartRequest("POST", postUri);

      http.MultipartFile multipartFile =
      await http.MultipartFile.fromPath('image', selectedFile.path);

      request.files.add(multipartFile);
      request.fields.addAll({
        'credit_date': creditDate,
        'credit_amount': creditAmount,
        'credit_description': creditDescription,
        'notes': creditShortNote,
        'credit_month': creditMonth,
        'credit_year': creditYear,
        'creditedBy': userId.toString(),
        'credit_hostel_id': userHostelId
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var responseData = await response.stream.toBytes();
      var result = String.fromCharCodes(responseData);
      if (result != null) {
        _addCreditModel = addCreditModelFromJson(result);
        print("uploading api result : " + result);
        return _addCreditModel;
        // await getUserGeneralInfo(userId, userHostelId, accessToken);
      } else {
        print("result is null");
      }
    } else if (pageFrom == "debit") {
      var postUri = Uri.parse(BaseUrl + "/addDebit");
      var headers = {'Authorization': 'Bearer $accessToken'};
      http.MultipartRequest request =
      new http.MultipartRequest("POST", postUri);

      http.MultipartFile multipartFile =
      await http.MultipartFile.fromPath('image', selectedFile.path);

      request.files.add(multipartFile);
      // request.fields.addAll({
      //   'debit_date': creditDate,
      //   'debit': creditAmount,
      //   'credit_description': creditDescription,
      //   'notes': creditShortNote,
      //   'credit_month': creditMonth,
      //   'credit_year': creditYear,
      //   'creditedBy': userId.toString(),
      //   'credit_hostel_id': userHostelId
      // });
      request.fields.addAll({
        'debit_date': creditDate,
        'debit_amount': creditAmount,
        'debit_description': creditDescription,
        'debit_notes': creditShortNote,
        'debit_month': creditMonth,
        'debit_year': creditYear,
        'debitedby': userId.toString(),
        'debit_hostel_id': userHostelId
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var responseData = await response.stream.toBytes();
      var result = String.fromCharCodes(responseData);
      if (result != null) {
        _addCreditModel = addCreditModelFromJson(result);
        print("uploading api result : " + result);
        return _addCreditModel;
        // await getUserGeneralInfo(userId, userHostelId, accessToken);
      } else {
        print("result is null");
      }
    }
  }

  Future<dynamic> addNotes(String noteYear,
      String noteMonth,
      String noteDay,
      String noteDescription,
      String noteDate,
      String accessToken,
      int userId,
      String hostelId) async {
    var body = {
      'notice_description': noteDescription,
      'notice_date': noteDate,
      'notice_month': noteMonth,
      'notice_year': noteYear,
      'notice_status': 'active',
      'notedBy': userId.toString(),
      'note_hostel_id': hostelId
    };

    print("/addnotice body : ${body}");

    var response = await client.post(Uri.parse(BaseUrl + "/addnotice"),
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        });

    print("${BaseUrl}/addnotice response is : ${response.body}");

    if (response.statusCode == 200) {
      _noticeModel = noticeModelFromJson(response.body);
      return _noticeModel;
    } else {
      //unauthorized model
      return false;
    }
  }

  Future<dynamic> getNotes(String accessToken, int userId, String userHostelId,
      String isCurrentMonth, String noteDate) async {
    var body = { 'hostel_id': userHostelId, 'is_current_month': isCurrentMonth, 'note_date': noteDate};

    var response = await client.post(Uri.parse(BaseUrl + "/getnotice?page=1"),
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        });

    if(response.statusCode ==200){
      print("/getnotice?page=1 response is ${response.body}");
      _allNotesModel = allNotesModelFromJson(response.body);
      return _allNotesModel;
    }
  }

  Future<dynamic> getCreditSum(String userHostelId, String accessToken, String month, String year) async{
    var body = { 'hostel_id': userHostelId, 'month': month, 'year': year};

    var response = await client.post(Uri.parse(BaseUrl + "/getcreditsum"),
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        });

    if(response.statusCode ==200){
      print("/getcreditsum response is ${response.body}");
      _creditSumModel = creditSumModelFromJson(response.body);
      return _creditSumModel;
    }
  }

  Future<dynamic> getCreditByDate(String userHostelId, String accessToken, String selectedDate, String isCurrentMonth) async{
    var body = { 'hostel_id': userHostelId, 'is_current_month': isCurrentMonth, 'credit_date': selectedDate};

    var response = await client.post(Uri.parse(BaseUrl + "/getcredit?page=1"),
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        });

    if(response.statusCode ==200){
      print("/getcredit?page=1 response is ${response.body}");
      _singleDayGetCreditModel = singleDayGetCreditModelFromJson(response.body);
      return _singleDayGetCreditModel;
    }
  }
}
