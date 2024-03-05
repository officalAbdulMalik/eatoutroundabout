import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatoutroundabout/models/referrals.dart';
import 'package:eatoutroundabout/models/users_model.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReferralItem extends StatelessWidget {
  final Referrals? referrals;
  final firestoreService = Get.find<FirestoreService>();

  ReferralItem({this.referrals});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: () => Get.to(()=> VenueDetails()),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(padding),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(referrals!.referralAccountID!, style: TextStyle(color: greenColor, fontWeight: FontWeight.bold)),
                    Text('Referral Date', textScaleFactor: 0.8, style: TextStyle(color: greenColor)),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateFormat('dd MMMM yyyy, hh:mm a').format(referrals!.referralDate!.toDate()), textScaleFactor: 0.9, style: TextStyle(color: greenColor)),
                    FutureBuilder(
                        future: firestoreService.getUser(referrals!.referralUserID),
                        builder: (context, AsyncSnapshot<DocumentSnapshot<User>> snapshot) {
                          if (snapshot.hasData) {
                            User? user = snapshot.data!.data();
                            return Text('Referred by : ' + user!.firstName!, textScaleFactor: 0.9, maxLines: 1, style: TextStyle(color: primaryColor));
                          } else
                            return Container();
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
