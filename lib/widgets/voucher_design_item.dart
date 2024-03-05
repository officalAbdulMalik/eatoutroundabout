import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatoutroundabout/models/user_vouchers_model.dart';
import 'package:eatoutroundabout/models/venue_model.dart';
import 'package:eatoutroundabout/models/voucher_model.dart';
import 'package:eatoutroundabout/screens/vouchers/restricted_venues.dart';
import 'package:eatoutroundabout/screens/vouchers/view_voucher.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VoucherDesignItem extends StatefulWidget {
  final Voucher? voucher;

  VoucherDesignItem({this.voucher});

  @override
  State<VoucherDesignItem> createState() => _VoucherDesignItemState();
}

class _VoucherDesignItemState extends State<VoucherDesignItem> {
  final firestoreService = Get.find<FirestoreService>();

  String? name;
  String? value;
  String? venueRestricted;
  String? venuePostcode;

  Future<DocumentSnapshot<Voucher>>? future;

  @override
  void initState() {
    future = firestoreService.getVoucherByVoucherID(widget.voucher!.voucherID!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      key: Key(widget.voucher!.voucherID!),
      future: future,
      builder: (context, AsyncSnapshot<DocumentSnapshot<Voucher>> snapshot) {
        if (snapshot.hasData) {
          Voucher? voucher = snapshot.data!.data();
          getNameValueVenueDetails(widget.voucher!);
          return Column(
              children: [
                SizedBox(height: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(padding),
                    margin: const EdgeInsets.fromLTRB(padding, 0, padding, padding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(padding / 2)),
                      image: voucher!.voucherImage == '' ? null : DecorationImage(image: CachedNetworkImageProvider(voucher.voucherImage!), colorFilter: widget.voucher!.redeemable! ? ColorFilter.mode(Colors.black45, BlendMode.srcOver) : ColorFilter.mode(Colors.grey, BlendMode.saturation), fit: BoxFit.cover),
                      color: widget.voucher!.redeemable! ? Colors.black38 : null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedImage(height: 100, url: voucher.voucherLogo ?? '', roundedCorners: true, circular: false),
                            // if (voucher.bidRestricted != '' || voucher.lepRestricted != '' || voucher.localAuthRestricted != '' || voucher.wardRestricted != '' || voucher.venueRestricted != '')
                            //   CircleAvatar(backgroundColor: lightGreenColor, child: Icon(Icons.lock_outline, color: primaryColor, size: 30)
                            //   ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 80),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(voucher.displayMessage!, textScaleFactor: 1.9, maxLines: 5, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                        Text(voucher.voucherOffer!, textScaleFactor: 1.2, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white)),
                        if (name != null)
                          TextButton(
                            onPressed: () => Get.to(() => RestrictedVenues(name: name!, value: value!)),
                            child: Text('venue details', style: TextStyle(color: lightGreenColor)),
                          ),
                        SizedBox(height: 10),
                        normalVoucher(),
                      ],
                    ),
                  ),
                ),

              ],
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
        child: Text('Redeemed', textScaleFactor: 1, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)));
  }

  normalVoucher() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
       // Text('Expiry : ' + DateFormat('dd MMM yyyy').format(widget.voucher!.expiryDate!.toDate()), textScaleFactor: 1, style: TextStyle(color: lightGreenColor)),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            decoration: BoxDecoration(
              color: redColor,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
          child: Text('T&Cs', textScaleFactor: 1, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
            //child: Text(widget.userVoucher!.redeemable! ? widget.userVoucher!.voucherRedemptionCode! : '------', textScaleFactor: 1, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
        ),
      ],
    );
  }

  getNameValueVenueDetails(Voucher Voucher) {
    if (Voucher.bidRestricted != '') {
      name = 'bidRestricted';
      value = Voucher.bidRestricted;
      venuePostcode = Voucher.venuePostcode;

    }

    if (Voucher.lepRestricted != '') {
      name = 'lepRestricted';
      value = Voucher.lepRestricted;
      venuePostcode = Voucher.venuePostcode;
    }

    if (Voucher.wardRestricted != '') {
      name = 'wardRestricted';
      value = Voucher.wardRestricted;
      venuePostcode = Voucher.venuePostcode;
    }

    if (Voucher.localAuthRestricted != '') {
      name = 'localAuthRestricted';
      value = Voucher.localAuthRestricted;
      venuePostcode = Voucher.venuePostcode;
    }

    if (Voucher.venueRestricted != '') {
      name = 'venueRestricted';
      value = Voucher.venueRestricted;
      venuePostcode = Voucher.venuePostcode;
    }
  }
}
