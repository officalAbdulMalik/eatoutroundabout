import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatoutroundabout/controllers/user_controller.dart';
import 'package:eatoutroundabout/models/business_profile.dart';
import 'package:eatoutroundabout/screens/admin/staff_benefit/staff_benefits.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/custom_button.dart';
import 'package:eatoutroundabout/widgets/heading.dart';
import 'package:eatoutroundabout/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProjectsDashboard extends StatelessWidget {
  final BusinessProfile? businessProfile;
  final int? userType;


  ProjectsDashboard({this.businessProfile, this.userType});

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
                  Heading(title: 'PROJECTS & REPORTS'),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    color: appBackground,
                    height: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(businessProfile.businessName!, textScaleFactor: 1.25, textAlign: TextAlign.center, style: TextStyle(color: purpleColor, fontWeight: FontWeight.bold)),
                        ),
                        ],
                    ),
                  ),
                  Divider(height: 1),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(padding * 2, padding * 2, padding * 2, 0),
                      color: appBackground,
                      child: SingleChildScrollView(

                        child: Column(
                          children: [

                            // if (userController.isBusinessAdmin())
                              // CustomButton(
                              //   icon: Icon(Icons.restaurant, color: Colors.white),
                              //   text: 'Social Projects',
                              //   function: () => Get.to(() => ProjectsList(businessProfile: businessProfile!)),
                              // ),
                            // CustomButton(
                            //   icon: Icon(Icons.restaurant, color: Colors.white),
                            //   text: 'Staff Social Value',
                            //   function: () => Get.to(() => SocialValueProjectList(businessProfile: businessProfile!)),
                            // ),
                            Divider(height: 50, color: Colors.grey),
                            CustomButton(
                              icon: Icon(Icons.people_alt_outlined, color: Colors.white),
                              text: 'Staff Benefits',
                              function: () => Get.to(() => StaffBenefitsList(businessProfile: businessProfile!)),
                            ),
                            Divider(height: 50, color: Colors.grey),

                            //MyProductsButton(businessProfile: businessProfile),
                            SizedBox(height: padding),
                            // CustomButton(
                            //   text: 'Create a Pop-Up event',
                            //   function: () => Get.to(() => MyEventsButton()),
                            // ),

                            SizedBox(height: padding),
                            // CustomButton(
                            //   text: 'Add Offers',
                            //   color: purpleColor,
                            //   function: () => Get.to(() => OfferDashboard(businessProfile: businessProfile)),
                            // ),
                            // SizedBox(height: padding),
                            // CustomButton(
                            //   text: 'Add Community',
                            //   color: blueColor,
                            //   function: () => Get.to(() => CommunitiesDashboard(businessProfile: businessProfile)),
                            // ),
                            //MyOffersButton(businessProfile: businessProfile),
                            //   CustomButton(
                            //     color: primaryColor,
                            //     text: 'Manage Staff',
                            //     function: () => Get.to(() => AddBusinessStaff(businessProfile: businessProfile)),
                            //   ),
                            // SizedBox(height: padding),
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
