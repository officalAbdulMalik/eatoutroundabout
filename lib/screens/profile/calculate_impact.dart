import 'package:dotted_border/dotted_border.dart';
import 'package:eatoutroundabout/controllers/user_controller.dart';
import 'package:eatoutroundabout/models/user_vouchers_model.dart';
import 'package:eatoutroundabout/models/venue_model.dart';
import 'package:eatoutroundabout/screens/vouchers/restricted_venues.dart';
import 'package:eatoutroundabout/screens/vouchers/self_redeem_voucher.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/services/util_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/custom_button.dart';
import 'package:eatoutroundabout/widgets/custom_text_field.dart';
import 'package:eatoutroundabout/widgets/heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:location/location.dart' as loc;
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class CalculateImpact extends StatefulWidget {
  // final bool? isVenueAccount;
  //
  // AddAccount({this.isVenueAccount});

  @override
  State<CalculateImpact> createState() => _CalculateImpactState();
}

class _CalculateImpactState extends State<CalculateImpact> {

  final TextEditingController distanceTEC = TextEditingController();

  final TextEditingController travelCarbonEstimateTEC = TextEditingController();

  final TextEditingController mealTypeTEC = TextEditingController();

  final TextEditingController mealCarbonEstimateTEC = TextEditingController();

  final TextEditingController totalCarbonEstimateTEC = TextEditingController();

  final TextEditingController totalOffsetTEC = TextEditingController();

  final TextEditingController totalCarbonTEC = TextEditingController();

  List travelMode = ['Walk', 'Car', 'Bus', 'Train', 'Taxi', 'Motorcycle', 'Bike', 'Tram', 'Other'];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final userController = Get.find<UserController>();

  final utilService = Get.find<UtilService>();

  final firestoreService = Get.find<FirestoreService>();

  final RxBool showSplash = true.obs;

  RxBool isLoading = true.obs;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Image.asset('assets/images/applogo.png', height: AppBar().preferredSize.height - 15), backgroundColor: primaryColor),
      body: Column(
        children: [
          Heading(title: 'Impact'),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              color: Colors.grey.shade300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  CustomTextField(label: 'How far have travelled to and from the venue today *', hint: 'in miles', controller: distanceTEC, textInputType: TextInputType.text),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('What mode of transport are you using? *', textScaleFactor: 1),

                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Swiper(
                      loop: false,
                      viewportFraction: 0.3,
                      itemBuilder: (context, i) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(right: 15, bottom: 25),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(padding / 2),
                            border: Border.all(color: Colors.teal, width: 2),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Text(travelMode[i], textScaleFactor: 1.35, style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                             // Text(freeItems[i], textScaleFactor: 1.2, style: TextStyle(fontWeight: FontWeight.bold, color: greenColor)),
                              SizedBox(height: 25),
                              Image.asset(
                                'assets/images/transport${i + 1}.png',
                                height: MediaQuery.of(context).size.height * 0.10,
                              ),
                              SizedBox(height: 25),
                             // Text('£' + price[i].toString(), textScaleFactor: 1.5, style: TextStyle(fontWeight: FontWeight.bold, color: orangeColor)),
                              SizedBox(height: 25),
                              CustomButton(
                                text: 'Select',
                               // function: () async {
                                //  ));
                              //  },
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: 9,
                    ),
                  ),   Container(
                      height: 100,
                      padding: const EdgeInsets.all(20),
                      child: CustomButton(
                        color: redColor,
                        textColor: Colors.white,
                        text: 'Estimate Co2',
                        showShadow: true,
                        function:
                            () => Get.to(() => calculateCo2())),
                      ),
                ],
              ),
            ),
      ),
   ] )
    );
  }

  calculateCo2() {

  }

}