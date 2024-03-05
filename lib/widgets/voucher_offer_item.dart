import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatoutroundabout/controllers/user_controller.dart';
import 'package:eatoutroundabout/models/venue_model.dart';
import 'package:eatoutroundabout/models/voucher_model.dart';
import 'package:eatoutroundabout/screens/vouchers/restricted_venues.dart';
import 'package:eatoutroundabout/services/cloud_function.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/cached_image.dart';
import 'package:eatoutroundabout/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class ClaimVoucherOfferItem extends StatelessWidget {
  final Voucher? voucher1;

  ClaimVoucherOfferItem({this.voucher1});
  final userController = Get.find<UserController>();
  String? name = 'venueRestricted';


  final firestoreService = Get.find<FirestoreService>();

  @override
  Widget build(BuildContext context) {

    return

      Container(
      height: Get.width * 1,
      margin: const EdgeInsets.fromLTRB(padding, 0, padding, padding),
      decoration: BoxDecoration(
        color: lightGreenColor,
        borderRadius: BorderRadius.circular(padding / 2),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10),
        ],
        image: DecorationImage(
          image: voucher1!.voucherImage == '' ? AssetImage('assets/images/logo.png') as ImageProvider: CachedNetworkImageProvider(voucher1!.voucherImage!),
          fit: voucher1!.voucherImage == '' ? BoxFit.contain : BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: CachedImage(url: voucher1!.voucherLogo, height: 100, roundedCorners: true),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(padding / 2), bottomRight: Radius.circular(padding / 2)),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
               Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                   children:[
                   Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
            FutureBuilder(
            future: firestoreService.getVenueQuery(voucher1!.venueRestricted!),
              builder: (context, AsyncSnapshot<DocumentSnapshot<Venue>> snapshot) {
                if (snapshot.hasData) {
                  Venue? venue = snapshot.data!.data();
                  return Column(

                    children: [
                      Row(
                        children: [
                          Text("£10 off when you spend £20 or more at ", textScaleFactor: 0.8, style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold)),
                        ],
                      ),
                        Row(
                        children: [
                        Text(venue!.venueName!, textScaleFactor: 0.8, style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold)),
                          Text(" - " + venue!.townCity!, textScaleFactor: 0.8, style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold)),

                ],
                ),

                      if (voucher1!.venueRestricted != null)
                        SizedBox(height: 15),
                      InkWell(
                        onTap: () async {
                          String voucherID = voucher1!.voucherID!;
                          HapticFeedback.vibrate();
                          Map voucher = {
                            'voucherID': voucherID,
                            'userID': userController.currentUser.value.userID,
                            'latitude': userController.myLatitude,
                            'longitude': userController.myLongitude,
                          };
                          await cloudFunction(functionName: 'addVoucher', parameters: voucher, action: () {});
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: voucher1!.voucherType != 'standard' ? redColor : redColor,
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                            ),
                            child: Text('Claim voucher', style: TextStyle(color: Colors.white))),

                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          InkWell(
                            onTap: ()=>  Get.to(() =>
                                RestrictedVenues(name: name, value: voucher1!.venueRestricted)),
                            child:
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(3),
                                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      Text('Check venue details', textScaleFactor: 0.8,
                                          style: TextStyle(color: greenColor)),
                                    ],
                                  ),
                                ),
                                buildTerms(venue!.venueName!, venue!.townCity),
                              ],
                            ),

                          ),
                        ],
                      ),






                    ],
                  );

                } else
                  return Text('No venue can be found');
              }),
        ],
      ),
        ]

                   ),



                 ]
               )

              ],
            ),
          ),
        ],
      ),
    );


  }



