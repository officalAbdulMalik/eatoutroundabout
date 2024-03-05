import 'dart:io';

import 'package:eatoutroundabout/controllers/user_controller.dart';
import 'package:eatoutroundabout/screens/home/home_page.dart';
import 'package:eatoutroundabout/services/cloud_function.dart';
import 'package:eatoutroundabout/services/storage_service.dart';
import 'package:eatoutroundabout/services/util_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/cached_image.dart';
import 'package:eatoutroundabout/widgets/custom_button.dart';
import 'package:eatoutroundabout/widgets/custom_text_field.dart';
import 'package:eatoutroundabout/widgets/timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:uuid/uuid.dart';
import 'package:eatoutroundabout/widgets/heading.dart';

class AddNewVenue extends StatefulWidget {
  @override
  _AddNewVenueState createState() => _AddNewVenueState();
}

class _AddNewVenueState extends State<AddNewVenue> {
  RxInt index = 1.obs;
  final TextEditingController venueNameTEC = TextEditingController(),
      descriptionTEC = TextEditingController();
  final TextEditingController buildingNameTEC = TextEditingController(),
      townTEC = TextEditingController(),
      postCodeTEC = TextEditingController(),
      telephoneTEC = TextEditingController(),
      websiteTEC = TextEditingController(),
      bookingLinkTEC = TextEditingController(),
      venueTypeTEC = TextEditingController();
  final TextEditingController mondayOpen = TextEditingController(),
      mondayClose = TextEditingController(),
      tuesdayOpen = TextEditingController(),
      tuesdayClose = TextEditingController(),
      wednesdayOpen = TextEditingController(),
      wednesdayClose = TextEditingController(),
      thursdayOpen = TextEditingController(),
      thursdayClose = TextEditingController(),
      fridayOpen = TextEditingController(),
      fridayClose = TextEditingController(),
      saturdayOpen = TextEditingController(),
      saturdayClose = TextEditingController(),
      sundayOpen = TextEditingController(),
      sundayClose = TextEditingController();
  final TextEditingController
      fbTEC = TextEditingController(),
      instaTEC = TextEditingController(),
      twTEC = TextEditingController(),
      liTEC = TextEditingController();


  File? promoFile, logoFile;

  RxString venueType = 'cafe'.obs;

  final utilService = Get.find<UtilService>();
  final storageService = Get.find<StorageService>();
  final userController = Get.find<UserController>();

  Rx<bool> isOpenOnMonday = true.obs,
      isOpenOnTuesday = true.obs,
      isOpenOnWednesday = true.obs,
      isOpenOnThursday = false.obs,
      isOpenOnFriday = false.obs,
      isOpenOnSaturday = false.obs,
      isOpenOnSunday = false.obs;
  Rx<bool> showTips = false.obs;
  RxList<String> selectedFoodTypes = ['Other'].obs;
  List foodTypes = [
    'Abyssinian',
    'African',
    'Afternoon Tea',
    'American',
    'Bistro',
    'Brazillian',
    'Cantonese',
    'Chinese',
    'Desserts',
    'Indian',
    'Italian',
    'Japanese',
    'Lebanese',
    'Mediterranean',
    'Mexican',
    'Modern British',
    'Persian',
    'Polish',
    'Portuguese',
    'Spanish',
    'Tapas',
    'Thai',
    'Traditional British',
    'Turkish',
    'Other'
  ];

  FocusScopeNode node = FocusScopeNode();

  @override
  void initState() {
    mondayOpen.text = tuesdayOpen.text = wednesdayOpen.text =
        thursdayOpen.text = fridayOpen.text = saturdayOpen.text =
        sundayOpen.text = '10.00';
    mondayClose.text = tuesdayClose.text = wednesdayClose.text =
        thursdayClose.text = fridayClose.text = saturdayClose.text =
        sundayClose.text = '23.00';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);

