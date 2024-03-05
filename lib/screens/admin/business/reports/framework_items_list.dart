import 'package:eatoutroundabout/controllers/user_controller.dart';
import 'package:eatoutroundabout/models/product_model.dart';
import 'package:eatoutroundabout/models/projects_model.dart';
import 'package:eatoutroundabout/models/social_value_framework_item.dart';
import 'package:eatoutroundabout/screens/venues/view_product.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/services/util_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/cached_image.dart';
import 'package:eatoutroundabout/widgets/framework_item.dart';
import 'package:eatoutroundabout/widgets/heading.dart';
import 'package:eatoutroundabout/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class FrameworkItemsList extends StatelessWidget {
  final Projects? projects;


  //final Evidence? evidenceItem;


  FrameworkItemsList({this.projects});

  final firestoreService = Get.find<FirestoreService>();
  //final userController = Get.find<UserController>();
  //final miscService = Get.find<UtilService>();
  var formatter = NumberFormat('#,##,000');

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Image.asset('assets/images/applogo.png',
              height: AppBar().preferredSize.height - 15)),
      body: Column(
        children: [
          Heading(title: 'Reports'),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(padding * 2, padding * 2, padding * 2, 0),
              color: appBackground,
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    Container(child: Text(projects!.projectName!.toUpperCase() + ' (' + projects!.projectType!.toUpperCase() + ')')),
                    SizedBox(height: padding),
                    PaginateFirestore(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      isLive: true,
                      key: GlobalKey(),
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      itemBuilderType: PaginateBuilderType.listView,
                      itemBuilder: (context, documentSnapshot, i) {
                        SocialValueFrameworkItem frameworkItem = documentSnapshot[i].data() as SocialValueFrameworkItem;
                        return
                          FrameworkItem(socialValueFrameworkItem: frameworkItem, isMyFrameworkItem : true, projects: projects);
                      },
                      query: firestoreService
                          .getFrameworkItems(projects!.frameworkID!),
                      onEmpty: Padding(
                        padding: EdgeInsets.only(
                            bottom: Get.height / 2 - 200, left: 25, right: 25),
                        child: Text(
                          'No frameworks to show',
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.15,
                        ),
                      ),
                      itemsPerPage: 10,
                      bottomLoader: LoadingData(),
                      initialLoader: LoadingData(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
