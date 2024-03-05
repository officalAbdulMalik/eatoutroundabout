import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatoutroundabout/controllers/user_controller.dart';
import 'package:eatoutroundabout/models/business_profile.dart';
import 'package:eatoutroundabout/models/venue_model.dart';
import 'package:eatoutroundabout/screens/admin/business/add_business_profile.dart';
import 'package:eatoutroundabout/screens/admin/business/business_dashboard.dart';
import 'package:eatoutroundabout/screens/admin/account/edit_account.dart';
import 'package:eatoutroundabout/screens/admin/partners/community_dashboard.dart';
import 'package:eatoutroundabout/screens/admin/partners/hospitality_dashboard.dart';
import 'package:eatoutroundabout/screens/admin/partners/recruitment_partner_dashboard.dart';
import 'package:eatoutroundabout/screens/admin/venue/venue_home.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/services/util_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/business_profile_item.dart';
import 'package:eatoutroundabout/widgets/heading.dart';
import 'package:eatoutroundabout/widgets/powered_by.dart';
import 'package:eatoutroundabout/widgets/venue_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:eatoutroundabout/widgets/custom_button.dart';
import 'package:eatoutroundabout/screens/admin/venue/add_a_venue.dart';


class AdminHome extends StatelessWidget {
  final userController = Get.find<UserController>();
  final firestoreService = Get.find<FirestoreService>();
  final utilService = Get.find<UtilService>();

  final String? featured = 'business';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Heading(title: 'Social Value'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (userController.isBusinessAdmin())
                  IconButton(visualDensity: VisualDensity.compact, icon: Icon(Icons.settings, color: primaryColor), onPressed: () => {Get.to(() => EditAccount())}),
               if (userController.isBusinessAdmin())
                  IconButton(visualDensity: VisualDensity.compact, icon: Icon(Icons.add, color: primaryColor), onPressed: () => {Get.to(() => AddBusinessProfile())}),
                if (userController.isBusinessAdmin())
                  IconButton(visualDensity: VisualDensity.compact, icon: Icon(Icons.file_open, color: primaryColor), onPressed: () => {Get.to(() => AddBusinessProfile())}),

              ],
            ),
          ),
          Expanded(
            child: Container(
              color: appBackground,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20),
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
                        'Promote your social value on Eat Out Round About!',
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          PoweredBy(featuredType: featured),
        ],
      ),
    );
  }

  buildList(List venues) {
    print(venues);
    return ListView.builder(
      itemCount: venues.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, i) {
        return FutureBuilder(
          builder: (context, AsyncSnapshot<DocumentSnapshot<Venue>> snapshot) {
            if (snapshot.hasData) {
              Venue venue = snapshot.data!.data() as Venue;
              return VenueItem(venue: venue, isMyVenue: true);
            } else
              return Container();
          },
          future: firestoreService.getVenueByVenueID(venues[i]),
        );
      },
    );
  }
}
