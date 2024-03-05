import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatoutroundabout/models/popup_model.dart';
import 'package:eatoutroundabout/models/venue_model.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/empty_box.dart';
import 'package:eatoutroundabout/widgets/heading.dart';
import 'package:eatoutroundabout/widgets/loading.dart';
import 'package:eatoutroundabout/widgets/popup_item.dart';
import 'package:eatoutroundabout/widgets/venue_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class PopUpStalls extends StatelessWidget {
  final String? eventID;

  PopUpStalls({this.eventID});

  final firestoreService = Get.find<FirestoreService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(title: Image.asset('assets/images/applogo.png',
          height: AppBar().preferredSize.height - 15),
          backgroundColor: primaryColor),
      body: Column(
        children: [
          Heading(title: 'Pop-Ups'),
          Expanded(
            child: showPopUpsList(),
          ),
        ],
      ),
    );
  }

  showPopUpsList() {
    return
      PaginateFirestore(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        key: GlobalKey(),
        padding: const EdgeInsets.only(bottom: 25, top: 15),
        itemBuilderType: PaginateBuilderType.listView,
        itemBuilder: (context, documentSnapshot, i) {
          PopUp popup = documentSnapshot[i].data() as PopUp;
          return
            PopUpItem(popup: popup, isMyPopup: false);
        },
        query: firestoreService
            .getPopUps(eventID!),
        onEmpty: Padding(
          padding: EdgeInsets.only(
              bottom: Get.height / 2 - 200, left: 25, right: 25),
          child: Text(
            'No popups to show',
            textAlign: TextAlign.center,
            textScaleFactor: 1.15,
          ),
        ),
        itemsPerPage: 10,
        bottomLoader: LoadingData(),
        initialLoader: LoadingData(),
      );
  }

}