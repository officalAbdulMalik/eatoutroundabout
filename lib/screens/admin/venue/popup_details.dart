import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:eatoutroundabout/controllers/user_controller.dart';
import 'package:eatoutroundabout/models/popup_model.dart';
import 'package:eatoutroundabout/models/venue_model.dart';
import 'package:eatoutroundabout/screens/admin/venue/add_staff.dart';
import 'package:eatoutroundabout/screens/admin/venue/edit_a_venue.dart';
import 'package:eatoutroundabout/screens/admin/venue/manage_products.dart';
import 'package:eatoutroundabout/screens/admin/venue/my_redemptions.dart';
import 'package:eatoutroundabout/screens/admin/venue/venue_orders.dart';
import 'package:eatoutroundabout/screens/vouchers/enter_amount.dart';
import 'package:eatoutroundabout/services/cloud_function.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/custom_button.dart';
import 'package:eatoutroundabout/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PopUpDetails extends StatefulWidget {
  final PopUp? popup;
  final String? userType;

  PopUpDetails({this.popup, this.userType});

  @override
  _PopUpDetailsState createState() => _PopUpDetailsState();
}

class _PopUpDetailsState extends State<PopUpDetails> {
  bool switchState = false;
  final userController = Get.find<UserController>();

  final firestoreService = Get.find<FirestoreService>();
  RxBool pausedVoucherRedemption = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Image.asset('assets/images/applogo.png', height: AppBar().preferredSize.height - 15), backgroundColor: primaryColor),
      body: FutureBuilder(
          future: firestoreService.getPopUpByPopUpID(widget.popup!.popupID!),
          builder: (context, AsyncSnapshot<DocumentSnapshot<PopUp>> snapshot) {
            if (!snapshot.hasData)
              return LoadingData();
            else {
              PopUp popup = snapshot.data!.data() as PopUp;
              pausedVoucherRedemption.value = popup.paused!;
              return Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    color: Colors.white,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(popup.popupName!, textScaleFactor: 1.25, textAlign: TextAlign.center, style: TextStyle(color: orangeColor, fontWeight: FontWeight.bold)),
                        ),
                       ],
                    ),
                  ),
                  Divider(height: 1),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(padding * 2, padding * 2, padding * 2, 0),
                      color: appBackground,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            if (userController.isVenueAdmin())
                              Column(
                                children: [
                                  SizedBox(height: padding),
                                  Text('Manage Venue'),
                                  SizedBox(height: padding),
                                  // CustomButton(
                                  //   color: greenColor,
                                  //   text: 'General details',
                                  //   function: () => Get.off(() => EditAVenue(venue: venue)),
                                  // ),
                                  SizedBox(height: padding),
                                  // CustomButton(
                                  //   color: greenColor,
                                  //   text: 'Marketing details',
                                  //   function: () => Get.off(() => EditAVenue(venue: venue)),
                                  // ),
                                  SizedBox(height: padding),
                                ],
                              ),
                            // CustomButton(
                            //   color: greenColor,
                            //   text: 'Sustainability',
                            //   function: () => redeemVoucher(venue),
                            // ),
                            SizedBox(height: padding),
                            // CustomButton(
                            //   color: greenColor,
                            //   text: 'Equality and diversity',
                            //   function: () => redeemVoucher(venue),
                            // ),
                            //SizedBox(height: padding),
                            // CustomButton(
                            //   color: greenColor,
                            //   text: 'Facilities',
                            //   function: () => redeemVoucher(venue),
                            // ),
                            SizedBox(height: padding),
                            Divider(height: 50, color: Colors.grey),
                            // CustomButton(
                            //   color: primaryColor,
                            //   text: 'Employment and Skills',
                            //   function: () => redeemVoucher(venue),
                            // ),
                            // SizedBox(height: padding),
                            // CustomButton(
                            //   color: primaryColor,
                            //   text: 'Employee Retention',
                            //   function: () => redeemVoucher(venue),
                            // ),
                            SizedBox(height: padding),
                            // CustomButton(
                            //   color: primaryColor,
                            //   text: 'Reports & Insights',
                            //   function: () => redeemVoucher(venue),
                            // ),
                            //SizedBox(height: padding),
                            // CustomButton(
                            //   color: primaryColor,
                            //   text: 'Manage Voucher Offers',
                            //   function: () => redeemVoucher(venue),
                            // ),
                            // SizedBox(height: padding),
                            // CustomButton(
                            //   color: greenColor,
                            //   text: 'Manage Venue',
                            //   function: () => Get.off(() => EditAVenue(venue: venue)),
                            // ),
                            // SizedBox(height: padding),
                            // CustomButton(
                            //   color: primaryColor,
                            //   text: 'My Redemptions',
                            //   function: () => Get.to(() => MyRedemptions(venue: venue)),
                            // ),
                            SizedBox(height: padding),
                            if (userController.isVenueAdmin())
                              Column(
                                children: [
                                  // CustomButton(
                                  //   color: primaryColor,
                                  //   text: 'Voucher Redemptions',
                                  //   function: () => Get.to(() => VenueOrders(venue: venue)),
                                  // ),
                                  SizedBox(height: padding),

                                  // CustomButton(
                                  //   color: greenColor,
                                  //   text: 'Manage Staff',
                                  //   function: () => Get.to(() => AddStaff(venue: venue)),
                                  // ),
                                  // SizedBox(height: padding),
                                ],
                              ),
                            // if (userController.isAccountAdminForVenueOrBusiness(venue.accountID!))
                            Column(
                              children: [
                                // CustomButton(
                                //   color: orangeColor,
                                //   text: 'Local Products',
                                //   function: () => Get.to(() => ManageProducts(venue: venue)),
                                // ),
                                //SizedBox(height: padding),
                                // Obx(() {
                                //   return CustomButton(
                                //     color: orangeColor,
                                //     //textColor: pausedVoucherRedemption.value ? greenColor : redColor,
                                //     text: (pausedVoucherRedemption.value ? 'Resume' : 'Pause') + ' Voucher Redemption',
                                //     function: () {
                                //       Get.defaultDialog(
                                //         radius: padding / 2,
                                //         title: (pausedVoucherRedemption.value ? 'Resume' : 'Pause') + ' Voucher Redemption?',
                                //         content: Text('Are you sure you want to ' + (pausedVoucherRedemption.value ? 'Resume' : 'Pause') + ' Voucher Redemption?', textAlign: TextAlign.center),
                                //         cancel: CustomButton(
                                //           function: () async {
                                //             Get.back();
                                //             venue.paused = !venue.paused!;
                                //             pausedVoucherRedemption.toggle();
                                //             await cloudFunction(functionName: 'updateVenue', parameters: {'paused': venue.paused, 'venueID': venue.venueID}, action: () {});
                                //           },
                                //           text: 'Yes',
                                //           color: primaryColor,
                                //         ),
                                //         confirm: CustomButton(function: () => Get.back(), text: 'Cancel', color: Colors.grey),
                                //       );
                                //     },
                                //   );
                                // }),
                                // SizedBox(height: padding),
                              ],
                            ),
                            SizedBox(height: padding),
                            // if (venue.customerPromoCode.isNotEmpty)
                            //   promoCodeText(
                            //       'Customer promo code : ${venue.customerPromoCode}'),
                            // if (venue.staffPromoCode.isNotEmpty)
                            //   promoCodeText(
                            //       'Staff promo code : ${venue.staffPromoCode}'),
                            // if (venue.staffPromoCode.isEmpty &&
                            //     venue.customerPromoCode.isEmpty)
                            //   promoCodeText('You currently have no vouchers'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }

  redeemVoucher(Venue venue) {
    if (pausedVoucherRedemption.value)
      showRedAlert('Voucher redemption is paused');
    else
      showRedAlert('Voucher not accepted today');
  }
}

promoCodeText(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: DottedBorder(
      color: primaryColor,
      dashPattern: [8, 4],
      strokeWidth: 1,
      strokeCap: StrokeCap.butt,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text, textScaleFactor: 1.25),
      ),
    ),
  );
}

