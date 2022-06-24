
import 'package:get/get.dart';
import 'package:millchargesystem/helper/api_service.dart';
import 'package:millchargesystem/models/notices/all_note_model.dart';
import 'package:millchargesystem/models/notices/notice_model.dart';
import 'package:millchargesystem/models/notices/single_note_model.dart';
import 'package:millchargesystem/models/user/unauthorized/unauthorized_model.dart';
import 'package:millchargesystem/models/user/user_info_model.dart';
import 'package:millchargesystem/utils/user_info_utils.dart';
import 'package:millchargesystem/helper/Dbhelper.dart';

class NoteController extends GetxController {
  ApiService _apiService = ApiService();
  UserInfoUtills userInfoUtills = UserInfoUtills();
  var _allNotesModel = AllNotesModel().obs;
  var singleNoteList = List<SingleNoteModel>().obs;
  var isLoadingNotes = true.obs;


  Future<bool> addNotes(String noteYear, String noteMonth, String noteDay,
      String noteDescription, String noteDate) async{
    UserInfoModel userInfoModel = await userInfoUtills.getUserDetailsInfo();
    var accessToken = await userInfoModel.accessToken;
    var userId = await userInfoModel.userinfo.id;
    var userHostelId = await userInfoUtills.getUserHostel();
   var response = await _apiService.addNotes(noteYear,noteMonth,noteDay,noteDescription,noteDate,accessToken,userId,userHostelId);
   if(response is NoticeModel){
     return true;
   }
  }

  Future<void> getNotes(String isCurrentMonth, String noteDate) async{
    UserInfoModel userInfoModel = await userInfoUtills.getUserDetailsInfo();
    var accessToken = await userInfoModel.accessToken;
    var userId = await userInfoModel.userinfo.id;
    var userHostelId = await userInfoUtills.getUserHostel();
    isLoadingNotes(true);

    var response = await _apiService.getNotes(accessToken,userId,userHostelId,isCurrentMonth,noteDate);
    if(response is AllNotesModel){
      _allNotesModel = response.obs;
      _allNotesModel.refresh();
      var sizeofAllNotes = _allNotesModel.value.data.length;
      await DatabaseHelper.instance.deleteNotes();
      for(int i=0;i<sizeofAllNotes;i++){
        SingleNoteModel singleNoteModel = SingleNoteModel(id: _allNotesModel.value.data[i].id,
        noticeDescription: _allNotesModel.value.data[i].noticeDescription,
        noticeDate: _allNotesModel.value.data[i].noticeDate,
          noticeMonth: _allNotesModel.value.data[i].noticeMonth,
          noticeYear: _allNotesModel.value.data[i].noticeYear,
          noticeStatus: _allNotesModel.value.data[i].noticeStatus,
          notedBy: _allNotesModel.value.data[i].notedBy,
          noteHostelId: _allNotesModel.value.data[i].noteHostelId,
          name: _allNotesModel.value.data[i].name
        );
        var a = await DatabaseHelper.instance.addSingleNote(singleNoteModel);
        print("note data save to :$a");
      }

      List<SingleNoteModel> localNoteList =
      await DatabaseHelper.instance.getAllNotes();

      if (localNoteList.length > 0) {
        // print("TOTAL DBIT IS :" +localGeneralInfoLists[0].reactive.value.monthtotaldebit);
        singleNoteList.clear();
        singleNoteList = localNoteList.obs;
        singleNoteList.refresh();
      } else {
        singleNoteList.clear();
        singleNoteList = singleNoteList.value.obs;
        singleNoteList.refresh();
      }
      print("notes length is ${singleNoteList.length}");
    } else {
      UnAuthorizedModel(message: "Session Out");
    }
    isLoadingNotes(false);
    }
  }

