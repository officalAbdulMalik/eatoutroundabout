import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatoutroundabout/controllers/user_controller.dart';
import 'package:eatoutroundabout/models/venue_model.dart';
import 'package:eatoutroundabout/screens/home/home_page.dart';
import 'package:eatoutroundabout/services/cloud_function.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/services/storage_service.dart';
import 'package:eatoutroundabout/services/util_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/cached_image.dart';
import 'package:eatoutroundabout/widgets/custom_button.dart';
import 'package:eatoutroundabout/widgets/custom_text_field.dart';
import 'package:eatoutroundabout/widgets/heading.dart';
import 'package:eatoutroundabout/widgets/loading.dart';
import 'package:eatoutroundabout/widgets/timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

class EditVenueMarketing extends StatefulWidget {
  final Venue? venue;

  EditVenueMarketing({this.venue});

  @override
  _EditVenueMarketingState createState() => _EditVenueMarketingState();
}

class _EditVenueMarketingState extends State<EditVenueMarketing> {
  final loading = true.obs;
  final TextEditingController fbTEC = TextEditingController();
  final TextEditingController instaTEC = TextEditingController();
  final TextEditingController twTEC = TextEditingController();
  final TextEditingController liTEC = TextEditingController();
  final TextEditingController postcodeTEC = TextEditingController();


  final firestoreService = Get.find<FirestoreService>();
  final utilService = Get.find<UtilService>();
  final storageService = Get.find<StorageService>();
  final userController = Get.find<UserController>();

 // FocusScopeNode node = FocusScopeNode();

  @override
  void initState() {
    fbTEC.text = widget.venue!.facebook!;
    instaTEC.text = widget.venue!.instagram!;
    twTEC.text = widget.venue!.twitter!;
    liTEC.text = widget.venue!.linkedin!;
    postcodeTEC.text = widget.venue!.postCode!;
    super.initState();
  }

 final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/applogo.png', height: AppBar().preferredSize.height - 15),
        backgroundColor: primaryColor,
        actions: [
          Center(child: InkWell(onTap: () => utilService.goBackDialog(), child: Text('Cancel'))),
          SizedBox(width: 15),
        ],
      ),
      body: Column(
          children: [
            Heading(title:'Social Media'),
            Expanded(
              child: Container(
                width: double.infinity,
                color: appBackground,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(padding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       marketingDetails(),
                      CustomButton(
                          color: orangeColor,
                          text: 'Edit Venue',
                          function: () async {
                              utilService.showLoading();
                              String venueID = widget!.venue!.venueID!;
                              Map venue = {
                                //Basic
                                'accountID': userController.currentUser.value.accountID,
                                'accountAdmin': userController.currentUser.value.userID,
                                'venueID': venueID,
                                'postCode': postcodeTEC.text ?? '',
                                //Social Media Links
                                'facebook': fbTEC.text ?? '',
                                'instagram': instaTEC.text ?? '',
                                'twitter': twTEC.text ?? '',
                                'linkedin': liTEC.text ?? '',
                              };
                              await cloudFunction(functionName: 'updateVenue', parameters: venue, action: () => Get.offAll(() => HomePage()));
                            }
                          ),
                    ],
                  ),
                ),
              ),


                  ),
               ] ),
              );

  }

 marketingDetails() {
    return Column(children: [

      SizedBox(height: 20),
      CustomTextField(controller: fbTEC, hint: 'https://facebook.com/', label: 'Facebook Link', textInputType: TextInputType.url),
      CustomTextField(controller: instaTEC, hint: 'https://instagram.com/', label: 'Instagram Link', textInputType: TextInputType.url),
      CustomTextField(controller: twTEC, hint: 'https://x.com/', label: 'X Link', textInputType: TextInputType.url),
      CustomTextField(controller: liTEC, hint: 'https://linkedin.com/', label: 'LinkedIn Link', textInputType: TextInputType.url),
      //CustomTextField(controller: postcodeTEC, hint: 'postcode', label: 'Postcode', textInputType: TextInputType.text),

    ]);
  }






}
