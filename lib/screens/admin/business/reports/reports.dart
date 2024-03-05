import 'package:eatoutroundabout/controllers/user_controller.dart';
import 'package:eatoutroundabout/models/business_profile.dart';
import 'package:eatoutroundabout/models/product_model.dart';
import 'package:eatoutroundabout/models/projects_model.dart';
import 'package:eatoutroundabout/models/social_value_model.dart';
import 'package:eatoutroundabout/screens/admin/product/add_product.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/custom_button.dart';
import 'package:eatoutroundabout/widgets/heading.dart';
import 'package:eatoutroundabout/widgets/loading.dart';
import 'package:eatoutroundabout/widgets/product_item.dart';
import 'package:eatoutroundabout/widgets/project_item.dart';
import 'package:eatoutroundabout/widgets/report_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class SocialValueProjectList extends StatelessWidget {
  final Projects? projects;

  SocialValueProjectList({this.projects});

  final userController = Get.find<UserController>();
  final firestoreService = Get.find<FirestoreService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Image.asset('assets/images/applogo.png',
              height: AppBar().preferredSize.height - 15)),
      body: Column(
        children: [
          Heading(title: 'Social Value Reports'),
          Expanded(
            child: Container(
              color: appBackground,
              child: SingleChildScrollView(
                // child: Column(
                //   children: [
                //
                //     PaginateFirestore(
                //       physics: NeverScrollableScrollPhysics(),
                //       shrinkWrap: true,
                //       isLive: true,
                //       key: GlobalKey(),
                //       padding: EdgeInsets.symmetric(horizontal: padding),
                //       itemBuilderType: PaginateBuilderType.listView,
                //       itemBuilder: (context, documentSnapshot, i) {
                //         SocialValue socialValue = documentSnapshot[i].data() as SocialValue;
                //         return ReportItem(socialValue: socialValue, isMySocialValue: true);
                //       },
                //       query: firestoreService
                //           .getMySocialValue(socialValueProjects!.businessProfileID!),
                //       onEmpty: Padding(
                //         padding: EdgeInsets.only(
                //             bottom: Get.height / 2 - 200, left: 25, right: 25),
                //         child: Text(
                //           'No projects to show',
                //           textAlign: TextAlign.center,
                //           textScaleFactor: 1.15,
                //         ),
                //       ),
                //       itemsPerPage: 10,
                //       bottomLoader: LoadingData(),
                //       initialLoader: LoadingData(),
                //     ),
                //   ],
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}