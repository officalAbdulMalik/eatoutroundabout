import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatoutroundabout/models/evidence_model.dart';
import 'package:eatoutroundabout/models/self_billing_model.dart';
import 'package:eatoutroundabout/models/social_value_model.dart';
import 'package:eatoutroundabout/screens/admin/account/batch_orders.dart';
import 'package:eatoutroundabout/widgets/evidence_item.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/empty_box.dart';
import 'package:eatoutroundabout/widgets/heading.dart';
import 'package:eatoutroundabout/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class EvidenceList extends StatelessWidget {
  final SocialValue? socialValue;

  EvidenceList({this.socialValue});
  final firestoreService = Get.find<FirestoreService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Image.asset('assets/images/applogo.png', height: AppBar().preferredSize.height - 15), backgroundColor: primaryColor),
      body: Column(
        children: [
          Heading(title: 'Evidence'),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(padding * 2, padding * 2, padding * 2, 0),
              color: appBackground,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(child: Text(socialValue!.title!.toUpperCase() + ' EVIDENCE TOKENS')),
                    SizedBox(height: padding),
                    PaginateFirestore(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      isLive: true,
                      key: GlobalKey(),
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      itemBuilderType: PaginateBuilderType.listView,
                      itemBuilder: (context, documentSnapshot, i) {
                        Evidence evidenceItems = documentSnapshot[i].data() as Evidence;
                        return
                          EvidenceItem(evidence: evidenceItems, isMyEvidence : true);
                      },
                      query: firestoreService
                          .getSocialValueEvidence(socialValue!.ID!),
                      onEmpty: Padding(
                        padding: EdgeInsets.only(
                            bottom: Get.height / 2 - 200, left: 25, right: 25),
                        child: Text(
                          'No evidence to show',
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
