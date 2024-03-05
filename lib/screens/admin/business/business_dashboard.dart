import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatoutroundabout/controllers/user_controller.dart';
import 'package:eatoutroundabout/models/business_profile.dart';
import 'package:eatoutroundabout/screens/admin/admin_home.dart';
import 'package:eatoutroundabout/screens/admin/business/add_business_profile.dart';
import 'package:eatoutroundabout/screens/auth/section_splash.dart';
import 'package:eatoutroundabout/services/cloud_function.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/business_profile_item.dart';
import 'package:eatoutroundabout/widgets/custom_button.dart';
import 'package:eatoutroundabout/widgets/heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessDashboard extends StatelessWidget {
  final userController = Get.find<UserController>();
  final firestoreService = Get.find<FirestoreService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/applogo.png', height: AppBar().preferredSize.height - 15),
        actions: [
          IconButton(onPressed: () => utilService.openLink('https://wa.me/message/IC4Q25UGDJGZA1'), icon: Icon(Icons.help_outline_rounded)),
        ],
      ),
      body: Column(
        children: [
          Heading(title: 'SELECT A PROFILE'),
          Expanded(
            child: Container(
              color: appBackground,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // if (userController.isAccountAdmin())
                    //   Padding(
                    //     padding: const EdgeInsets.all(padding),
                    //     child: CustomButton(
                    //       color: purpleColor,
                    //       text: 'Add Social Value Profile',
                    //       function: () => Get.to(
                    //         () => SectionSplash(
                    //           title: 'Create a Social ',
                    //           description: 'Promote your business on Eat Out Round About for free, helping you connect your business in the local economy, enjoy good food as you go and open more promotional features!',
                    //           image: 'assets/images/add_business.png',
                    //           function: () {
                    //             if (userController.currentUser.value.businessProfileAdmin!.length == 0)
                    //               Get.off(() => AddBusinessProfile());
                    //             else {
                    //               if (userController.currentAccount.value.membership == 'banquet' || userController.currentAccount.value.membership == 'mainCourse')
                    //                 Get.off(() => AddBusinessProfile());
                    //               else
                    //                 utilService.showUnlockDialog(10, VIEW_MEMBERSHIP, 'You need a Main Course or a Banquet membership to add more than one business profile.');
                    //             }
                    //           },
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    userController.currentUser.value.businessProfileAdmin!.length > 0
                        ? Obx(() {
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: padding),
                        itemCount: userController.currentUser.value.businessProfileAdmin!.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return FutureBuilder(
                            builder: (context, AsyncSnapshot<DocumentSnapshot<BusinessProfile>> snapshot) {
                              if (snapshot.hasData) {
                                BusinessProfile businessProfile = snapshot.data!.data() as BusinessProfile;
                                return BusinessProfileItem(businessProfile: businessProfile, isMyBusinessProfile: true);
                              } else
                                return Container();
                            },
                            future: firestoreService.getBusinessByBusinessID(userController.currentUser.value.businessProfileAdmin![i]),
                          );
                        },
                      );
                    })
                        : Padding(
                      padding: EdgeInsets.only(top: Get.height / 2 - 200, left: 25, right: 25),
                      child: Text(
                        'Track and promote your social value on Eat Out Round About!',
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.15,
                      ),
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
