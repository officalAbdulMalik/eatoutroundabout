import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatoutroundabout/controllers/user_controller.dart';
import 'package:eatoutroundabout/models/business_profile.dart';
import 'package:eatoutroundabout/models/projects_model.dart';
import 'package:eatoutroundabout/screens/admin/admin_home.dart';
import 'package:eatoutroundabout/screens/admin/business/certificate.dart';
import 'package:eatoutroundabout/screens/admin/business/edit_business_profile.dart';
import 'package:eatoutroundabout/screens/admin/business/projects/projects_list.dart';
import 'package:eatoutroundabout/screens/admin/staff_benefit/employee_benefit.dart';
import 'package:eatoutroundabout/screens/business/view_business_profile.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/cached_image.dart';
import 'package:eatoutroundabout/widgets/custom_button.dart';
import 'package:eatoutroundabout/widgets/heading.dart';
import 'package:eatoutroundabout/widgets/loading.dart';
import 'package:eatoutroundabout/widgets/project_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class ProjectList extends StatelessWidget {
  final BusinessProfile? businessProfile;
  final int? userType;

  ProjectList({this.businessProfile, this.userType});

  final firestoreService = Get.find<FirestoreService>();
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Image.asset('assets/images/applogo.png', height: AppBar().preferredSize.height - 15), backgroundColor: primaryColor),
      body: FutureBuilder(
          future: firestoreService.getBusinessByBusinessID(businessProfile!.businessProfileID!),
          builder: (context, AsyncSnapshot<DocumentSnapshot<BusinessProfile>> snapshot) {
            if (!snapshot.hasData)
              return LoadingData();
            else {
              BusinessProfile businessProfile = snapshot.data!.data() as BusinessProfile;
              return Column(
                children: [
                  Heading(title: 'Projects'),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    color: Colors.white,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CachedImage(
                            url: businessProfile.logo == '' ? 'assets/images/logo.png' : businessProfile.logo,
                            height: 80,
                          ),),
                      ],
                    ),
                  ),
                  Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (userController.isBusinessAdmin())
                          IconButton(visualDensity: VisualDensity.compact, icon: Icon(FontAwesomeIcons.gear, color: primaryColor), onPressed: () => {Get.to(() => EditBusinessProfile(businessProfile: businessProfile))}),
                        if (userController.isBusinessAdmin())
                          IconButton(visualDensity: VisualDensity.compact, icon: Icon(FontAwesomeIcons.eye, color: primaryColor), onPressed: () => {Get.to(() => ViewBusinessProfile(businessProfile: businessProfile))}),
                        if (userController.isBusinessAdmin())
                          IconButton(visualDensity: VisualDensity.compact, icon: Icon(FontAwesomeIcons.certificate, color: primaryColor), onPressed: () => {Get.to(() => ViewSocialValueCertificate(businessProfile: businessProfile))}),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(padding * 2, padding * 2, padding * 2, 0),
                      color: appBackground,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: padding),

                            PaginateFirestore(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              isLive: true,
                              key: GlobalKey(),
                              padding: EdgeInsets.symmetric(horizontal: padding),
                              itemBuilderType: PaginateBuilderType.listView,
                              itemBuilder: (context, documentSnapshot, i) {
                                Projects projects = documentSnapshot[i].data() as Projects;
                                return ProjectItem(projects: projects, isMyProject: true);
                              },
                              query: firestoreService
                                  .getMyProjects(businessProfile!.businessProfileID!),
                              onEmpty: Padding(
                                padding: EdgeInsets.only(
                                    bottom: Get.height / 2 - 200, left: 25, right: 25),
                                child: Text(
                                  'No projects to show',
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
              );
            }
          }),
    );
  }
}
