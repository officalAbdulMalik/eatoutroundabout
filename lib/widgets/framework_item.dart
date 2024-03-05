import 'package:eatoutroundabout/controllers/user_controller.dart';

import 'package:eatoutroundabout/models/projects_model.dart';
import 'package:eatoutroundabout/models/social_value_framework_item.dart';
import 'package:eatoutroundabout/models/social_value_model.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/services/util_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/cached_image.dart';
import 'package:eatoutroundabout/widgets/loading.dart';
import 'package:eatoutroundabout/widgets/social_value_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class FrameworkItem extends StatelessWidget {
 final SocialValueFrameworkItem? socialValueFrameworkItem;
 final Projects? projects;
 final bool? isMyFrameworkItem;


 FrameworkItem({this.socialValueFrameworkItem, this.isMyFrameworkItem, this.projects});
  final firestoreService = Get.find<FirestoreService>();
  final userController = Get.find<UserController>();
  final miscService = Get.find<UtilService>();
  var formatter = NumberFormat('#,##,000');


  @override
  Widget build(BuildContext context) {
    // num number = socialValueProjects!.totalImpact!;
    // String output = NumberFormat.decimalPattern().format(number);

    return


      Container(
        margin: EdgeInsets.only(bottom: padding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(padding / 50),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 10),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[

            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(padding / 2), bottomRight: Radius.circular(padding / 2)),
                color: Colors.white,
              ),
              child: Row(
                children: [
                   CachedImage(
                    url: socialValueFrameworkItem!.image! == '' ? 'assets/images/logo.png' : socialValueFrameworkItem!.image!,
                      height: 80,
                    ),
                  SizedBox(width: 20),
                   Expanded(
                     child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(socialValueFrameworkItem!.frameworkItemTitle!, textScaleFactor: 0.9, maxLines:2, overflow: TextOverflow.ellipsis, style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
                         SizedBox(height: 5),
                         SingleChildScrollView(
                          child: Column(
                             children: [
                              Container(child:

                               PaginateFirestore(
                                 physics: NeverScrollableScrollPhysics(),
                                 shrinkWrap: true,
                                 isLive: true,
                                 key: GlobalKey(),
                                 padding: EdgeInsets.symmetric(horizontal: padding),
                                itemBuilderType: PaginateBuilderType.listView,
                                 itemBuilder: (context, documentSnapshot, i) {
                                   SocialValue socialValue = documentSnapshot[i].data() as SocialValue;
                                   return SocialValueItem(socialValue: socialValue, isMySocialValue : true);
                                 },
                                 query: firestoreService
                                     .getMySocialValue(projects!.projectID!, socialValueFrameworkItem!.frameworkItemID!),
                                 onEmpty: Text(
                                   'No social value to show',
                                   textAlign: TextAlign.center,
                                   textScaleFactor: 1.15,
                                 ),

                                 itemsPerPage: 10,
                                 bottomLoader: LoadingData(),
                                 initialLoader: LoadingData(),
                              ),
                               ),

                             ],
                           ),
                         ),
                       ],
                     ),
                   ),
                ],
              ),
            ),
         ],
       ),
       );

  }
 }