buildTerms(venueName, townCity) {
    return InkWell(
      onTap: () {
        Get.defaultDialog(
          radius: padding / 2,
          title: 'Terms and Conditions',
          content: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Valid for use at ' + venueName! + ", " + townCity, textScaleFactor: 0.8),
                SizedBox(height: 5),
                Text('Valid for use on the times and dates specified below', textScaleFactor: 0.8),
                SizedBox(height: 10),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Days and times vouchers accepted', textScaleFactor: 0.8, style: TextStyle(color: Colors.teal.shade400, fontWeight: FontWeight.bold)),
                        SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Text('DAY', textScaleFactor: 0.7, style: TextStyle(fontWeight: FontWeight.bold))),
                              Expanded(child: Center(child: Text('BETWEEN', textScaleFactor: 0.7, style: TextStyle(fontWeight: FontWeight.bold)))),
                              // Expanded(
                              //     child: Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: [
                              //     Text('VOUCHER', textScaleFactor: 1, style: TextStyle(fontWeight: FontWeight.bold)),
                              //   ],
                              // )),
                            ],
                          ),
                        ),
                        Divider(),
                        day('Monday', '${voucher1!.monday!.acceptTimeStart!.toStringAsFixed(2)} - ${voucher1!.monday!.acceptTimeEnd!.toStringAsFixed(2)}'),
                        Divider(),
                        day('Tuesday', '${voucher1!.tuesday!.acceptTimeStart!.toStringAsFixed(2)} - ${voucher1!.tuesday!.acceptTimeEnd!.toStringAsFixed(2)}'),
                        Divider(),
                        day('Wednesday', '${voucher1!.wednesday!.acceptTimeStart!.toStringAsFixed(2)} - ${voucher1!.wednesday!.acceptTimeEnd!.toStringAsFixed(2)}'),
                        Divider(),
                        day('Thursday', '${voucher1!.thursday!.acceptTimeStart!.toStringAsFixed(2)} - ${voucher1!.thursday!.acceptTimeEnd!.toStringAsFixed(2)}'),
                        Divider(),
                        day('Friday', '${voucher1!.friday!.acceptTimeStart!.toStringAsFixed(2)} - ${voucher1!.friday!.acceptTimeEnd!.toStringAsFixed(2)}'),
                        Divider(),
                        day('Saturday', '${voucher1!.saturday!.acceptTimeStart!.toStringAsFixed(2)} - ${voucher1!.saturday!.acceptTimeEnd!.toStringAsFixed(2)}'),
                        Divider(),
                        day('Sunday', '${voucher1!.sunday!.acceptTimeStart!.toStringAsFixed(2)} - ${voucher1!.sunday!.acceptTimeEnd!.toStringAsFixed(2)}'),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text(
                        'Please notify the server of voucher use prior to requesting the bill', textScaleFactor: 0.8),
                    SizedBox(height: 5),
                    Text('This is a non-cash voucher', textScaleFactor: 0.8),
                    SizedBox(height: 5),
                    Text('This voucher is not exchangeable for cash', textScaleFactor: 0.8),
                    SizedBox(height: 5),
                    Text('The voucher is only valid on or before the expiry date', textScaleFactor: 0.8),
                    SizedBox(height: 5),
                    Text(
                        'There is a minimum spend of £20 inclusive of VAT per voucher', textScaleFactor: 0.8),
                    SizedBox(height: 5),
                    Text(
                        'Multiple vouchers may be used by for party, as long as only 1 voucher is used per person and the average spend for each person is £20 inclusive of VAT', textScaleFactor: 0.8),
                    SizedBox(height: 5),
                    Text('1 voucher may be redeemed per person, per meal', textScaleFactor: 0.8),

                  ],
                ),
                ],
            ),
          ),
          cancel: CustomButton(
              function: () => Get.back(), text: 'OK', color: primaryColor),
        );
      },
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Text('Terms and conditions apply', textScaleFactor: 0.8,
                    style: TextStyle(color: greenColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
  day(String day, String time) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(day, textScaleFactor: 0.7, style: TextStyle(color: Color.fromRGBO(8, 76, 97, 0.8), fontWeight: FontWeight.normal))),
          Expanded(child: Center(child: Text(time.contains("-1") ? 'Closed' : time, textScaleFactor: 0.7, style: TextStyle(color: Color.fromRGBO(8, 76, 97, 0.8), fontWeight: FontWeight.normal)))),

        ],
      ),
    );
  }

}

