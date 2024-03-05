import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatoutroundabout/models/account_model.dart';
import 'package:eatoutroundabout/models/beneficiary_projects_model.dart';
import 'package:eatoutroundabout/models/business_profile.dart';
import 'package:eatoutroundabout/models/orders.dart';
import 'package:eatoutroundabout/models/user_vouchers_model.dart';
import 'package:eatoutroundabout/models/users_model.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../screens/admin/account/orders.dart';

class OrdersItem extends StatelessWidget {
  final Orders? orders;
  final firestoreService = Get.find<FirestoreService>();

  OrdersItem({this.orders});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: () => Get.to(()=> VenueDetails()),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(padding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Order date:   ", textScaleFactor: 0.8, style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold)),
                        Text(DateFormat('dd MMMM yyyy, hh:mm a').format(orders!.creationDate!.toDate()), textScaleFactor: 0.8, style: TextStyle(color: primaryColor)),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Text("Order item:   ", textScaleFactor: 0.8, style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold)),
                        Text(orders!.membershipQty.toString()!, textScaleFactor: 0.8, style: TextStyle(color: primaryColor)),
                        Text(" " + orders!.orderType.toString()!, textScaleFactor: 0.8, style: TextStyle(color: primaryColor)),

                      ],
                    ),

                    SizedBox(height: 10),


                    Row(
                      children: [
                        FutureBuilder(
                            future: firestoreService.getBeneficiaryProject(orders!.beneficiaryProjectID),
                            builder: (context, AsyncSnapshot<DocumentSnapshot<BeneficiaryProjects>> snapshot) {
                              if (snapshot.hasData) {
                                BeneficiaryProjects? beneficiaryProjects = snapshot.data!.data();
                                return Row(
                                  children: [
                                    Text("Social Value Project:  ", textScaleFactor: 0.8, style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold)),
                                    CachedImage(url: beneficiaryProjects!.logo!, height: 30),
                                    Text(" " + beneficiaryProjects!.beneficiaryProjectName!, textScaleFactor: 0.8, maxLines: 1, style: TextStyle(color: primaryColor)),
                                  ],
                                );

                              } else
                                return Text('No results');
                            }),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(DateFormat('dd MMMM yyyy, hh:mm a').format(userVoucher!.redeemedDate!.toDate()), textScaleFactor: 0.9, style: TextStyle(color: greenColor)),
                              FutureBuilder(
                                  future: firestoreService.getBusinessByBusinessID(orders!.businessProfileID!),
                                  builder: (context, AsyncSnapshot<DocumentSnapshot<BusinessProfile>> snapshot) {
                                    if (snapshot.hasData) {
                                      BusinessProfile? businessProfile = snapshot.data!.data();
                                      return Row(
                                        children: [
                                          //CachedImage(url: businessProfile!.logo!, height: 30),
                                          Text("Profile: ", textScaleFactor: 0.8, maxLines: 1, style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold)),
                                          Text(" " + businessProfile!.businessName!, textScaleFactor: 0.8, maxLines: 1, style: TextStyle(color: primaryColor)),
                                        ],
                                      );

                                    } else
                                      return Text('didn\'t work');
                                  }),
                              SizedBox(height: 15),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if(orders!.status == 'order placed' || orders!.status == 'processing' || orders!.status == 'invoice issued')
                                  Expanded(
                                    child: Text("Status: " + orders!.status.toString()!, textScaleFactor: 0.8, style: TextStyle(color: orangeColor, fontStyle: FontStyle.italic)),
                                  ),
                                  if(orders!.status == 'overdue invoice')
                                    Expanded(
                                      child: Text("Status: " + orders!.status.toString()!, textScaleFactor: 0.8, style: TextStyle(color: redColor, fontStyle: FontStyle.italic)),
                                    ),
                                  if(orders!.status == 'complete')
                                    Expanded(
                                      child: Text("Status: " + orders!.status.toString()!, textScaleFactor: 0.8, style: TextStyle(color: blueColor, fontStyle: FontStyle.italic)),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                    ],

                ),
              ),

      ]),
    )
      )
    );
  }
}
