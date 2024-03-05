import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:eatoutroundabout/controllers/user_controller.dart';
import 'package:eatoutroundabout/models/business_profile.dart';
import 'package:eatoutroundabout/screens/admin/business/add_business_profile.dart';
import 'package:eatoutroundabout/screens/admin/partners/community_comission_history.dart';
import 'package:eatoutroundabout/screens/admin/partners/community_referrals.dart';
import 'package:eatoutroundabout/screens/admin/partners/skills_requirements.dart';
import 'package:eatoutroundabout/screens/auth/section_splash.dart';
import 'package:eatoutroundabout/services/cloud_function.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/business_profile_item.dart';
import 'package:eatoutroundabout/widgets/custom_button.dart';
import 'package:eatoutroundabout/widgets/heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecruitmentPartnerDashboard extends StatelessWidget {
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
          Heading(title: 'RECRUITMENT PARTNER'),
          Expanded(
            child: Container(
              color: appBackground,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                 //   if (userController.isCommunityPartnerUser())

                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(padding),
                      child: CustomButton(
                        icon: Icon(Icons.person, color: Colors.white),
                        color: purpleColor,
                        text: 'View vacancy opportunities',
                        function: () => Get.to(() => CommunityReferrals()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(padding),
                      child: CustomButton(
                        icon: Icon(Icons.restaurant, color: Colors.white),
                        color: purpleColor,
                        text: 'Request Experience',
                        function: () => Get.to(() => CommunityComissionHistory()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(padding),
                      child: CustomButton(
                        icon: Icon(Icons.table_restaurant, color: Colors.white),
                        color: purpleColor,
                        text: 'Skills demand',
                        function: () => Get.to(() => SkillsRequirements()),
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
