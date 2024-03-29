import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatoutroundabout/controllers/user_controller.dart';
import 'package:eatoutroundabout/models/user_vouchers_model.dart';
import 'package:eatoutroundabout/models/voucher_model.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/services/permissions_service.dart';
import 'package:eatoutroundabout/services/util_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/claim_voucher_item.dart';
import 'package:eatoutroundabout/widgets/custom_button.dart';
import 'package:eatoutroundabout/widgets/empty_box.dart';
import 'package:eatoutroundabout/widgets/heading.dart';
import 'package:eatoutroundabout/widgets/loading.dart';
import 'package:eatoutroundabout/widgets/voucher_item.dart';
import 'package:eatoutroundabout/widgets/voucher_offer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../models/users_model.dart';

class MyVouchers extends StatefulWidget {
  final bool? showAppBar;

  MyVouchers({this.showAppBar});

  @override
  _MyVouchersState createState() => _MyVouchersState();
}

class _MyVouchersState extends State<MyVouchers> {
  TabController? tabController;
  final permissionsService = Get.find<PermissionsService>();
  final firestoreService = Get.find<FirestoreService>();
  final userController = Get.find<UserController>();

  User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenColor,
      appBar: widget.showAppBar ?? false
          ? AppBar(
        title: Image.asset('assets/images/applogo.png', height: AppBar().preferredSize.height - 15),
        backgroundColor: primaryColor,
      )
          : null,
      extendBody: true,
      body: DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Column(
          children: [
            Heading(title: 'MY VOUCHERS'),
            Container(
              height: 45,
              margin: const EdgeInsets.all(padding),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(padding / 2), color: Colors.grey.shade400),
              child: TabBar(
                dividerColor:Colors.transparent,
                tabs: [
                  Tab(text: 'Claim'),
                  Tab(text: 'Vouchers'),
                  Tab(text: 'Used'),
                ],
              ),
            ),
            Container(
              height: 70,
              width: double.infinity,
              margin: const EdgeInsets.all(padding),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(padding / 2), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(userController.currentUser.value.remainingVouchers.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: redColor )),
                      ],
                    ),
                    SizedBox(width: 10),
                    // Text(user!.remainingVouchers.toString()),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text('vouchers remaining'),
                      ],
                    ),
                  ],

                ),
              ),
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                  children: [
                    claimVouchers(),
                    myVouchers(false),
                    myVouchers(true),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  myVouchers(isRedeemed) {
    return Column(
      children: [
        Expanded(
          child: PaginateFirestore(
            isLive: true,
            key: GlobalKey(debugLabel: 'key'),
            shrinkWrap: true,
            itemBuilderType: PaginateBuilderType.listView,
            itemBuilder: (context, documentSnapshot, i) {
              UserVoucher userVoucher = documentSnapshot[i].data() as UserVoucher;
              return Container(
                key: Key(userVoucher.voucherID!),
                width: Get.width,
                height: Get.width * 1.25,
                child: VoucherItem(userVoucher: userVoucher),
              );
            },
            query: isRedeemed ? firestoreService.getRedeemedVouchersQuery() : firestoreService.getMyVouchersQuery(isRedeemed),
            onEmpty: EmptyBox(text: 'You are all caught up!'),
            itemsPerPage: 10,
            bottomLoader: LoadingData(),
            initialLoader: LoadingData(),
          ),
        ),
        // Expanded(
        //   child: StreamBuilder<QuerySnapshot<UserVoucher>>(
        //     stream: isRedeemed ? firestoreService.getRedeemedVouchers() : firestoreService.getMyVouchers(),
        //     builder: (context, AsyncSnapshot<QuerySnapshot<UserVoucher>> snapshot) {
        //       if (snapshot.hasData)
        //         return snapshot.data.docs.isNotEmpty
        //             ? ListView.builder(
        //                 addAutomaticKeepAlives: true,
        //                 itemBuilder: (context, i) {
        //                   UserVoucher userVoucher = snapshot.data.docs[i].data();
        //                   return VoucherItem(userVoucher: userVoucher);
        //                 },
        //                 itemCount: snapshot.data.docs.length,
        //               )
        //             : EmptyBox(text: 'No vouchers to show');
        //       else
        //         return LoadingData();
        //     },
        //   ),
        // ),
      ],
    );
  }

  myVouchers2(isRedeemed) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: isRedeemed ? firestoreService.getRedeemedVouchers() : firestoreService.getMyVouchers(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData)
                return snapshot.data!.docs.isNotEmpty
                    ? Swiper(
                  loop: false,
                  viewportFraction: 0.9,
                  itemBuilder: (context, i) {
                    UserVoucher? userVoucher = snapshot.data!.docs[i].data() as UserVoucher;
                    return VoucherItem(userVoucher: userVoucher);
                  },
                  itemCount: snapshot.data!.docs.length,
                  pagination: new SwiperPagination(builder: SwiperCustomPagination(builder: (BuildContext context, SwiperPluginConfig config) {
                    return SingleChildScrollView(scrollDirection: Axis.horizontal, child: DotSwiperPaginationBuilder(color: Colors.white38, activeColor: redColor, size: 10.0, activeSize: 15.0).build(context, config));
                  })),
                )
                    : EmptyBox(text: 'No vouchers to show');
              else
                return LoadingData();
            },
          ),
        ),
      ],
    );
  }

  claimVouchers() {
    return
      StreamBuilder(
        stream: firestoreService.getVoucherOfferQueryStream(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData)
            return snapshot.data!.docs.length > 0
                ? ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: padding),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, i) {
                DocumentSnapshot doc = snapshot.data!.docs[i];
                Voucher voucher = doc.data() as Voucher;
                return ClaimVoucherOfferItem(voucher1: voucher);
              },
            )
                : EmptyBox(text: 'No Admins added yet');
          else
            return LoadingData();
        },
      );
  }

  buildText(String text) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(padding),
        child: Linkify(
          text: text,
          onOpen: (link) async {
            final utilService = Get.find<UtilService>();
            utilService.openLink(link.url);
          },
          options: LinkifyOptions(humanize: true),
          linkStyle: TextStyle(color: primaryColor),
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
          textScaleFactor: 1.2,
        ),
      ),
    );
  }



}
