import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatoutroundabout/controllers/user_controller.dart';
import 'package:eatoutroundabout/models/book_table_model.dart';
import 'package:eatoutroundabout/models/popup_model.dart';
import 'package:eatoutroundabout/models/users_model.dart';
import 'package:eatoutroundabout/services/buy_service.dart';
import 'package:eatoutroundabout/services/cloud_function.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/services/util_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/cached_image.dart';
import 'package:eatoutroundabout/widgets/custom_button.dart';
import 'package:eatoutroundabout/widgets/heading.dart';
import 'package:eatoutroundabout/widgets/loading.dart';
import 'package:eatoutroundabout/widgets/product_item.dart';
import 'package:eatoutroundabout/widgets/saved_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
//import 'package:smooth_star_rating/smooth_star_rating.dart';
//import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:uuid/uuid.dart';

class ViewPopUp extends StatefulWidget {
  final String? popupID;

  ViewPopUp({this.popupID});

  @override
  _ViewPopUpState createState() => _ViewPopUpState();
}

class _ViewPopUpState extends State<ViewPopUp> {
  bool isLoading = true;
  PopUp? popup;
  bool enableRating = false;
  final firestoreService = Get.find<FirestoreService>();
  final utilService = Get.find<UtilService>();
 final userController = Get.find<UserController>();

  TextEditingController toTEC = TextEditingController();
  TextEditingController fromTEC = TextEditingController();
  TextEditingController displayMessageTEC = TextEditingController();
  String selectedCard = '';

  List<BookTableModel> allEvents = [];
  List<User> allConnections = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    DocumentSnapshot doc = await firestoreService.getPopUpByPopUpID(widget.popupID!);
    popup = doc.data() as PopUp;
    setState(() {
      isLoading = false;
    });
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/applogo.png', height: AppBar().preferredSize.height - 15),
        backgroundColor: primaryColor,
      ),
      body: isLoading
          ? LoadingData()
          : Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Heading(title: 'POP-UP DETAILS'),
          Expanded(
            child: buildPackages(),
          ),
        ],
      ),
    );
  }

  buildPackages() {
    return SingleChildScrollView(
      child: Column(
        children: [

          Container(
            padding: const EdgeInsets.all(padding),
            alignment: Alignment.center,
            width: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                CachedImage(
                  roundedCorners: true,
                  circular: false,
                  height: 120,
                  url: popup!.logo,
                ),
                Padding(
                  padding: const EdgeInsets.all(padding),
                  child: Text(popup!.popupName!, textScaleFactor: 1.5, style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
                ),
                ],
            ),
          ),
          Container(
              padding: const EdgeInsets.all(padding),
              height: MediaQuery.of(context).size.height * .35,
              child: Swiper(
                //scrollDirection: Axis.vertical,
                loop: false,
                itemBuilder: (context, i) {
                  return CachedImage(
                    roundedCorners: true,
                    height: double.infinity,
                    url: popup!.images![i],
                  );
                },
                itemCount: popup!.images!.length,
                pagination: new SwiperPagination(builder: SwiperCustomPagination(builder: (BuildContext context, SwiperPluginConfig config) {
                  return SingleChildScrollView(scrollDirection: Axis.horizontal, child: DotSwiperPaginationBuilder(color: lightGreenColor, activeColor: primaryColor, size: 10.0, activeSize: 15.0).build(context, config));
                })),
              )),
          Padding(
            padding: const EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: padding / 2),
                  child: Text(popup!.popupDescription!, textScaleFactor: 1, textAlign: TextAlign.justify, style: TextStyle(color: Color.fromRGBO(8, 76, 97, 0.6), fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 25),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        onTap: () => openLink(popup!.website!),
                        leading: Icon(Icons.link, color: Colors.teal.shade400),
                        trailing: Icon(Icons.keyboard_arrow_right_rounded),
                        title: Text('Website', textScaleFactor: 1, style: TextStyle(color: Colors.teal.shade400, fontWeight: FontWeight.bold)),
                      ),

                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        onTap: () => openLink('tel:${popup!.popupPhoneNumber}'),
                        leading: Icon(Icons.local_phone, color: Colors.teal.shade400),
                        trailing: Icon(Icons.keyboard_arrow_right_rounded),
                        title: Text('Telephone', textScaleFactor: 1, style: TextStyle(color: Colors.teal.shade400, fontWeight: FontWeight.bold)),
                      ),

                    ],
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Food Types', style: TextStyle(color: Colors.teal.shade400, fontWeight: FontWeight.bold)),
                        SizedBox(height: 15),
                        Text(popup!.foodTypes!.join(", ")),
                      ],
                    ),
                  ),
                ),
                if (popup!.allergies!.isNotEmpty && popup!.intolerances!.isEmpty)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Allergies', style: TextStyle(color: Colors.teal.shade400, fontWeight: FontWeight.bold)),
                          SizedBox(height: 15),
                          Text(popup!.allergies!.join(", ")),
                          Text('Intolerances', style: TextStyle(color: Colors.teal.shade400, fontWeight: FontWeight.bold)),
                          SizedBox(height: 15),
                          Text(popup!.intolerances!.join(", ")),
                        ],
                      ),
                    ),
                  ),




                SizedBox(height: 25),
                if (popup!.paused!)
                  ListTile(
                    leading: Icon(Icons.qr_code, color: redColor),
                    horizontalTitleGap: 0,
                    title: Text('* This popup is not accepting vouchers currently', style: TextStyle(color: redColor, fontWeight: FontWeight.bold)),
                  ),
                if (popup!.preTheatreDining!)
                  ListTile(
                    leading: Icon(Icons.dining_outlined, color: Colors.grey.shade800),
                    horizontalTitleGap: 0,
                    title: Text('* This venue offers Pre-Theatre Dining'),
                  ),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(FontAwesomeIcons.facebookF),
                      color: popup!.facebook!.isNotEmpty ? Colors.indigo : Colors.grey,
                      onPressed: () => popup!.facebook!.isNotEmpty ? openLink(popup!.facebook!) : null,
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.instagram),
                      color: popup!.instagram!.isNotEmpty ? Colors.pinkAccent : Colors.grey,
                      onPressed: () => popup!.instagram!.isNotEmpty ? openLink(popup!.instagram!) : null,
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.twitter),
                      color: popup!.twitter!.isNotEmpty ? Colors.lightBlueAccent : Colors.grey,
                      onPressed: () => popup!.twitter!.isNotEmpty ? openLink(popup!.twitter!) : null,
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.linkedinIn),
                      color: popup!.linkedin!.isNotEmpty ? Colors.blueAccent : Colors.grey,
                      onPressed: () => popup!.linkedin!.isNotEmpty ? openLink(popup!.linkedin!) : null,
                    ),
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),
          )
        ],
      ),
    );
  }


  openLink(String link) async {
    if (!link.startsWith('tel')) link = link.startsWith('http') ? link : 'https://' + link;
    utilService.openLink(link);
  }

}
