import 'package:eatoutroundabout/screens/admin/business/projects/social_value_project_details.dart';
import 'package:eatoutroundabout/screens/admin/business/voucher_sv_details.dart';
import 'package:eatoutroundabout/screens/venues/view_nhs_social_value_report.dart';
import 'package:eatoutroundabout/services/util_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/cached_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eatoutroundabout/models/voucher_model.dart';

class VoucherSVItem extends StatelessWidget {
  final Voucher? voucher;
  final bool? isMySocialValueVoucher;

  VoucherSVItem({this.voucher, this.isMySocialValueVoucher});

  final miscService = Get.find<UtilService>();

  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: () {
          if (isMySocialValueVoucher ?? false)
            Get.to(() => VoucherSVDetails(voucher: voucher));
          else
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ViewNHSSocialValueProjectDetails()));
        },
        child: Container(
          margin: EdgeInsets.only(bottom: padding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(padding / 2),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 10),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(padding / 2), bottomRight: Radius.circular(padding / 2)),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    CachedImage(
                      url: voucher!.voucherLogo! == '' ? 'assets/images/logo.png' : voucher!.voucherLogo!,
                      height: 80,
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(voucher!.issuedCampaignName!, textScaleFactor: 0.9, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(child: Text(voucher!.displayMessage!, textScaleFactor: 0.85, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: greenColor))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );


  }
}
