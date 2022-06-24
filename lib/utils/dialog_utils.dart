import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:millchargesystem/models/credit/single_credit_model.dart';
import 'package:readmore/readmore.dart';

class DialogUtils {
  void showDebitTransactionDetails(SingleCreditModel singleCreditModel,
      BuildContext context, String isFrom) {
    if (isFrom == "homepage") {
      showDialog(

          context: context,
          builder: (_) {
            return AlertDialog(

              // title: Text(scammedList[_current].title),
              title: Text("Transaction Date : ${singleCreditModel.creditDate}",style: TextStyle(fontSize: 15.sp),),
              content: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*.25,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Center(
                                child: new CachedNetworkImage(
                                  imageBuilder:
                                      (context,
                                      imageProvider) =>
                                      Container(
                                        width: 20.0,
                                        height: 20.0,
                                        decoration:
                                        BoxDecoration(
                                          shape: BoxShape
                                              .circle,
                                          image: DecorationImage(
                                              image:
                                              imageProvider,
                                              fit: BoxFit
                                                  .cover),
                                        ),
                                      ),
                                  progressIndicatorBuilder:
                                      (context, url,
                                      progress) =>
                                      Center(
                                        child:
                                        CircularProgressIndicator(
                                          value: progress
                                              .progress,
                                        ),
                                      ),
                                  errorWidget:
                                      (context, url,
                                      error) =>
                                      Center(
                                        child:
                                        CircularProgressIndicator(),
                                      ),
                                  imageUrl: "https://millcharge.xixotech.net/public/uploads/" +
                                      singleCreditModel.creditImage,
                                  fit: BoxFit.cover,
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              Container(
                                width: 0.5.sw,
                                child:
                                Text(
                                 singleCreditModel
                                      .creditDescription,
                                  overflow:
                                      TextOverflow
                                          .clip,
                                  style:
                                      TextStyle(
                                    fontSize:
                                        13.sp,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 0.02.sh,),
                        Container(
                          width: 1.sw,
                          child: Text("Short Note : " + singleCreditModel.notes,style: TextStyle(
                              color:
                              Colors.teal,
                              fontSize: 11.sp,
                              fontWeight:
                              FontWeight
                                  .bold),),
                        ),

                      ],
                    ),
                  ),
                  Positioned(right: 0.02.sw,
                    bottom: 0.02.sw,
                    child: Text("~"+singleCreditModel.creditedBy,style: TextStyle(fontSize: 11.sp,color: Colors.black),),
                  )
                ],
              ),
            );
          });
    }
  }
}
