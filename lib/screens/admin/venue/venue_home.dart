import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatoutroundabout/controllers/user_controller.dart';
import 'package:eatoutroundabout/models/business_profile.dart';
import 'package:eatoutroundabout/models/venue_model.dart';
import 'package:eatoutroundabout/screens/admin/account/edit_account.dart';
import 'package:eatoutroundabout/screens/admin/admin_home.dart';
import 'package:eatoutroundabout/screens/admin/business/add_business_profile.dart';
import 'package:eatoutroundabout/screens/admin/venue/add_a_venue.dart';
import 'package:eatoutroundabout/screens/auth/section_splash.dart';
import 'package:eatoutroundabout/services/cloud_function.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/business_profile_item.dart';
import 'package:eatoutroundabout/widgets/custom_button.dart';
import 'package:eatoutroundabout/widgets/heading.dart';
import 'package:eatoutroundabout/widgets/powered_by.dart';
import 'package:eatoutroundabout/widgets/venue_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class VenueHome extends StatelessWidget {
  final userController = Get.find<UserController>();
  final firestoreService = Get.find<FirestoreService>();
  //final utilService = Get.find<UtilService>();

  final String? featured = 'venue';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Image.asset('assets/images/applogo.png', height: AppBar().preferredSize.height - 15),
      //   actions: [
      //     IconButton(onPressed: () => utilService.openLink('https://wa.me/message/IC4Q25UGDJGZA1'), icon: Icon(Icons.help_outline_rounded)),
      //   ],
      // ),
      body: Column(
        children: [
          Heading(title: 'VENUE ADMIN'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (userController.isVenueAdmin())
                  IconButton(visualDensity: VisualDensity.compact, icon: Icon(Icons.settings, color: primaryColor), onPressed: () => {Get.to(() => EditAccount())}),
                if (userController.isVenueAdmin())
                  IconButton(visualDensity: VisualDensity.compact, icon: Icon(Icons.add, color: primaryColor), onPressed: () => {Get.to(() => AddNewVenue())}),
              ],
            ),
          ),
          Expanded(
            child: Obx(
                  () {
                return Container(
                  color: appBackground,
                  child: userController.isVenueStaff()
                      ? ListView.builder(
                    padding: const EdgeInsets.only(top: padding),
                    itemCount: userController.currentUser.value.venueStaff!.length,
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
                        future: firestoreService.getVenueByVenueID(userController.currentUser.value.venueStaff![i]),
                      );
                    },
                  )
                      : SingleChildScrollView(
                    padding: const EdgeInsets.all(padding),
                    child: Column(
                      children: [
                        SizedBox(height: padding),
                        buildList((userController.currentUser.value.accountAdmin! + userController.currentUser.value.venueAdmin! + userController.currentUser.value.venueStaff!).toSet().toList()),
                      ],
                    ),
                  ),
                );
              },
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



