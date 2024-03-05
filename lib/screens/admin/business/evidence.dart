
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatoutroundabout/models/social_value_model.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/services/util_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/heading.dart';
import 'package:eatoutroundabout/models/business_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eatoutroundabout/widgets/loading.dart';
import 'package:eatoutroundabout/controllers/user_controller.dart';


class EvidenceNotUsing extends StatelessWidget {
  final SocialValue? socialValue;
  final BusinessProfile? businessProfile;
  final bool? isMyBusinessProfile;

  EvidenceNotUsing(
      {this.businessProfile, this.isMyBusinessProfile,this.socialValue});


  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
            title: Image.asset('assets/images/applogo.png',
                height: AppBar().preferredSize.height - 15)),
        body:
        //DefaultTabController(length: 3, child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Heading(title: 'EMPLOYEE BENEFIT'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Coming Soon", textScaleFactor: 1.35),
            ),
          ],
        ),
        // ),
      );
  }
}