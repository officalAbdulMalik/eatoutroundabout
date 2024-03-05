import 'package:eatoutroundabout/controllers/user_controller.dart';
import 'package:eatoutroundabout/models/venue_model.dart';
import 'package:eatoutroundabout/models/voucher_model.dart';
import 'package:eatoutroundabout/screens/admin/venue/venue_details.dart';
import 'package:eatoutroundabout/services/cloud_function.dart';
import 'package:eatoutroundabout/services/util_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/custom_button.dart';
import 'package:eatoutroundabout/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VoucherAdminItem extends StatefulWidget {
  final Voucher? voucher;
  final bool? isMyVoucher;
  final Venue? venue;

  VoucherAdminItem({this.voucher, this.isMyVoucher, this.venue});

  @override
  State<VoucherAdminItem> createState() => _VoucherAdminItemState();
}

class _VoucherAdminItemState extends State<VoucherAdminItem> {
  final maxClaimsPerUserTEC = TextEditingController();
  final TextEditingController mondayAcceptTimeStart = TextEditingController(), mondayAcceptTimeEnd = TextEditingController(), tuesdayAcceptTimeStart = TextEditingController(), tuesdayAcceptTimeEnd = TextEditingController(), wednesdayAcceptTimeStart = TextEditingController(), wednesdayAcceptTimeEnd = TextEditingController(), thursdayAcceptTimeStart = TextEditingController(), thursdayAcceptTimeEnd = TextEditingController(), fridayAcceptTimeStart = TextEditingController(), fridayAcceptTimeEnd = TextEditingController(), saturdayAcceptTimeStart = TextEditingController(), saturdayAcceptTimeEnd = TextEditingController(), sundayAcceptTimeStart = TextEditingController(), sundayAcceptTimeEnd = TextEditingController();
  Rx<bool> acceptMonday = true.obs, acceptTuesday = true.obs, acceptWednesday = true.obs, acceptThursday = false.obs, acceptFriday = false.obs, acceptSaturday = false.obs, acceptSunday = false.obs;
  RxBool pausedClaimable = false.obs;


  final miscService = Get.find<UtilService>();
  final utilService = Get.find<UtilService>();
 // final firestoreService = Get.find<FirestoreService>();
  final userController = Get.find<UserController>();

  FocusScopeNode node = FocusScopeNode();

