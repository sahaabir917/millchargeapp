class CommonUtil{

  String getDate(String date){
    var day = date.substring(8,10);
    return day;
  }
  String getYear(String date){
    var year = date.substring(0,4);
    return year;
  }
  String getMonth(String date){
    var day = date.substring(5,7);
    return day;
  }

}