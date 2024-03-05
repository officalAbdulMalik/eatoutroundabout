import 'package:eatoutroundabout/models/account_model.dart';
import 'package:eatoutroundabout/models/venue_model.dart';
import 'package:eatoutroundabout/services/cloud_function.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/services/util_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/custom_list_tile.dart';
import 'package:eatoutroundabout/widgets/empty_box.dart';
import 'package:eatoutroundabout/widgets/heading.dart';
import 'package:eatoutroundabout/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class ApproveVenues extends StatefulWidget {
  @override
  State<ApproveVenues> createState() => _ApproveVenuesState();
}

class _ApproveVenuesState extends State<ApproveVenues> {
  final firestoreService = Get.find<FirestoreService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(title: Image.asset('assets/images/applogo.png', height: AppBar().preferredSize.height - 15), backgroundColor: primaryColor),
      body: Column(
        children: [
          Heading(title: 'APPROVE VENUES'),
          Expanded(
            child: showVenueList(),
          ),
        ],
      ),
    );
  }

  showVenueList() {
    return PaginateFirestore(
      isLive: true,
      key: GlobalKey(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      itemBuilderType: PaginateBuilderType.listView,
      itemBuilder: (context, documentSnapshot, i) {
        Venue venue = documentSnapshot[i].data() as Venue;
        return CustomListTile(
          title: Text(venue.venueName!),
          trailing: Text('VIEW', textScaleFactor: 0.8, style: TextStyle(color: greenColor)),
          onTap: () {
            final dialogService = Get.find<UtilService>();

            Get.defaultDialog(
              radius: padding / 2,
              title: 'Venue Information',
              content: Text(
                'Venue Name:${venue.venueName}\n\n' + 'Address:${venue.streetAddress}\n\n' + 'Town:${venue.townCity}\n\n' + 'PostCode:${venue.postCode}\n\n' + 'Telephone Number:${venue.venuePhoneNumber}\n\n',
              ),
              actions: [
                TextButton(
                    onPressed: () async {
                      Get.back();
                      dialogService.showLoading();
                      await cloudFunction(functionName: 'approveVenue', parameters: {'venueID': venue.venueID}, action: () => Get.back());
                    },
                    child: Text('APPROVE')),
                TextButton(
                    onPressed: () async {
                      Get.back();
                    },
                    child: Text('CANCEL', style: TextStyle(color: Colors.grey))),
              ],
            );
          },
        );
      },
      query: firestoreService.getUnapprovedVenuesQuery(),
      onEmpty: EmptyBox(text: 'No venues to show'),
      itemsPerPage: 10,
      bottomLoader: LoadingData(),
      initialLoader: LoadingData(),
    );
  }
}
