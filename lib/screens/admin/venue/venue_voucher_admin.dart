import 'package:eatoutroundabout/models/voucher_model.dart';
import 'package:eatoutroundabout/services/util_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';



class VenueVoucherAdmin extends StatelessWidget {
  final Voucher? voucher;
  final bool? isMyVoucher;

  VenueVoucherAdmin({this.voucher, this.isMyVoucher});
  final miscService = Get.find<UtilService>();

  @override
  Widget build(BuildContext context) {
    return
      Text('It worked' + voucher!.displayMessage!);


  }
}
