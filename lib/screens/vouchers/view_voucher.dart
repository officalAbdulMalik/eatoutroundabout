import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:eatoutroundabout/models/user_vouchers_model.dart';
import 'package:eatoutroundabout/models/venue_model.dart';
import 'package:eatoutroundabout/models/voucher_model.dart';
import 'package:eatoutroundabout/screens/vouchers/restricted_venues.dart';
import 'package:eatoutroundabout/screens/vouchers/self_redeem_voucher.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/services/location_service.dart';
import 'package:eatoutroundabout/services/util_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/custom_button.dart';
import 'package:eatoutroundabout/widgets/heading.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';
import 'package:intl/intl.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:location/location.dart' as loc;
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class ViewVoucher extends StatelessWidget {
  final UserVoucher? userVoucher;
  final String? name;
  final String? value;


  ViewVoucher({this.userVoucher, this.name, this.value});

  final utilService = Get.find<UtilService>();
  final firestoreService = Get.find<FirestoreService>();
  final locationService = Get.find<LocationService>();

  @override
  void initState() {
    final locationService = Get.find<LocationService>();
    locationService.determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Image.asset('assets/images/applogo.png',
          height: AppBar().preferredSize.height - 15),
          backgroundColor: primaryColor),
      body: Column(
        children: [
          Heading(title: 'VOUCHER'),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              color: Colors.grey.shade300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder(
                    stream: Stream.periodic(const Duration(seconds: 1)),
                    builder: (context, snapshot) {
                      return Text(
                        DateFormat('dd MMM yyyy, hh:mm:ss').format(
                            DateTime.now()),
                        textScaleFactor: 1.5,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: greenColor),
                      );
                    },
                  ),
                  SizedBox(height: 30),
                  PrettyQr(
                    typeNumber: 2,
                    size: 250,
                    data: userVoucher!.voucherRedemptionCode!,
                    roundEdges: true,
                  ),
                  SizedBox(height: 30),
                  Text('Voucher Code', textScaleFactor: 1.5,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: primaryColor)),
                  SizedBox(height: 10),
                  DottedBorder(
                    color: Colors.black,
                    dashPattern: [8, 4],
                    strokeWidth: 3,
                    strokeCap: StrokeCap.butt,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(userVoucher!.voucherRedemptionCode!,
                          textScaleFactor: 2.5,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: redColor)),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(showDate(), textScaleFactor: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: primaryColor)),
                  SizedBox(height: 30),
                  //Text('Cannot be redeemed in conjunction with venue offers', textAlign: TextAlign.center, textScaleFactor: 0.9, style: TextStyle(color: greenColor)),
                  if (name != null)
                    Container(
                      height: 100,
                      padding: const EdgeInsets.all(20),
                      child: CustomButton(
                        color: redColor,
                        textColor: Colors.white,
                        text: 'Redeem Voucher',
                        showShadow: true,
                        function: (() async {
                          final venue = await firestoreService
                              .getVenueCoordinates(userVoucher!
                              .venueRestricted!) as DocumentSnapshot;
                          if (venue.exists) {
                            getVenueLocation(venue);
                            getUserLocation();

                            final distanceInMeters = await Geolocator
                                .distanceBetween(
                                myLatitude, myLongitude, venue['lat'],
                                venue['long']);
                            if (distanceInMeters < 100);
                            return
                              redeemVoucher(userVoucher);
                          } else {
                            showRedAlert('You are not in the venue location');
                            return false;
                          }
                        }
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  getVenueLocation(venue) async {
    DocumentSnapshot documentSnapshot = await firestoreService
        .getVenueCoordinates(venue!.postCode!);
    print('*********LATITUDE');
    //print(documentSnapshot.data()['lat']);

    if (documentSnapshot.exists)
      final venueLatLong = LatLng(
          documentSnapshot['lat'], documentSnapshot['long']);
    else
      final venuelatLong = LatLng(51.509865, -0.118092); //London Coordinates
  }

  getUserLocation() async
  {
    Position position = await Geolocator.getCurrentPosition();
    myLatitude = position.latitude;
    myLongitude = position.longitude;
    return position;
  }

  showDate() {
    if (userVoucher!.redeemed!)
      return 'Redeemed : ' +
          DateFormat('dd MMM yyyy').format(userVoucher!.redeemedDate!.toDate());
    else
      return 'Expiry Date : ' +
          DateFormat('dd MMM yyyy').format(userVoucher!.expiryDate!.toDate());
  }

  redeemVoucher(userVoucher) async {
    StreamBuilder(
        stream: firestoreService.getVoucherStream(userVoucher!.voucherID!),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            Voucher? voucher = snapshot.data!.data() as Voucher;
            bool? flag = false;
            String? today = DateFormat('EEEE')
                .format(DateTime.now())
                .toLowerCase();
            if (voucher.redeemable!)

              switch (today) {

                case 'sunday':
                  flag = voucher.sunday!.accept!;
                  break;
                case 'monday':
                  flag = voucher.monday!.accept!;
                  break;
                case 'tuesday':
                  flag = voucher.tuesday!.accept!;
                  break;
                case 'wednesday':
                  flag = voucher.wednesday!.accept!;
                  break;
                case 'thursday':
                  flag = voucher.thursday!.accept!;
                  break;
                case 'friday':
                  flag = voucher.friday!.accept!;
                  break;
                case 'saturday':
                  flag = voucher.saturday!.accept!;
                  break;
              }
            if (flag)
              Get.to(() => SelfRedeemVoucher(userVoucher: userVoucher));
            else
              showRedAlert('Voucher not accepted today');
          }
          return
            showRedAlert('voucher not found');
        }

    );
  }
}