    return WillPopScope(
      onWillPop: () => index.value == 1 ? utilService.goBackDialog() : index--,
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/images/applogo.png',
              height: AppBar().preferredSize.height - 15),
          backgroundColor: primaryColor,
          actions: [
            Center(child: InkWell(onTap: () => utilService.goBackDialog(),
                child: Text('Cancel'))),
            SizedBox(width: 15),
          ],
        ),
        body: Obx(() {
          return Column(

            children: [

             // VenueTimeline(progressIndex: index.value - 1),
              Heading(title: 'ADD VENUE'),
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: appBackground,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(padding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        switchLayout(),
                        Divider(height: 50, color: Colors.white54),

                        CustomButton(
                            color: orangeColor,
                            text: index.value == 6 ? 'Add Venue' : 'Proceed',
                            function: () async {
                              switch (index.value) {
                                case 1:
                                  if (logoFile == null || promoFile == null || venueNameTEC.text.isEmpty || descriptionTEC.text.isEmpty) return showRedAlert('Please fill up all the details');
                                  break;
                                case 2:
                                  if (buildingNameTEC.text.isEmpty || townTEC.text.isEmpty || postCodeTEC.text.isEmpty || telephoneTEC.text.isEmpty || websiteTEC.text.isEmpty) return showRedAlert('Please fill up all the details');
                              }
                              if (index.value != 6)
                                index++;
                              else {
                                utilService.showLoading();
                                String venueID = Uuid().v1();
                                String logo = await storageService.uploadImage(logoFile!);
                                String promo = await storageService.uploadImage(promoFile!);
                                Map venue = {
                                  'accountID': userController.currentUser.value
                                      .accountID,
                                  'accountAdmin': userController.currentUser
                                      .value.userID,
                                  'venueID': venueID,
                                  'venueName': venueNameTEC.text,
                                  'venueDescription': descriptionTEC.text,
                                  'approved': false,
                                  'paused': false,
                                  'streetAddress': buildingNameTEC.text,
                                  'townCity': townTEC.text,
                                  'postCode': postCodeTEC.text.replaceAll(
                                      " ", "").toUpperCase(),
                                  //'venueType': venueType.value,
                                  'monday': {
                                    'open': parseToDouble(mondayOpen.text),
                                    'close': parseToDouble(mondayClose.text),
                                    'isOpen': isOpenOnMonday.value
                                  },
                                  'tuesday': {
                                    'open': parseToDouble(tuesdayOpen.text),
                                    'close': parseToDouble(tuesdayClose.text),
                                    'isOpen': isOpenOnTuesday.value
                                  },
                                  'wednesday': {
                                    'open': parseToDouble(wednesdayOpen.text),
                                    'close': parseToDouble(wednesdayClose.text),
                                    'isOpen': isOpenOnWednesday.value
                                  },
                                  'thursday': {
                                    'open': parseToDouble(thursdayOpen.text),
                                    'close': parseToDouble(thursdayClose.text),
                                    'isOpen': isOpenOnThursday.value
                                  },
                                  'friday': {
                                    'open': parseToDouble(fridayOpen.text),
                                    'close': parseToDouble(fridayClose.text),
                                    'isOpen': isOpenOnFriday.value
                                  },
                                  'saturday': {
                                    'open': parseToDouble(saturdayOpen.text),
                                    'close': parseToDouble(saturdayClose.text),
                                    'isOpen': isOpenOnSaturday.value
                                  },
                                  'sunday': {
                                    'open': parseToDouble(sundayOpen.text),
                                    'close': parseToDouble(sundayClose.text),
                                    'isOpen': isOpenOnSunday.value
                                  },

                                  // 'receptionist': userController.currentUser
                                  //     .value.userID,
                                  'venueBookingLink': bookingLinkTEC.text,
                                  'website': websiteTEC.text,
                                  'venuePhoneNumber': telephoneTEC.text,
                                  'otherFoodType':'none',
                                  'venueType': venueTypeTEC.text,

                                  //economy
                                  // 'lepRestricted': lepRestrictedTEC.text,
                                  // 'localAuthRestricted': localAuthRestricted!,
                                  // 'wardRestricted': wardRestricted!,
                                  // 'venueRestricted': venueRestricted!,
                                  // 'bidRestricted': bidRestricted!,

                                  //Memberships and Accreditations
                                  // 'yorkshireMark': yorkshireMark!,
                                  // 'yorkshireMarkApproved': yorkshireMarkApproved!,

                                  // sustainability
                                  // 'venueImpactStatus': venueImpactStatus!,
                                  // 'sourceLocally': sourceLocally!,
                                  // 'foodWaste': foodWaste!,
                                  // 'cleanEnergy': cleanEnergy!,
                                  // 'singleUsePlastic': singleUsePlastic!,
                                  // 'sustainableFish': sustainableFish!,
                                  // 'sustainableMeat': sustainableMeat!,
                                  // 'plantBasedOptions': sustainableMeat!,
                                  // 'averageCarbonPerMeal': averageCarbonPerMeal!,
                                  // 'venueCarbonFootprintScore':venueCarbonFootprintScore!,

                                  // equality diversity and inclusion
                                  // 'dogFriendly': dogFriendly!,
                                  // 'wheelChairAccess': wheelChairAccess!,
                                  // 'dietaryPreferences': dietaryPreferences!,
                                  // 'intolerances': intolerances!,
                                  // 'allergies': allergies!,
                                  // 'inclusiveToilets': inclusiveToilets!,
                                  // 'noDisabledEmployees': noDisabledEmployees!,
                                  // 'noEmployees': noEmployees!,

                                  // marketing
                                  // 'preTheatreDining': preTheatreDining!,
                                  // 'facebook': facebook!,
                                  // 'instagram': instagram!,
                                  // 'twitter': twitter!,
                                  // 'linkedin': linkedin!,
                                  // 'averageRating': averageRating!,
                                  // 'totalRatingsCount': totalRatingsCount!,

                                  //covid
                                  // 'goodToGo': goodToGo!,
                                  // 'goodToGoCertificateApproved': goodToGoCertificateApproved!,
                                  // 'takeaway': takeaway!,
                                };
                                await cloudFunction(
                                    functionName: 'addVenue',
                                    parameters: venue,
                                    action: () async {
                                      Map parameters = {
                                        'mobile': userController.currentUser.value.mobile,
                                        'venueID': venueID,
                                        'type': 'venueAdmin',
                                        'receptionist': true,
                                      };
                                      await cloudFunction(functionName: 'addStaff', parameters: parameters, action: () {});
                                      Get.offAll(() => HomePage());
                                    });
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  switchLayout() {
    switch (index.value) {
      case 1:
        return step1();
    }
  }

  step1() {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            logoFile = await storageService.pickImage();
            setState(() {});
          },
          child: CachedImage(
            text: 'Add Logo',
            roundedCorners: true,
            imageFile: logoFile,
            height: 150,
            circular: false,
            url: 'add',
          ),
        ),
        CustomTextField(validate: true,
            hint: 'Venue Name',
            label: 'Venue Name *',
            textInputType: TextInputType.text,
            controller: venueNameTEC),
        SizedBox(height: 20),
        Text('Contact Details', textScaleFactor: 1.5,
            style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        CustomTextField(validate: true,
            hint: 'Building Name/No & Street',
            label: 'Building Name/No & Street *',
            textInputType: TextInputType.text,
            controller: buildingNameTEC),
        CustomTextField(validate: true,
            hint: 'Town',
            label: 'Town/City *',
            textInputType: TextInputType.text,
            controller: townTEC),
        CustomTextField(validate: true,
            hint: 'Postcode',
            label: 'Postcode *',
            textInputType: TextInputType.text,
            controller: postCodeTEC),
        CustomTextField(validate: true,
            hint: 'Telephone',
            label: 'Telephone *',
            textInputType: TextInputType.phone,
            controller: telephoneTEC),
        CustomTextField(validate: true,
            hint: 'Website Address',
            label: 'Website Address *',
            textInputType: TextInputType.url,
            controller: websiteTEC),
        CustomTextField(validate: false,
            hint: 'Venue Booking Link',
            label: 'Venue Booking Link',
            textInputType: TextInputType.url,
            controller: bookingLinkTEC),

        SizedBox(height: 20),

        SizedBox(height: 10),
        Text('Venue Type'),
        DropdownButtonFormField<String>(

          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: BorderSide(width: 2, color: primaryColor),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 20)),
          isExpanded: true,
          style: TextStyle(color: primaryColor, fontSize: 17),
          value: venueType.value,
          items: [
            DropdownMenuItem(child: Text('Cafe', textScaleFactor: 1,
                style: TextStyle(color: Colors.black)), value: 'cafe'),
            DropdownMenuItem(child: Text('Pub', textScaleFactor: 1,
                style: TextStyle(color: Colors.black)), value: 'pub'),
            DropdownMenuItem(child: Text('Restaurant', textScaleFactor: 1,
                style: TextStyle(color: Colors.black)), value: 'restaurant'),
            DropdownMenuItem(child: Text('Fast Food', textScaleFactor: 1,
                style: TextStyle(color: Colors.black)), value: 'fast-food'),
            DropdownMenuItem(child: Text('Casual Dining', textScaleFactor: 1,
                style: TextStyle(color: Colors.black)), value: 'casual dining'),
          ],
          onChanged: (value) => venueType.value = value!,
        ),

        CustomTextField(validate: true,
            hint: '\nVenue Description',
            label: 'Venue Description *',
            textInputType: TextInputType.text,
            controller: descriptionTEC,
            maxLines: 3), InkWell(
          onTap: () async {
            promoFile = await storageService.pickImage(
                aspectRatio: CropAspectRatioPreset.ratio5x3);
            setState(() {});
          },
          child: Container(
            height: 180,
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: CachedImage(
              roundedCorners: true,
              imageFile: promoFile,
              height: double.infinity,
              circular: false,
              url: 'promo',
            ),
          ),
        ),
        Text('Opening Times', textScaleFactor: 1.5,
            style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        Text(
            'Enter the days and times you open. Uncheck the day if the venue is closed on that day',
            style: TextStyle(color: Colors.grey)),
        SizedBox(height: 20),
        Row(children: [
          Expanded(flex: 22, child: Text('')),
          Expanded(flex: 15,
              child: Text('Opens At', textScaleFactor: 0.9,
                  textAlign: TextAlign.center)),
          Expanded(flex: 15,
              child: Text('Closes At', textScaleFactor: 0.9,
                  textAlign: TextAlign.center)),

        ]),
        SizedBox(height: 15),
        Row(children: [
          Expanded(
            flex: 25,
            child: CheckboxListTile(
              visualDensity: VisualDensity.compact,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              title: Text('Monday', style: TextStyle(color: greenColor)),
              value: isOpenOnMonday.value,
              onChanged: (val) {
                isOpenOnMonday.value = val!;
                if (!val) {
                  mondayOpen.text = '-1';
                  mondayClose.text = '-1';
                } else {
                  mondayOpen.text = '10.00';
                  mondayClose.text = '23.00';
                }
              },
            ),
          ),
          if (isOpenOnMonday.value) Expanded(
              flex: 15, child: customText(mondayOpen)),
          if (isOpenOnMonday.value) Expanded(
              flex: 15, child: customText(mondayClose)),
          if (isOpenOnMonday.value)
            if (!isOpenOnMonday.value) Expanded(flex: 40, child: closedText()),
        ]),
        Row(children: [
          Expanded(
            flex: 25,
            child: CheckboxListTile(
              visualDensity: VisualDensity.compact,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              title: Text('Tuesday', style: TextStyle(color: greenColor)),
              value: isOpenOnTuesday.value,
              onChanged: (val) {
                isOpenOnTuesday.value = val!;
                if (!val) {
                  tuesdayOpen.text = '-1';
                  tuesdayClose.text = '-1';
                } else {
                  tuesdayOpen.text = '10.00';
                  tuesdayClose.text = '23.00';
                }
              },
            ),
          ),
          if (isOpenOnTuesday.value) Expanded(
              flex: 15, child: customText(tuesdayOpen)),
          if (isOpenOnTuesday.value) Expanded(
              flex: 15, child: customText(tuesdayClose)),
          if (isOpenOnTuesday.value)
            if (!isOpenOnTuesday.value) Expanded(flex: 40, child: closedText()),
        ]),
        Row(children: [
          Expanded(
            flex: 25,
            child: CheckboxListTile(
              visualDensity: VisualDensity.compact,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              title: Text('Wednesday', style: TextStyle(color: greenColor)),
              value: isOpenOnWednesday.value,
              onChanged: (val) {
                isOpenOnWednesday.value = val!;
                if (!val) {
                  wednesdayOpen.text = '-1';
                  wednesdayClose.text = '-1';
                } else {
                  wednesdayOpen.text = '10.00';
                  wednesdayClose.text = '23.00';
                }
              },
            ),
          ),
          if (isOpenOnWednesday.value) Expanded(
              flex: 15, child: customText(wednesdayOpen)),
          if (isOpenOnWednesday.value) Expanded(
              flex: 15, child: customText(wednesdayClose)),
          if (isOpenOnWednesday.value)

            if (!isOpenOnWednesday.value) Expanded(
                flex: 40, child: closedText()),
        ]),
        Row(children: [
          Expanded(
            flex: 25,
            child: CheckboxListTile(
              visualDensity: VisualDensity.compact,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              title: Text('Thursday', style: TextStyle(color: greenColor)),
              value: isOpenOnThursday.value,
              onChanged: (val) {
                isOpenOnThursday.value = val!;

                if (!val) {
                  thursdayOpen.text = '-1';
                  thursdayClose.text = '-1';
                } else {
                  thursdayOpen.text = '10.00';
                  thursdayClose.text = '23.00';
                }
              },
            ),
          ),
          if (isOpenOnThursday.value) Expanded(
              flex: 15, child: customText(thursdayOpen)),
          if (isOpenOnThursday.value) Expanded(
              flex: 15, child: customText(thursdayClose)),
          if (isOpenOnThursday.value)

            if (!isOpenOnThursday.value) Expanded(
                flex: 40, child: closedText()),
        ]),
        Row(children: [
          Expanded(
            flex: 25,
            child: CheckboxListTile(
              visualDensity: VisualDensity.compact,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              title: Text('Friday', style: TextStyle(color: greenColor)),
              value: isOpenOnFriday.value,
              onChanged: (val) {
                isOpenOnFriday.value = val!;

                if (!val) {
                  fridayOpen.text = '-1';
                  fridayClose.text = '-1';
                } else {
                  fridayOpen.text = '10.00';
                  fridayClose.text = '23.00';
                }
              },
            ),
          ),
          if (isOpenOnFriday.value) Expanded(
              flex: 15, child: customText(fridayOpen)),
          if (isOpenOnFriday.value) Expanded(
              flex: 15, child: customText(fridayClose)),
          if (isOpenOnFriday.value)

            if (!isOpenOnFriday.value) Expanded(flex: 40, child: closedText()),
        ]),
        Row(children: [
          Expanded(
            flex: 25,
            child: CheckboxListTile(
              visualDensity: VisualDensity.compact,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              title: Text('Saturday', style: TextStyle(color: greenColor)),
              value: isOpenOnSaturday.value,
              onChanged: (val) {
                isOpenOnSaturday.value = val!;
                if (!val) {
                  saturdayOpen.text = '-1';
                  saturdayClose.text = '-1';
                } else {
                  saturdayOpen.text = '10.00';
                  saturdayClose.text = '23.00';
                }
              },
            ),
          ),
          if (isOpenOnSaturday.value) Expanded(
              flex: 15, child: customText(saturdayOpen)),
          if (isOpenOnSaturday.value) Expanded(
              flex: 15, child: customText(saturdayClose)),
          if (isOpenOnSaturday.value)

            if (!isOpenOnSaturday.value) Expanded(
                flex: 40, child: closedText()),
        ]),
        Row(children: [
          Expanded(
            flex: 25,
            child: CheckboxListTile(
              visualDensity: VisualDensity.compact,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              title: Text('Sunday', style: TextStyle(color: greenColor)),
              value: isOpenOnSunday.value,
              onChanged: (val) {
                isOpenOnSunday.value = val!;
                if (!val) {
                  sundayOpen.text = '-1';
                  sundayClose.text = '-1';
                } else {
                  sundayOpen.text = '10.00';
                  sundayClose.text = '23.00';
                }
              },
            ),
          ),
          if (isOpenOnSunday.value) Expanded(
              flex: 15, child: customText(sundayOpen)),
          if (isOpenOnSunday.value) Expanded(
              flex: 15, child: customText(sundayClose)),
          if (isOpenOnSunday.value)
            if (!isOpenOnSunday.value) Expanded(flex: 40, child: closedText()),
        ]),
        SizedBox(height: 20),

      ],
    );
  }


  parseToDouble(String text) {
    if (text != '')
      return double.parse(text);
    else
      return -1; //-1 means closed
  }

  customText(controller) {
    return Container(
      height: 40,
      margin: EdgeInsets.only(right: 10),
      child: TextField(
        keyboardType: TextInputType.numberWithOptions(
            signed: false, decimal: true),
        textInputAction: TextInputAction.next,
        onEditingComplete: () => node.nextFocus(),
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 15),
          hintStyle: TextStyle(color: Colors.grey.shade400),
        ),
      ),
    );
  }

  closedText() {
    return SizedBox(
      height: 40,
      child: TextField(
        readOnly: true,
        enabled: false,
        textAlign: TextAlign.center,
        style: TextStyle(color: redColor, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.numberWithOptions(
            signed: false, decimal: true),
        textInputAction: TextInputAction.next,
        onEditingComplete: () => node.nextFocus(),
        controller: TextEditingController(text: 'Closed'),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          fillColor: Colors.grey.shade300,
          hintStyle: TextStyle(color: Colors.grey.shade400),
        ),
      ),
    );
  }

}
