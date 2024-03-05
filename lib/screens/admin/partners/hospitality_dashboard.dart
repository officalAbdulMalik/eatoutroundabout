import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:eatoutroundabout/controllers/user_controller.dart';
import 'package:eatoutroundabout/models/business_profile.dart';
import 'package:eatoutroundabout/screens/admin/business/add_business_profile.dart';
import 'package:eatoutroundabout/screens/admin/partners/community_comission_history.dart';
import 'package:eatoutroundabout/screens/admin/partners/community_referrals.dart';
import 'package:eatoutroundabout/screens/auth/section_splash.dart';
import 'package:eatoutroundabout/services/cloud_function.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/business_profile_item.dart';
import 'package:eatoutroundabout/widgets/custom_button.dart';
import 'package:eatoutroundabout/widgets/heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HospitalityPartnerDashboard extends StatelessWidget {
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
          Heading(title: 'HOSPITALITY PARTNER'),
          Expanded(
            child: Container(
              color: appBackground,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                   // if (userController.isHospitalityPartnerUser())
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Give this referral code to employers to use when they register their account so we can assign your commission. Please ensure they are aware that you gain financially from the referral.*'),
                      ),
                      SizedBox(height: 30),
                      DottedBorder(
                        color: Colors.black,
                        dashPattern: [8, 4],
                        strokeWidth: 3,
                        strokeCap: StrokeCap.butt,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(userController.currentUser.value.userReferralCode!, textScaleFactor: 2.5, style: TextStyle(fontWeight: FontWeight.bold, color: redColor)),
                        ),
                      ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('*This code is personal to you and commissions assigned to the account'),
                    ),

                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(padding),
                      child: CustomButton(
                        icon: Icon(Icons.people, color: Colors.white),
                        color: purpleColor,
                        text: 'Referrals Reports (Coming soon)',
                        function: () => Get.to(() => CommunityReferrals()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(padding),
                      child: CustomButton(
                        icon: Icon(Icons.people, color: Colors.white),
                        color: purpleColor,
                        text: 'Payment History (Coming soon)',
                        function: () => Get.to(() => CommunityComissionHistory()),
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
