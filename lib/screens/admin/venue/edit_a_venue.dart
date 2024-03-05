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

class EditAVenue extends StatefulWidget {
  final Venue? venue;

  EditAVenue({this.venue});

  @override
  _EditAVenueState createState() => _EditAVenueState();
}

class _EditAVenueState extends State<EditAVenue> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxInt index = 1.obs;
  final TextEditingController venueNameTEC = TextEditingController(), descriptionTEC = TextEditingController();
  final TextEditingController buildingNameTEC = TextEditingController(), townTEC = TextEditingController(), postCodeTEC = TextEditingController(), telephoneTEC = TextEditingController(), websiteTEC = TextEditingController(), bookingLinkTEC = TextEditingController(); //, bookingLinkTEC = TextEditingController();
  final TextEditingController mondayOpen = TextEditingController(), mondayClose = TextEditingController(), tuesdayOpen = TextEditingController(), tuesdayClose = TextEditingController(), wednesdayOpen = TextEditingController(), wednesdayClose = TextEditingController(), thursdayOpen = TextEditingController(), thursdayClose = TextEditingController(), fridayOpen = TextEditingController(), fridayClose = TextEditingController(), saturdayOpen = TextEditingController(), saturdayClose = TextEditingController(), sundayOpen = TextEditingController(), sundayClose = TextEditingController();
  var promoFile = File('').obs;
  var logoFile = File('').obs;
  String? promoURL, logoURL;


  final utilService = Get.find<UtilService>();
  final storageService = Get.find<StorageService>();
  final userController = Get.find<UserController>();

  Rx<bool> isOpenOnMonday = true.obs, isOpenOnTuesday = true.obs, isOpenOnWednesday = true.obs, isOpenOnThursday = false.obs, isOpenOnFriday = false.obs, isOpenOnSaturday = false.obs, isOpenOnSunday = false.obs;

  FocusScopeNode node = FocusScopeNode();

  @override
  void initState() {
    venueNameTEC.text = widget.venue!.venueName!;
    buildingNameTEC.text = widget.venue!.streetAddress!;
    townTEC.text = widget.venue!.townCity!;
    postCodeTEC.text = widget.venue!.postCode!;
    telephoneTEC.text = widget.venue!.venuePhoneNumber!;
    websiteTEC.text = widget.venue!.website!;
    bookingLinkTEC.text = widget.venue!.venueBookingLink!;
    descriptionTEC.text = widget.venue!.venueDescription!;
    promoURL = widget.venue!.coverURL;
    logoURL = widget.venue!.logo;

    //bookingLinkTEC.text = widget.venue.venueBookingLink;
    mondayOpen.text = widget.venue!.monday!.open!.toStringAsFixed(2);
    tuesdayOpen.text = widget.venue!.tuesday!.open!.toStringAsFixed(2);
    wednesdayOpen.text = widget.venue!.wednesday!.open!.toStringAsFixed(2);
    thursdayOpen.text = widget.venue!.thursday!.open!.toStringAsFixed(2);
    fridayOpen.text = widget.venue!.friday!.open!.toStringAsFixed(2);
    saturdayOpen.text = widget.venue!.saturday!.open!.toStringAsFixed(2);
    sundayOpen.text = widget.venue!.sunday!.open!.toStringAsFixed(2);
    mondayClose.text = widget.venue!.monday!.close!.toStringAsFixed(2);
    tuesdayClose.text = widget.venue!.tuesday!.close!.toStringAsFixed(2);
    wednesdayClose.text = widget.venue!.wednesday!.close!.toStringAsFixed(2);
    thursdayClose.text = widget.venue!.thursday!.close!.toStringAsFixed(2);
    fridayClose.text = widget.venue!.friday!.close!.toStringAsFixed(2);
    saturdayClose.text = widget.venue!.saturday!.close!.toStringAsFixed(2);
    sundayClose.text = widget.venue!.sunday!.close!.toStringAsFixed(2);
    isOpenOnMonday.value = widget.venue!.monday!.isOpen!;
    isOpenOnTuesday.value = widget.venue!.tuesday!.isOpen!;
    isOpenOnWednesday.value = widget.venue!.wednesday!.isOpen!;
    isOpenOnThursday.value = widget.venue!.thursday!.isOpen!;
    isOpenOnFriday.value = widget.venue!.friday!.isOpen!;
    isOpenOnSaturday.value = widget.venue!.saturday!.isOpen!;
    isOpenOnSunday.value = widget.venue!.sunday!.isOpen!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);

    return WillPopScope(
      onWillPop: () => index.value == 1 ? utilService.goBackDialog() : index--,
      child: Scaffold(
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
            Heading(title: 'VENUE DETAILS'),
               Expanded(
                child: Container(
                  width: double.infinity,
                  color: appBackground,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(padding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Divider(height: 50, color: Colors.white54),
        generalVenueDetails(),
                            CustomButton(
                                color: orangeColor,
                                text: 'Update details',
                                function: () async {
                                  if (!formKey.currentState!.validate()) {
                                    showRedAlert('Please fill all the necessary details');
                                    return;
                                  }
                                  final utilService = Get.find<UtilService>();
                                  final firestoreService = Get.find<FirestoreService>();
                                  utilService.showLoading();
                                  String venueID = widget.venue!.venueID!;
              Map venue = {
              //Basic
              'accountID': userController.currentUser.value.accountID,
              'accountAdmin': userController.currentUser.value.userID,
              'venueID': venueID,
              'venueName': venueNameTEC.text,
              'venueDescription': descriptionTEC.text,
              'logo': logoURL,
              'coverURL': promoURL,
              'images': [promoURL],
              //Location
              'streetAddress': buildingNameTEC.text,
              'townCity': townTEC.text,
              'postCode': postCodeTEC.text.replaceAll(" ", "").toUpperCase(),
              //'venueBookingLink': bookingLinkTEC.text ?? '',
              'website': websiteTEC.text,
              'venuePhoneNumber': telephoneTEC.text,
              //Timing
              'monday': {'open': parseToDouble(mondayOpen.text), 'close': parseToDouble(mondayClose.text), 'isOpen': isOpenOnMonday.value},
              'tuesday': {'open': parseToDouble(tuesdayOpen.text), 'close': parseToDouble(tuesdayClose.text), 'isOpen': isOpenOnTuesday.value},
              'wednesday': {'open': parseToDouble(wednesdayOpen.text), 'close': parseToDouble(wednesdayClose.text), 'isOpen': isOpenOnWednesday.value},
              'thursday': {'open': parseToDouble(thursdayOpen.text), 'close': parseToDouble(thursdayClose.text), 'isOpen': isOpenOnThursday.value},
              'friday': {'open': parseToDouble(fridayOpen.text), 'close': parseToDouble(fridayClose.text), 'isOpen': isOpenOnFriday.value},
              'saturday': {'open': parseToDouble(saturdayOpen.text), 'close': parseToDouble(saturdayClose.text), 'isOpen': isOpenOnSaturday.value},
              'sunday': {'open': parseToDouble(sundayOpen.text), 'close': parseToDouble(sundayClose.text), 'isOpen': isOpenOnSunday.value},
              };
              await cloudFunction(functionName: 'updateVenue', parameters: venue, action: () => Get.offAll(() => HomePage()));
              }
        ),

        //                     CustomButton(
        //                         color: orangeColor,
        //                         text: index.value == 6 ? 'Edit Venue' : 'Proceed',
        //                         function: () async {
        // switch (index.value) {
        // case 1:
        // if (venueNameTEC.text.isEmpty || descriptionTEC.text.isEmpty) return showRedAlert('Please fill up all the details');
        // break;
        // case 2:
        // if (buildingNameTEC.text.isEmpty || townTEC.text.isEmpty || postCodeTEC.text.isEmpty || telephoneTEC.text.isEmpty || websiteTEC.text.isEmpty) return showRedAlert('Please complete all the details');
        // }
        // if (index.value != 6)
        // index++;
        // else {
        // utilService.showLoading();
        // String venueID = widget.venue!.venueID!;
        // if (logoFile.value.path != '') logoURL = await storageService.uploadImage(logoFile.value);
        // if (promoFile.value.path != '') promoURL = await storageService.uploadImage(promoFile.value);
        // Map venue = {
        // //Basic
        // 'accountID': userController.currentUser.value.accountID,
        // 'accountAdmin': userController.currentUser.value.userID,
        // 'venueID': venueID,
        // 'venueName': venueNameTEC.text,
        // 'venueDescription': descriptionTEC.text,
        // 'logo': logoURL,
        // 'coverURL': promoURL,
        // 'images': [promoURL],
        // //Location
        // 'streetAddress': buildingNameTEC.text,
        // 'townCity': townTEC.text,
        // 'postCode': postCodeTEC.text.replaceAll(" ", "").toUpperCase(),
        // //'venueBookingLink': bookingLinkTEC.text ?? '',
        // 'website': websiteTEC.text,
        // 'venuePhoneNumber': telephoneTEC.text,
        // //Timing
        // 'monday': {'open': parseToDouble(mondayOpen.text), 'close': parseToDouble(mondayClose.text), 'isOpen': isOpenOnMonday.value},
        // 'tuesday': {'open': parseToDouble(tuesdayOpen.text), 'close': parseToDouble(tuesdayClose.text), 'isOpen': isOpenOnTuesday.value},
        // 'wednesday': {'open': parseToDouble(wednesdayOpen.text), 'close': parseToDouble(wednesdayClose.text), 'isOpen': isOpenOnWednesday.value},
        // 'thursday': {'open': parseToDouble(thursdayOpen.text), 'close': parseToDouble(thursdayClose.text), 'isOpen': isOpenOnThursday.value},
        // 'friday': {'open': parseToDouble(fridayOpen.text), 'close': parseToDouble(fridayClose.text), 'isOpen': isOpenOnFriday.value},
        // 'saturday': {'open': parseToDouble(saturdayOpen.text), 'close': parseToDouble(saturdayClose.text), 'isOpen': isOpenOnSaturday.value},
        // 'sunday': {'open': parseToDouble(sundayOpen.text), 'close': parseToDouble(sundayClose.text), 'isOpen': isOpenOnSunday.value},
        // };
        // await cloudFunction(functionName: 'updateVenue', parameters: venue, action: () => Get.offAll(() => HomePage()));
        // }
        // })
        ]
        )
        )
        )
        )
        ]
        )
        ),
    );
}




  generalVenueDetails() {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            logoFile.value = await storageService.pickImage();
          },
          child: Stack(
            children: [
              CachedImage(
                roundedCorners: true,
                url: logoURL,
                imageFile: logoFile.value.path == '' ? null : logoFile.value,
                height: 120,
                circular: false,
              ),
              Container(
                width: 120,
                height: 120,
                padding: const EdgeInsets.all(5),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 15,
                    child: Icon(Icons.camera_alt, color: primaryColor, size: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
        CustomTextField(validate: true, hint: 'Venue Name', label: 'Venue Name *', textInputType: TextInputType.text, controller: venueNameTEC),
        CustomTextField(validate: true, hint: '\nVenue Description', label: 'Venue Description *', textInputType: TextInputType.text, controller: descriptionTEC, maxLines: 3),
        InkWell(
          onTap: () async {
            promoFile.value = await storageService.pickImage(aspectRatio: CropAspectRatioPreset.ratio5x3);
          },
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                height: MediaQuery.of(context).size.height * 0.25,
                child: CachedImage(
                  roundedCorners: true,
                  url: promoURL,
                  imageFile: promoFile.value.path == '' ? null : promoFile.value,
                  height: double.infinity,
                  circular: false,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                padding: const EdgeInsets.all(5),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 15,
                    child: Icon(Icons.camera_alt, color: primaryColor, size: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
    Column(children: [
    Text('Contact Details', textScaleFactor: 1.5, style: TextStyle(fontWeight: FontWeight.bold)),
    SizedBox(height: 20),
    CustomTextField(validate: true, hint: 'Building Name/No & Street', label: 'Building Name/No & Street *', textInputType: TextInputType.text, controller: buildingNameTEC),
    CustomTextField(validate: true, hint: 'Town', label: 'Town/City *', textInputType: TextInputType.text, controller: townTEC),
    CustomTextField(validate: true, hint: 'Postcode', label: 'Postcode *', textInputType: TextInputType.text, controller: postCodeTEC),
    CustomTextField(validate: true, hint: 'Telephone', label: 'Telephone *', textInputType: TextInputType.phone, controller: telephoneTEC),
    CustomTextField(validate: true, hint: 'Website Address', label: 'Website Address *', textInputType: TextInputType.url, controller: websiteTEC),
    CustomTextField(validate: false, hint: 'Venue Booking Link', label: 'Venue Booking Link', textInputType: TextInputType.url, controller: bookingLinkTEC),
    ]
    ),

    Column(children: [
      SizedBox(height: 30),
    Text('Venue Timing', textScaleFactor: 1.5, style: TextStyle(fontWeight: FontWeight.bold)),
    SizedBox(height: 20),
    Text('Enter the days and times you open and close. Uncheck the day if the venue is closed on that day', style: TextStyle(color: Colors.grey)),
    SizedBox(height: 20),
    Row(children: [
    Expanded(flex: 22, child: Text('')),
    Expanded(flex: 15, child: Text('Opens At', textScaleFactor: 0.9, textAlign: TextAlign.center)),
    Expanded(flex: 15, child: Text('Closes At', textScaleFactor: 0.9, textAlign: TextAlign.center)),
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
    if (isOpenOnMonday.value) Expanded(flex: 15, child: customText(mondayOpen)),
    if (isOpenOnMonday.value) Expanded(flex: 15, child: customText(mondayClose)),
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
    if (isOpenOnTuesday.value) Expanded(flex: 15, child: customText(tuesdayOpen)),
    if (isOpenOnTuesday.value) Expanded(flex: 15, child: customText(tuesdayClose)),
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
    if (isOpenOnWednesday.value) Expanded(flex: 15, child: customText(wednesdayOpen)),
    if (isOpenOnWednesday.value) Expanded(flex: 15, child: customText(wednesdayClose)),
    if (isOpenOnWednesday.value)

    if (!isOpenOnWednesday.value) Expanded(flex: 40, child: closedText()),
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
    if (isOpenOnThursday.value) Expanded(flex: 15, child: customText(thursdayOpen)),
    if (isOpenOnThursday.value) Expanded(flex: 15, child: customText(thursdayClose)),
    if (isOpenOnThursday.value)

    if (!isOpenOnThursday.value) Expanded(flex: 40, child: closedText()),
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
    if (isOpenOnFriday.value) Expanded(flex: 15, child: customText(fridayOpen)),
    if (isOpenOnFriday.value) Expanded(flex: 15, child: customText(fridayClose)),
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
    if (isOpenOnSaturday.value) Expanded(flex: 15, child: customText(saturdayOpen)),
    if (isOpenOnSaturday.value) Expanded(flex: 15, child: customText(saturdayClose)),
    if (isOpenOnSaturday.value)

    if (!isOpenOnSaturday.value) Expanded(flex: 40, child: closedText()),
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
    if (isOpenOnSunday.value) Expanded(flex: 15, child: customText(sundayOpen)),
    if (isOpenOnSunday.value) Expanded(flex: 15, child: customText(sundayClose)),
    if (isOpenOnSunday.value)
    if (!isOpenOnSunday.value) Expanded(flex: 40, child: closedText()),
    ]),
    ]),
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
        keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
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
        keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
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
