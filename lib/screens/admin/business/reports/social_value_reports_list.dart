import 'package:eatoutroundabout/controllers/user_controller.dart';
import 'package:eatoutroundabout/models/business_profile.dart';
import 'package:eatoutroundabout/models/product_model.dart';
import 'package:eatoutroundabout/models/projects_model.dart';
import 'package:eatoutroundabout/models/social_value_framework_item.dart';
import 'package:eatoutroundabout/models/social_value_model.dart';
import 'package:eatoutroundabout/screens/admin/product/add_product.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/services/util_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/custom_button.dart';
import 'package:eatoutroundabout/widgets/heading.dart';
import 'package:eatoutroundabout/widgets/loading.dart';
import 'package:eatoutroundabout/widgets/product_item.dart';
import 'package:eatoutroundabout/widgets/project_item.dart';
import 'package:eatoutroundabout/widgets/sv_report_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class SocialValueList extends StatelessWidget {
  final Projects? projects;
  final SocialValueFrameworkItem? socialValueFrameworkItem;
  final SocialValue? socialValue;
  final bool? isMySocialValue;


  SocialValueList({this.projects,this.socialValue, this.isMySocialValue, this.socialValueFrameworkItem});

  final firestoreService = Get.find<FirestoreService>();
  final userController = Get.find<UserController>();
  final miscService = Get.find<UtilService>();
  var formatter = NumberFormat('#,##,000');

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Image.asset('assets/images/applogo.png',
              height: AppBar().preferredSize.height - 15)),
      body: Column(
        children: [
          Heading(title: 'Social Value'),
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
