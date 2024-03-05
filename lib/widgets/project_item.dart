import 'package:eatoutroundabout/models/projects_model.dart';
import 'package:eatoutroundabout/screens/admin/business/reports/framework_items_list.dart';
import 'package:eatoutroundabout/screens/admin/business/projects/view_social_value_project.dart';
import 'package:eatoutroundabout/services/util_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProjectItem extends StatelessWidget {
  final Projects? projects;
  final bool? isMyProject;

  ProjectItem({this.projects, this.isMyProject});
  final miscService = Get.find<UtilService>();
  var formatter = NumberFormat('#,##,000');

  @override
  Widget build(BuildContext context) {
    num number = projects!.totalImpact!;
    String output = NumberFormat.decimalPattern().format(number);
    return
      InkWell(
        onTap: () {
          if (isMyProject ?? false)
            Get.to(() => FrameworkItemsList(projects: projects!));
          else
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ViewProject(projects: projects)));
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
                    CachedImage(
                      url: projects!.logo! == '' ? 'assets/images/logo.png' : projects!.logo!,
                      height: 80,
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(projects!.projectName!, textScaleFactor: 0.9, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(child: Text('Project type: ' + projects!.projectType!.toUpperCase(), textScaleFactor: 0.85,  overflow: TextOverflow.ellipsis, style: TextStyle(color: greenColor))),
                            ],
                          ),


                            Row(
                            children: [
                              Expanded(child: Text('Location: ' + projects!.region!, textScaleFactor: 0.85, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: greenColor))),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: Text('Social value: £' + output + '+ social value', textScaleFactor: 0.85, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: greenColor))),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: Text(textScaleFactor: 0.85,maxLines: 1, overflow: TextOverflow.ellipsis, 'End Date : ' + DateFormat('dd MMM yyyy').format(projects!.creationDate!.toDate())
                              )),
                            ],
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
      );


  }
}
