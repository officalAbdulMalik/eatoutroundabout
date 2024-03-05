import 'package:eatoutroundabout/controllers/user_controller.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/empty_box.dart';
import 'package:eatoutroundabout/widgets/heading.dart';
import 'package:eatoutroundabout/widgets/loading.dart';
import 'package:eatoutroundabout/widgets/referral_item.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SkillsRequirements extends StatefulWidget {
  final userController = Get.find<UserController>();

  @override
  _SkillsRequirementsState createState() => _SkillsRequirementsState();
}

class _SkillsRequirementsState extends State<SkillsRequirements> {
  final communityReferralService = Get.find<FirestoreService>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Image.asset('assets/images/applogo.png', height: AppBar().preferredSize.height - 15), backgroundColor: primaryColor),
      body: Column(
        children: <Widget>[
          Heading(title: 'Skills Demand', textScaleFactor: 1.5),
          Text('Coming Soon'),
          // Expanded(
          //   child: Container(
          //       width: double.infinity,
          //       child: StreamBuilder(
          //           stream: communityReferralService.getCommunityReferrals(userController.currentUser.value
          //               .accountID),
          //           builder: (context, AsyncSnapshot<QuerySnapshot<Referrals>> snapshot) {
          //             if (snapshot.hasData)
          //               return snapshot.data!.docs.isNotEmpty
          //                   ? ListView.builder(
          //                 padding: EdgeInsets.all(padding),
          //                 itemCount: snapshot.data!.docs.length,
          //                 itemBuilder: (context, i) {
          //                   return ReferralItem(referrals: snapshot.data!.docs[i].data());
          //                 },
          //               )
          //                   : EmptyBox(text: 'No referrals yet');
          //             else
          //               return LoadingData();
          //           })),
          // ),
        ],
      ),
    );
  }
}
