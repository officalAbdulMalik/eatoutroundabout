import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatoutroundabout/models/user_vouchers_model.dart';
import 'package:eatoutroundabout/models/voucher_model.dart';
import 'package:eatoutroundabout/screens/vouchers/restricted_venues.dart';
import 'package:eatoutroundabout/screens/vouchers/view_voucher.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/cached_image.dart';
import 'package:eatoutroundabout/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VoucherItem extends StatefulWidget {
  final UserVoucher? userVoucher;

  VoucherItem({this.userVoucher});

  @override
  State<VoucherItem> createState() => _VoucherItemState();
}

class _VoucherItemState extends State<VoucherItem> {
  final firestoreService = Get.find<FirestoreService>();

  String? name;
  String? value;

  Future<DocumentSnapshot<Voucher>>? future;

  @override
  void initState() {
    future =
        firestoreService.getVoucherByVoucherID(widget!.userVoucher!.voucherID!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      key: Key(widget.userVoucher!.voucherID!),
      future: future,
      builder: (context, AsyncSnapshot<DocumentSnapshot<Voucher>> snapshot) {
        if (snapshot.hasData) {
          Voucher? voucher = snapshot.data!.data();
          getNameAndValue(widget.userVoucher!);
          return InkWell(
            onTap: () =>
            widget!.userVoucher!.redeemable!
                ? widget!.userVoucher!.redeemed!
                ? showRedAlert('Voucher already redeemed')
                : Get.to(() =>
                ViewVoucher(
                    userVoucher: widget.userVoucher, name: name, value: value))
                : showRedAlert('This voucher is not redeemable'),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(padding),
                    margin: const EdgeInsets.fromLTRB(
                        padding, 0, padding, padding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(padding / 2)),
                      image: voucher!.voucherImage == ''
                          ? null
                          : DecorationImage(
                          image: CachedNetworkImageProvider(voucher!
                              .voucherImage!),
                          colorFilter: widget!.userVoucher!.redeemable!
                              ? ColorFilter.mode(Colors.black45,
                              BlendMode.srcOver)
                              : ColorFilter.mode(Colors.grey,
                              BlendMode.saturation),
                          fit: BoxFit.cover),
                      color: widget!.userVoucher!.redeemable!
                          ? Colors.black38
                          : null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if (voucher!.voucherType == 'Christmas' &&
                            !widget!.userVoucher!.redeemed!)
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(5)),
                              color: redColor,
                            ),
                            child: Text('Redeemable in January - February',
                                style: TextStyle(color: Colors.white)),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedImage(height: 100,
                                url: voucher!.voucherLogo ?? '',
                                roundedCorners: true,
                                circular: false),
                          //   if (voucher!.bidRestricted != '' ||
                          //       voucher!.lepRestricted != '' ||
                          //       voucher!.localAuthRestricted != '' ||
                          //       voucher!.wardRestricted != '' ||
                          //       voucher!.venueRestricted != '') CircleAvatar(
                          //       backgroundColor: lightGreenColor,
                          //       child: Icon(
                          //           Icons.lock_outline, color: primaryColor,
                          //           size: 30)),
                           ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 80),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(voucher!.displayMessage!,
                                    textScaleFactor: 1.9,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white)),
                                Text(voucher!.voucherOffer!, textScaleFactor: 1.2,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white)),

                              ],
                            ),

                          ),
                        ),
                        if (name != null)
                          TextButton(
                            onPressed: () =>
                                Get.to(() =>
                                    RestrictedVenues(name: name, value: value)),
                            child: Text('View venue details',
                                style: TextStyle(color: lightGreenColor)),
                          ),
                       SizedBox(height: 10),
                        widget!.userVoucher!.redeemed!
                            ? redeemed()
                            : normalVoucher(voucher),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  redeemed() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(padding / 2)),
        ),
        child: Text('Redeemed', textScaleFactor: 1,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)));
  }

  normalVoucher(Voucher? voucher) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Expiry : ' + DateFormat('dd MMM yyyy').format(
            widget.userVoucher!.expiryDate!.toDate()), textScaleFactor: 1,
            style: TextStyle(color: lightGreenColor)),
        Container(

    child: acceptVouchers(voucher!))
            // padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            // decoration: BoxDecoration(
            //   color: redColor,
            //   borderRadius: BorderRadius.all(Radius.circular(50)),
            // ),
            // child: Text(widget!.userVoucher!.redeemable! ? widget!.userVoucher!
            //     .voucherRedemptionCode! : '------', textScaleFactor: 1,
            //     style: TextStyle(
            //         color: Colors.white, fontWeight: FontWeight.bold))),
      ],
    );
  }

  getNameAndValue(UserVoucher userVoucher) {
    if (userVoucher.bidRestricted != '') {
      name = 'bidRestricted';
      value = userVoucher.bidRestricted;
    }

    if (userVoucher.lepRestricted != '') {
      name = 'lepRestricted';
      value = userVoucher.lepRestricted;
    }

    if (userVoucher.wardRestricted != '') {
      name = 'wardRestricted';
      value = userVoucher.wardRestricted;
    }

    if (userVoucher.localAuthRestricted != '') {
      name = 'localAuthRestricted';
      value = userVoucher.localAuthRestricted;
    }

    if (userVoucher.venueRestricted != '') {
      name = 'venueRestricted';
      value = userVoucher.venueRestricted;
    }
  }
}

  acceptVouchers(Voucher voucher) {
    return
       InkWell(
        onTap: () {
          Get.defaultDialog(
            radius: padding / 2,
            title: 'Terms and Conditions',
            content: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Valid for use at the venue specified on the voucher',
                      textScaleFactor: 0.8),
                  SizedBox(height: 5),
                  Text(
                      'Valid for use on the times and dates specified below',
                      textScaleFactor: 0.8),
                  SizedBox(height: 10),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Days and times vouchers accepted',
                              textScaleFactor: 0.8, style: TextStyle(
                                  color: Colors.teal.shade400,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 25),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: Text(
                                    'DAY', textScaleFactor: 0.7,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                                Expanded(child: Center(child: Text(
                                    'BETWEEN', textScaleFactor: 0.7,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)))),
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
                          day('Monday', '${voucher!.monday!.acceptTimeStart!.toStringAsFixed(2)} -${voucher!.monday!.acceptTimeEnd!.toStringAsFixed(2)}'),
                          Divider(),
                          day('Tuesday', '${voucher!.tuesday!.acceptTimeStart!.toStringAsFixed(2)} - ${voucher!.tuesday!.acceptTimeEnd!.toStringAsFixed(2)}'),
                          Divider(),
                          day('Wednesday', '${voucher!.wednesday!.acceptTimeStart!.toStringAsFixed(2)} - ${voucher!.wednesday!.acceptTimeEnd!.toStringAsFixed(2)}'),
                          Divider(),
                          day('Thursday', '${voucher!.thursday!.acceptTimeStart!.toStringAsFixed(2)} - ${voucher!.thursday!.acceptTimeEnd!.toStringAsFixed(2)}'),
                          Divider(),
                          day('Friday', '${voucher!.friday!.acceptTimeStart!.toStringAsFixed(2)} - ${voucher!.friday!.acceptTimeEnd!.toStringAsFixed(2)}'),
                          Divider(),
                          day('Saturday', '${voucher!.saturday!.acceptTimeStart!.toStringAsFixed(2)} - ${voucher!.saturday!.acceptTimeEnd!.toStringAsFixed(2)}'),
                          Divider(),
                          day('Sunday', '${voucher!.sunday!.acceptTimeStart!.toStringAsFixed(2)} - ${voucher!.sunday!.acceptTimeEnd!.toStringAsFixed(2)}'),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Text(
                          'Please notify the server of voucher use prior to requesting the bill',
                          textScaleFactor: 0.8),
                      SizedBox(height: 5),
                      Text('This is a non-cash voucher', textScaleFactor: 0.8),
                      SizedBox(height: 5),
                      Text('This voucher is not exchangeable for cash',
                          textScaleFactor: 0.8),
                      SizedBox(height: 5),
                      Text(
                          'The voucher is only valid on or before the expiry date',
                          textScaleFactor: 0.8),
                      SizedBox(height: 5),
                      Text(
                          'There is a minimum spend of £20 inclusive of VAT per voucher',
                          textScaleFactor: 0.8),
                      SizedBox(height: 5),
                      Text(
                          'Multiple vouchers may be used by for party, as long as only 1 voucher is used per person and the average spend for each person is £20 inclusive of VAT',
                          textScaleFactor: 0.8),
                      SizedBox(height: 5),
                      Text('1 voucher may be redeemed per person, per meal',
                          textScaleFactor: 0.8),

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
                color: redColor,
              ),
              child: Row(
                children: [
                  Text('View T&C\'s', textScaleFactor: 1,
                      style: TextStyle(color: Colors.white)),

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
          Expanded(child: Text(day, textScaleFactor: 0.7,
              style: TextStyle(color: Color.fromRGBO(8, 76, 97, 0.8),
                  fontWeight: FontWeight.normal))),
          Expanded(child: Center(child: Text(
              time.contains("-1") ? 'Not accepted' : time, textScaleFactor: 0.7,
              style: TextStyle(color: Color.fromRGBO(8, 76, 97, 0.8),
                  fontWeight: FontWeight.normal)))),

        ],
      ),
    );
  }


