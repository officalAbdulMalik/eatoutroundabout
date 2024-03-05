import 'package:eatoutroundabout/models/social_value_model.dart';
import 'package:eatoutroundabout/screens/admin/business/projects/view_social_value_project.dart';
import 'package:eatoutroundabout/services/util_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ReportItem extends StatelessWidget {
  final SocialValue? socialValue;
  final bool? isMySocialValue;

  ReportItem({this.socialValue, this.isMySocialValue});
  final miscService = Get.find<UtilService>();

  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: () {
          if (isMySocialValue ?? false)
            Get.to(() => ReportItem(socialValue: socialValue));
          else
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ViewProject()));
        },
        child: Container(
          margin: EdgeInsets.only(bottom: padding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(padding / 2),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 10),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(padding / 2), bottomRight: Radius.circular(padding / 2)),
                  color: Colors.white,
                ),
                child: Row(
                  children: [

                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(socialValue!.impactProjectID!.toString(), textScaleFactor: 0.9, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
                          // SizedBox(height: 5),
                          // Row(
                          //   children: [
                          //     Expanded(child: Text(socialValue!.impactProjectID!, textScaleFactor: 0.85, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: greenColor))),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );


  }
}