  @override
  void initState() {
    maxClaimsPerUserTEC.text = widget.voucher!.maxClaimsPerUser!.toString();

    mondayAcceptTimeStart.text = widget.voucher!.monday!.acceptTimeStart!.toStringAsFixed(2);
    tuesdayAcceptTimeStart.text = widget.voucher!.tuesday!.acceptTimeStart!.toStringAsFixed(2);
    wednesdayAcceptTimeStart.text = widget.voucher!.wednesday!.acceptTimeStart!.toStringAsFixed(2);
    thursdayAcceptTimeStart.text = widget.voucher!.thursday!.acceptTimeStart!.toStringAsFixed(2);
    fridayAcceptTimeStart.text = widget.voucher!.friday!.acceptTimeStart!.toStringAsFixed(2);
    saturdayAcceptTimeStart.text = widget.voucher!.saturday!.acceptTimeStart!.toStringAsFixed(2);
    sundayAcceptTimeStart.text = widget.voucher!.sunday!.acceptTimeStart!.toStringAsFixed(2);
    mondayAcceptTimeEnd.text = widget.voucher!.monday!.acceptTimeEnd!.toStringAsFixed(2);
    tuesdayAcceptTimeEnd.text = widget.voucher!.tuesday!.acceptTimeEnd!.toStringAsFixed(2);
    wednesdayAcceptTimeEnd.text = widget.voucher!.wednesday!.acceptTimeEnd!.toStringAsFixed(2);
    thursdayAcceptTimeEnd.text = widget.voucher!.thursday!.acceptTimeEnd!.toStringAsFixed(2);
    fridayAcceptTimeEnd.text = widget.voucher!.friday!.acceptTimeEnd!.toStringAsFixed(2);
    saturdayAcceptTimeEnd.text = widget.voucher!.saturday!.acceptTimeEnd!.toStringAsFixed(2);
    sundayAcceptTimeEnd.text = widget.voucher!.sunday!.acceptTimeEnd!.toStringAsFixed(2);
    acceptMonday.value = widget.voucher!.monday!.accept!;
    acceptTuesday.value = widget.voucher!.tuesday!.accept!;
    acceptWednesday.value = widget.voucher!.wednesday!.accept!;
    acceptThursday.value = widget.voucher!.thursday!.accept!;
    acceptFriday.value = widget.voucher!.friday!.accept;
    acceptSaturday.value = widget.voucher!.saturday!.accept;
    acceptSunday.value = widget.voucher!.sunday!.accept;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        margin: EdgeInsets.only(bottom: padding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(padding / 50),
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
                  // CachedImage(
                  //   url: voucher!.voucherImage! == '' ? 'assets/images/logo.png' : voucher!.voucherImage!,
                  //   height: 100,
                  // ),
                  SizedBox(width: 20),
                  Expanded(

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         SizedBox(height: 30),
                        Row(
                          children: [
                            Icon(Icons.local_offer, color: greenColor, size: 40),
                            SizedBox(width:10),
                            Text('One simple voucher offer!', textScaleFactor: 1.2, maxLines:1, overflow: TextOverflow.clip, style: TextStyle(color: greenColor, fontWeight: FontWeight.bold)),

                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.arrowRight, color: greenColor),
                            SizedBox(width:10),
                            Text('Customer saves £10',  textScaleFactor: 0.9, maxLines: 1, overflow: TextOverflow.clip, style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.arrowRight, color: greenColor),
                            SizedBox(width:10),
                            Text('Minimum spend £20',  textScaleFactor: 0.9, maxLines: 1, overflow: TextOverflow.clip, style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.arrowRight, color: greenColor),
                            SizedBox(width:10),
                            Text('1 voucher per customer',  textScaleFactor: 0.9, maxLines: 1, overflow: TextOverflow.clip, style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.arrowRight, color: greenColor),
                            SizedBox(width:10),
                            Text('Valid during off-peak times',  textScaleFactor: 0.9, maxLines: 1, overflow: TextOverflow.clip, style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.arrowRight, color: greenColor),
                            SizedBox(width:10),
                            Text('Control quantity of vouchers per person',  textScaleFactor: 0.9, maxLines: 1, overflow: TextOverflow.clip, style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height:10),
                        buildWorkedExample(),

                        SizedBox(height: 10),
                        Obx(() {
                          return CustomButton(
                            color: orangeColor,
                             text: (pausedClaimable!.value ? 'Set Voucher Offer Live' : 'De-active Voucher Offer'),
                            function: () {
                              Get.defaultDialog(
                                radius: padding / 2,
                                title: (pausedClaimable!.value ? 'Set Voucher Offer Live' : 'De-active Voucher Offer'),
                                content: Text('Are you sure you want to ' + (pausedClaimable.value ? 'Set this voucher offer live' : 'De-active this voucher offer. All current claimed vouchers will remain active for 48 hours.'), textAlign: TextAlign.center),
                                cancel: CustomButton(
                                  function: () async {
                                    Get.back();
                                    pausedClaimable = widget.voucher!.claimable!.obs;
                                    pausedClaimable.toggle();
                                    await cloudFunction(functionName: 'updateVoucherV1', parameters: {'claimable': widget.voucher!.claimable}, action: () {});
                                  },
                                  text: 'Yes',
                                  color: primaryColor,
                                ),
                                confirm: CustomButton(function: () => Get.back(), text: 'Cancel', color: Colors.grey),
                              );
                            },
                          );
                        }),
                        SizedBox(height:20),
                        Divider(height: 1, color: Colors.grey),
                        SizedBox(height:10),
                            Column(
                            children: [
                        SizedBox(height: 10),
                        Text('Days and times you accept vouchers:'),
                        if (widget.voucher!.monday!.accept==true)
                        Divider(),
                        day('Monday', '${widget.voucher!.monday!.acceptTimeStart.toStringAsFixed(2)} - ${widget.voucher!.monday!.acceptTimeEnd.toStringAsFixed(2)}', widget.voucher!.monday!.accept),

                        Divider(),
                        day('Tuesday', '${widget.voucher!.tuesday!.acceptTimeStart.toStringAsFixed(2)} - ${widget.voucher!.tuesday!.acceptTimeEnd.toStringAsFixed(2)}', widget.voucher!.tuesday!.accept),

                        Divider(),
                        day('Wednesday', '${widget.voucher!.wednesday!.acceptTimeStart.toStringAsFixed(2)} - ${widget.voucher!.wednesday!.acceptTimeEnd.toStringAsFixed(2)}', widget.voucher!.wednesday!.accept),

                        Divider(),
                        day('Thursday', '${widget.voucher!.thursday!.acceptTimeStart.toStringAsFixed(2)} - ${widget.voucher!.thursday!.acceptTimeEnd.toStringAsFixed(2)}', widget.voucher!.thursday!.accept),

                        Divider(),
                        day('Friday', '${widget.voucher!.friday!.acceptTimeStart.toStringAsFixed(2)} - ${widget.voucher!.friday!.acceptTimeEnd.toStringAsFixed(2)}', widget.voucher!.friday!.accept),

                        Divider(),
                        day('Saturday', '${widget.voucher!.saturday!.acceptTimeStart.toStringAsFixed(2)} - ${widget.voucher!.saturday!.acceptTimeEnd.toStringAsFixed(2)}', widget.voucher!.saturday!.accept),

                        Divider(),
                        day('Sunday', '${widget.voucher!.sunday!.acceptTimeStart.toStringAsFixed(2)} - ${widget.voucher!.sunday!.acceptTimeEnd.toStringAsFixed(2)}', widget.voucher!.sunday!.accept),
                            ],
                          ),

                      Obx(() {
                        return
                        Column(children: [
                          Text('Days and times you accept vouchers:'), SizedBox(
                              height: 20),

                          Text(
                              'Enter the days and times you want to accept vouchers',
                              style: TextStyle(color: Colors.grey)),
                          SizedBox(height: 20),
                          Row(children: [
                            Expanded(flex: 22, child: Text('')),
                            Expanded(flex: 15,
                                child: Text('From', textScaleFactor: 0.9,
                                    textAlign: TextAlign.center)),
                            Expanded(flex: 15,
                                child: Text('To', textScaleFactor: 0.9,
                                    textAlign: TextAlign.center)),
                          ]),
                          SizedBox(height: 15),


                          Row(children: [
                            Expanded(
                              flex: 25,
                              child: CheckboxListTile(
                                visualDensity: VisualDensity.compact,
                                controlAffinity: ListTileControlAffinity
                                    .leading,
                                contentPadding: EdgeInsets.zero,
                                title: Text('Monday',
                                    style: TextStyle(color: greenColor)),
                                value: acceptMonday.value,
                                onChanged: (val) {
                                  acceptMonday.value = val!;
                                  if (!val) {
                                    mondayAcceptTimeStart.text = '-1';
                                    mondayAcceptTimeEnd.text = '-1';
                                  } else {
                                    mondayAcceptTimeStart.text = '17.00';
                                    mondayAcceptTimeEnd.text = '23.00';
                                  }
                                },
                              ),
                            ),

                            if (!acceptMonday.value) Expanded(
                                flex: 40, child: notAcceptText()),
                          ]),

                          Row(children: [
                            Expanded(
                              flex: 25,
                              child: CheckboxListTile(
                                visualDensity: VisualDensity.compact,
                                controlAffinity: ListTileControlAffinity
                                    .leading,
                                contentPadding: EdgeInsets.zero,
                                title: Text('Tuesday',
                                    style: TextStyle(color: greenColor)),
                                value: acceptTuesday.value,
                                onChanged: (val) {
                                  acceptTuesday.value = val!;
                                  if (!val) {
                                    tuesdayAcceptTimeStart.text = '-1';
                                    tuesdayAcceptTimeEnd.text = '-1';
                                  } else {
                                    tuesdayAcceptTimeStart.text = '17.00';
                                    tuesdayAcceptTimeEnd.text = '23.00';
                                  }
                                },
                              ),
                            ),

                            if (!acceptTuesday.value) Expanded(
                                flex: 40, child: notAcceptText()),
                          ]),

                          Row(children: [
                            Expanded(
                              flex: 25,
                              child: CheckboxListTile(
                                visualDensity: VisualDensity.compact,
                                controlAffinity: ListTileControlAffinity
                                    .leading,
                                contentPadding: EdgeInsets.zero,
                                title: Text('Wednesday',
                                    style: TextStyle(color: greenColor)),
                                value: acceptWednesday.value,
                                onChanged: (val) {
                                  acceptWednesday.value = val!;
                                  if (!val) {
                                    wednesdayAcceptTimeStart.text = '-1';
                                    wednesdayAcceptTimeEnd.text = '-1';
                                  } else {
                                    wednesdayAcceptTimeStart.text = '17.00';
                                    wednesdayAcceptTimeEnd.text = '23.00';
                                  }
                                },
                              ),
                            ),

                            if (!acceptWednesday.value) Expanded(
                                flex: 40, child: notAcceptText()),
                          ]),


                          Row(children: [
                            Expanded(
                              flex: 25,
                              child: CheckboxListTile(
                                visualDensity: VisualDensity.compact,
                                controlAffinity: ListTileControlAffinity
                                    .leading,
                                contentPadding: EdgeInsets.zero,
                                title: Text('Thursday',
                                    style: TextStyle(color: greenColor)),
                                value: acceptThursday.value,
                                onChanged: (val) {
                                  acceptThursday.value = val!;
                                  if (!val) {
                                    thursdayAcceptTimeStart.text = '-1';
                                    thursdayAcceptTimeEnd.text = '-1';
                                  } else {
                                    thursdayAcceptTimeStart.text = '17.00';
                                    thursdayAcceptTimeEnd.text = '23.00';
                                  }
                                },
                              ),
                            ),

                            if (!acceptThursday.value) Expanded(
                                flex: 40, child: notAcceptText()),
                          ]),

                          Row(children: [
                            Expanded(
                              flex: 25,
                              child: CheckboxListTile(
                                visualDensity: VisualDensity.compact,
                                controlAffinity: ListTileControlAffinity
                                    .leading,
                                contentPadding: EdgeInsets.zero,
                                title: Text('Friday',
                                    style: TextStyle(color: greenColor)),
                                value: acceptFriday.value,
                                onChanged: (val) {
                                  acceptFriday.value = val!;
                                  if (!val) {
                                    fridayAcceptTimeStart.text = '-1';
                                    fridayAcceptTimeEnd.text = '-1';
                                  } else {
                                    fridayAcceptTimeStart.text = '17.00';
                                    fridayAcceptTimeEnd.text = '23.00';
                                  }
                                },
                              ),
                            ),

                            if (!acceptFriday.value) Expanded(
                                flex: 40, child: notAcceptText()),
                          ]),

                          Row(children: [
                            Expanded(
                              flex: 25,
                              child: CheckboxListTile(
                                visualDensity: VisualDensity.compact,
                                controlAffinity: ListTileControlAffinity
                                    .leading,
                                contentPadding: EdgeInsets.zero,
                                title: Text('Saturday',
                                    style: TextStyle(color: greenColor)),
                                value: acceptSaturday.value,
                                onChanged: (val) {
                                  acceptSaturday.value = val!;
                                  if (!val) {
                                    saturdayAcceptTimeStart.text = '-1';
                                    saturdayAcceptTimeEnd.text = '-1';
                                  } else {
                                    saturdayAcceptTimeStart.text = '17.00';
                                    saturdayAcceptTimeEnd.text = '23.00';
                                  }
                                },
                              ),
                            ),

                            if (!acceptSaturday.value) Expanded(
                                flex: 40, child: notAcceptText()),
                          ]),

                          Row(children: [
                            Expanded(
                              flex: 25,
                              child: CheckboxListTile(
                                visualDensity: VisualDensity.compact,
                                controlAffinity: ListTileControlAffinity
                                    .leading,
                                contentPadding: EdgeInsets.zero,
                                title: Text('Sunday',
                                    style: TextStyle(color: greenColor)),
                                value: acceptSunday.value,
                                onChanged: (val) {
                                  acceptSunday.value = val!;
                                  if (!val) {
                                    sundayAcceptTimeStart.text = '-1';
                                    sundayAcceptTimeEnd.text = '-1';
                                  } else {
                                    sundayAcceptTimeStart.text = '17.00';
                                    sundayAcceptTimeEnd.text = '23.00';
                                  }
                                },
                              ),
                            ),

                            if (!acceptSunday.value) Expanded(
                                flex: 40, child: notAcceptText()),
                          ]),
                          SizedBox(height: 5),
                          CustomButton(
                            color: orangeColor,
                            text: 'Update days and times',
                            function: () {
                              Get.defaultDialog(
                                radius: padding / 2,
                                title: 'Update days and times',
                                content: editDaysAndTimes(),
                                cancel: CustomButton(
                                  function: () async {
                                    Get.back();
                                    await cloudFunction(
                                        functionName: 'updateVoucherV1',
                                        parameters:

                                        {
                                          'monday': {'open': parseToDouble(mondayAcceptTimeStart.text), 'close': parseToDouble(mondayAcceptTimeEnd.text), 'accept': acceptMonday.value},
                                          'tuesday': {'open': parseToDouble(tuesdayAcceptTimeStart.text), 'close': parseToDouble(tuesdayAcceptTimeEnd.text), 'accept': acceptTuesday.value},
                                          'wednesday': {'open': parseToDouble(wednesdayAcceptTimeStart.text), 'close': parseToDouble(wednesdayAcceptTimeEnd.text), 'accept': acceptWednesday.value},
                                          'thursday': {'open': parseToDouble(thursdayAcceptTimeStart.text), 'close': parseToDouble(thursdayAcceptTimeEnd.text), 'accept': acceptThursday.value},
                                          'friday': {'open': parseToDouble(fridayAcceptTimeStart.text), 'close': parseToDouble(fridayAcceptTimeEnd.text), 'accept': acceptFriday.value},
                                          'saturday': {'open': parseToDouble(saturdayAcceptTimeStart.text), 'close': parseToDouble(saturdayAcceptTimeEnd.text), 'accept': acceptSaturday.value},
                                          'sunday': {'open': parseToDouble(sundayAcceptTimeStart.text), 'close': parseToDouble(sundayAcceptTimeEnd.text), 'accept': acceptSunday.value},


                                        },
                                        action: () {});
                                  },
                                  text: 'Yes',
                                  color: primaryColor,
                                ),
                                confirm: CustomButton(
                                    function: () => Get.back(),
                                    text: 'Cancel',
                                    color: Colors.grey),
                              );
                            },
                          ),
                          SizedBox(height:20),
                          Divider(height: 1, color: Colors.grey),
                          SizedBox(height:10),
                          CustomTextField(validate: true,
                              hint: 'No. times',
                              label: 'Update number of times each user can claim a voucher? *',
                              controller: maxClaimsPerUserTEC,
                              textInputType: TextInputType.numberWithOptions(
                                  signed: false, decimal: false)),
                          SizedBox(height: 10),
                          CustomButton(
                              color: orangeColor,
                              text: 'Update quantity',
                              function: () async {
                                utilService.showLoading();
                                String voucherID = widget!.voucher!.voucherID!;
                                Map venue = {
                                  //Basic
                                  'voucherID': voucherID,
                                  //Social Media Links
                                  'noEmployees': int.parse(
                                      maxClaimsPerUserTEC.text),
                                };
                                await cloudFunction(functionName: 'updateVenue',
                                    parameters: venue,
                                    action: () =>
                                        Get.offAll(() => VenueDetails()));
                              }
                          ),
                          buildID(),
                        ]
                        );
                      })
],
                  ),
                  ),
                      ],
                    ),
                  ),
                ],
              ),

      );
  }



  day(String day, String time, bool accept) {
    if (time.contains("-1")) accept = false;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(day, textScaleFactor: 0.9, style: TextStyle(color: Color.fromRGBO(8, 76, 97, 0.8), fontWeight: FontWeight.normal, ))),
          Expanded(child: Center(child: Text(time.contains("-1") ? 'Closed' : time, textScaleFactor: 0.8, style: TextStyle(color: Color.fromRGBO(8, 76, 97, 0.8), fontWeight: FontWeight.normal, )))),

        ],
      ),
    );
  }

  editDaysAndTimes() {
    Container(child: Text('test'));

  }

  notAcceptText() {
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
      controller: TextEditingController(text: 'Not accepted'),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade300,
        hintStyle: TextStyle(color: Colors.grey.shade400),
      ),
    ),
  );
}

  buildWorkedExample() {
    return InkWell(
      onTap: () {
        Get.defaultDialog(
          radius: padding / 2,
          title: 'Worked Example',
          content: Column(

            children: [
              Row(
                children: [
                  SizedBox(width:25),
                  Text('Customers spend on average £40 with a voucher',  textScaleFactor: 0.8, maxLines: 3, overflow: TextOverflow.clip, style: TextStyle(color: primaryColor, fontStyle: FontStyle.italic)),
                ],
              ),
              SizedBox(height:7),
              Row(
                children: [
                  SizedBox(width:25),
                  Text('Let\'s say £20 or 50% is cost of goods',  textScaleFactor: 0.8, maxLines: 3, overflow: TextOverflow.clip, style: TextStyle(color: primaryColor, fontStyle: FontStyle.italic)),
                ],
              ),
              SizedBox(height:7),
              Row(
                children: [
                  SizedBox(width:25),
                  Text('£10 covers the discount',  textScaleFactor: 0.8, maxLines: 3, overflow: TextOverflow.clip, style: TextStyle(color: primaryColor, fontStyle: FontStyle.italic)),
                ],
              ),
              SizedBox(height:7),
              Row(
                children: [
                  SizedBox(width:25),
                  Text('£10 profit contributes to running costs',  textScaleFactor: 0.8, maxLines: 3, overflow: TextOverflow.clip, style: TextStyle(color: redColor, fontStyle: FontStyle.italic)),
                ],
              ),
              SizedBox(height:7),
              Row(
                children: [
                  SizedBox(width:25),
                  Text('Additional revenue when it\'s quiet',  textScaleFactor: 0.8, maxLines: 3, overflow: TextOverflow.clip, style: TextStyle(color: primaryColor, fontStyle: FontStyle.italic)),
                ],
              ),
              SizedBox(height:7),
              Row(
                children: [
                  SizedBox(width:25),
                  Text('That\'s £40 not spent with competitor',  textScaleFactor: 0.8, maxLines: 3, overflow: TextOverflow.clip, style: TextStyle(color: primaryColor, fontStyle: FontStyle.italic)),
                ],
              ),
              SizedBox(height:7),
              Row(
                children: [
                  SizedBox(width:25),
                  Text('That\'s a customer promoting your venue',  textScaleFactor: 0.8, maxLines: 3, overflow: TextOverflow.clip, style: TextStyle(color: primaryColor, fontStyle: FontStyle.italic)),
                ],
              ),
              SizedBox(height:7),
              Row(
                children: [
                  SizedBox(width:25),
                  Text('Busy venues attract more customers',  textScaleFactor: 0.8, maxLines: 3, overflow: TextOverflow.clip, style: TextStyle(color: primaryColor, fontStyle: FontStyle.italic)),
                ],
              ), ],
          ),
          cancel: CustomButton(function: () => Get.back(), text: 'OK', color: primaryColor),
        );
      },
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(padding / 2)),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Icon(FontAwesomeIcons.info, color: greenColor, size: 15),
                SizedBox(width:10),
                Text('See worked example',  textScaleFactor: 0.8, maxLines: 1, overflow: TextOverflow.clip, style: TextStyle(color: primaryColor, fontStyle: FontStyle.italic)),

              ],
            ),
    ),
    ],
              ),
    );

  }

  buildID() {
    return InkWell(
      onTap: () {
        Get.defaultDialog(
          radius: padding / 2,
          title: 'Copy & Paste',
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width:25),
                  SelectableText(widget!.voucher!.voucherID!,  textScaleFactor: 0.8, maxLines: 3, style: TextStyle(color: primaryColor, fontStyle: FontStyle.italic),),
                ],
              ),

            ]
          ),
          cancel: CustomButton(function: () => Get.back(), text: 'OK', color: primaryColor),
        );

      },
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(padding / 2)),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Icon(FontAwesomeIcons.question, color: greenColor, size: 15),
                SizedBox(width:10),
                Text('Quote voucher reference for support',  textScaleFactor: 0.8, maxLines: 1, overflow: TextOverflow.clip, style: TextStyle(color: primaryColor, fontStyle: FontStyle.italic)),

              ],
            ),
          ),
        ],
      ),
    );

  }
  parseToDouble(String text) {
    if (text != null && text != '')
      return double.parse(text);
    else
      return -1; //-1 means closed
  }

}
