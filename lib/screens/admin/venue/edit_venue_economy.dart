import 'dart:io';

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
import 'package:eatoutroundabout/widgets/timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

class EditVenueEconomyDetails extends StatefulWidget {
  final Venue? venue;

  EditVenueEconomyDetails({this.venue});

  @override
  _EditVenueEconomyDetailsState createState() => _EditVenueEconomyDetailsState();
}

class _EditVenueEconomyDetailsState extends State<EditVenueEconomyDetails> {
  final loading = true.obs;
  final employeesCountTEC = TextEditingController();
  final disabledEmployeesCountTEC = TextEditingController();
  final TextEditingController postcodeTEC = TextEditingController();

final firestoreService = Get.find<FirestoreService>();
  final utilService = Get.find<UtilService>();
  final storageService = Get.find<StorageService>();
  final userController = Get.find<UserController>();



 // FocusScopeNode node = FocusScopeNode();

  @override
  void initState() {
    employeesCountTEC.text = widget.venue!.noEmployees!.toString();
    disabledEmployeesCountTEC.text = widget!.venue!.noDisabledEmployees!.toString();
    postcodeTEC.text = widget.venue!.postCode!;
    super.initState();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/applogo.png', height: AppBar().preferredSize.height - 15),
        backgroundColor: primaryColor,
        actions: [
          Center(child: InkWell(onTap: () => utilService.goBackDialog(), child: Text('Cancel'))),
          SizedBox(width: 15),
        ],
      ),
      body:
        Column(
          children: [
            Heading(title:'Economy'),
             Expanded(
              child: Container(
                width: double.infinity,
                color: appBackground,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(padding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      economyDetails(),
                      Divider(height: 50, color: Colors.white54),
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
                              'noEmployees': int.parse(employeesCountTEC.text),
                              'noDisabledEmployees': int.parse(disabledEmployeesCountTEC.text),

                            };
                            await cloudFunction(functionName: 'updateVenue', parameters: venue, action: () => Get.offAll(() => HomePage()));
                          }
                      ),
                      //
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }


economyDetails() {
    return Column(children: [
      Text('Economic Value', textScaleFactor: 1.5, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 20),
      //CustomTextField(label: 'No. of Employees *', hint: 'Enter No. of Employees', controller: employeesCountTEC, textInputType: TextInputType.numberWithOptions(signed: false, decimal: false)),
      CustomTextField(validate: true, hint: 'No. employees', label: 'How many people do you employ? *', controller: employeesCountTEC, textInputType: TextInputType.numberWithOptions(signed: false, decimal: false)),
      CustomTextField(validate: true, hint: 'No. disabled employees', label: 'How many employees are disabled?*', textInputType: TextInputType.numberWithOptions(signed: false, decimal: false), controller: disabledEmployeesCountTEC),

    ]);
  }



}
