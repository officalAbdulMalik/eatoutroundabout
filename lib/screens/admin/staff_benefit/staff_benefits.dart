import 'package:eatoutroundabout/controllers/user_controller.dart';
import 'package:eatoutroundabout/models/business_profile.dart';
import 'package:eatoutroundabout/models/product_model.dart';
import 'package:eatoutroundabout/models/projects_model.dart';
import 'package:eatoutroundabout/models/voucher_model.dart';
import 'package:eatoutroundabout/screens/admin/product/add_product.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/custom_button.dart';
import 'package:eatoutroundabout/widgets/heading.dart';
import 'package:eatoutroundabout/widgets/loading.dart';
import 'package:eatoutroundabout/widgets/product_item.dart';
import 'package:eatoutroundabout/widgets/voucher_SV_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class StaffBenefitsList extends StatelessWidget {
  final BusinessProfile? businessProfile;

  StaffBenefitsList({this.businessProfile});

  final userController = Get.find<UserController>();
  final firestoreService = Get.find<FirestoreService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Image.asset('assets/images/applogo.png',
              height: AppBar().preferredSize.height - 15)),
      body: Column(
        children: [
          Heading(title: 'Staff Benefits'),
          Expanded(
            child: Container(
              color: appBackground,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('if voucher expired'),
                    Padding(
                      padding: const EdgeInsets.all(padding),
                      child: CustomButton(
                        color: redColor,
                        text: 'Create a New Staff Benefit',
                        function: () => Get.to(
                                () => AddProduct(businessProfile: businessProfile)),
                      ),
                    ),
                    PaginateFirestore(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      isLive: true,
                      key: GlobalKey(),
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      itemBuilderType: PaginateBuilderType.listView,
                      itemBuilder: (context, documentSnapshot, i) {
                        Voucher voucher = documentSnapshot[i].data() as Voucher;
                        return VoucherSVItem(voucher: voucher, isMySocialValueVoucher: true);
                      },
                      query: firestoreService.getBusinessProfileVouchers(businessProfile!.businessProfileID!),
                      onEmpty: Padding(
                        padding: EdgeInsets.only(
                            bottom: Get.height / 2 - 200, left: 25, right: 25),
                        child: Text(
                          'No campaigns to show',
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.15,
                        ),
                      ),
                      itemsPerPage: 10,
                      bottomLoader: LoadingData(),
                      initialLoader: LoadingData(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}