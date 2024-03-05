import 'package:eatoutroundabout/models/projects_model.dart';
import 'package:eatoutroundabout/models/social_value_model.dart';
import 'package:eatoutroundabout/screens/admin/business/evidence_list.dart';
import 'package:eatoutroundabout/screens/admin/business/reports/framework_items_list.dart';
import 'package:eatoutroundabout/services/util_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';



class SocialValueItem extends StatelessWidget {
  final SocialValue? socialValue;
  final Projects? projects;
  final bool? isMySocialValue;

  SocialValueItem({this.socialValue, this.isMySocialValue, this.projects});
  final miscService = Get.find<UtilService>();
  var formatter = NumberFormat('#,##,000');

  @override
  Widget build(BuildContext context) {

    return
      InkWell(
        onTap: () {
          if (isMySocialValue ?? false)
            Get.to(() => EvidenceList(socialValue: socialValue));
          else
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => FrameworkItemsList(projects: projects)));
        },
        child: Container(
          margin: EdgeInsets.only(bottom: padding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(padding / 50),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 10),
            ],
          ),
      child:
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(padding / 1), bottomRight: Radius.circular(padding / 2)),
                color: Colors.white,
              ),
              child:
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Text(socialValue!.title! + ': ' + socialValue!.valueType! + socialValue!.value!.toString() + ' ' + socialValue!.trailingValueType! + '   >', textScaleFactor: 0.8, maxLines: 1, overflow: TextOverflow.clip, style: TextStyle(color: primaryColor)),
                  ],
                ),
              ),
            ),
            // ),
          ]
      )
        )
      );


  }
}
