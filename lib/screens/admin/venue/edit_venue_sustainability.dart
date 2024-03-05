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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

class EditVenueSustainability extends StatefulWidget {
  final Venue? venue;

  EditVenueSustainability({this.venue});

  @override
  _EditVenueSustainabilityState createState() => _EditVenueSustainabilityState();
}

class _EditVenueSustainabilityState extends State<EditVenueSustainability> {
  // final loading = true.obs;
   final
      sourceLocally = false.obs,
      cleanEnergy = false.obs,
      singleUsePlastic = true.obs,
      sustainableFish = false.obs,
      sustainableMeat = false.obs,
      plantBasedOptions = false.obs,
      sustainableCleaning = false.obs;
  final
      foodWasteTEC = TextEditingController(),
      averageCarbonPerMealTEC = TextEditingController(),
      venueCarbonFootprintTEC = TextEditingController();

  final utilService = Get.find<UtilService>();
 final userController = Get.find<UserController>();
  final firestoreService = Get.find<FirestoreService>();

  final TextEditingController postcodeTEC = TextEditingController();

 // FocusScopeNode node = FocusScopeNode();

  @override
  void initState() {

    foodWasteTEC.text = widget.venue!.foodWaste.toString();
    averageCarbonPerMealTEC.text = widget.venue!.averageCarbonPerMeal.toString();
    venueCarbonFootprintTEC.text = widget.venue!.venueCarbonFootprint.toString();

    sourceLocally.value = widget.venue!.sourceLocally!;
    cleanEnergy.value = widget.venue!.cleanEnergy!;
    singleUsePlastic.value = widget.venue!.singleUsePlastic!;
    sustainableFish.value = widget.venue!.sustainableFish!;
    sustainableMeat.value = widget.venue!.sustainableMeat!;
    plantBasedOptions.value = widget.venue!.plantBasedOptions!;
    sustainableCleaning.value = widget.venue!.sustainableCleaning!;

    postcodeTEC.text = widget.venue!.postCode!;

    super.initState();
  }
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
      body: Column(
        children: [
          Heading(title: 'SUSTAINABILITY'),
          Expanded(
            child: Container(
              width: double.infinity,
              color: appBackground,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(padding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    sustainability(),
                    Divider(height: 50, color: Colors.white54),
                    CustomButton(
                        color: orangeColor,
                        text: 'Edit Venue',
                        function: () async {
                          utilService.showLoading();
                          String venueID = widget!.venue!.venueID!;
                          Map venue = {
                            //Basic

                            'accountID': userController.currentUser.value
                                .accountID,
                            'accountAdmin': userController.currentUser.value
                                .userID,
                            'venueID': venueID,
                            'postCode': postcodeTEC.text ?? '',
                            // sustainability
                            'sourceLocally': sourceLocally!,
                            'cleanEnergy': cleanEnergy!,
                            'singleUsePlastic': singleUsePlastic!,
                            'sustainableFish': sustainableFish!,
                            'sustainableMeat': sustainableMeat!,
                            'plantBasedOptions': plantBasedOptions!,
                            'sustainableCleaning': sustainableCleaning!,

                            'foodWaste': int.parse(foodWasteTEC.text),
                            'averageCarbonPerMeal': int.parse(
                                averageCarbonPerMealTEC.text),
                            'venueCarbonFootprint': int.parse(
                                venueCarbonFootprintTEC.text),

                          };
                          await cloudFunction(functionName: 'updateVenue', parameters: venue, action: () => Get.offAll(() => HomePage()));
                        }
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

sustainability(){
    return
      Obx(() {
      return
      Column(children: [

        Text('Promote your sustainability ethics. Do you...?',
            textScaleFactor: 1.5,
            style: TextStyle(fontWeight: FontWeight.bold)),

        SizedBox(height: 20),
        Text('Select the options that apply', style: TextStyle(color: Colors.grey)),
        SizedBox(height: 20),
        CheckboxListTile(
            title: Text('Source with local suppliers?'),
            value: sourceLocally.value,
            onChanged: (bool? value) {
              sourceLocally.value = value!;
            }
        ),
        CheckboxListTile(
          value: cleanEnergy.value,
          onChanged: (bool? value) => cleanEnergy.value = value!,
          title: Text('Use clean energy'),
        ),
        CheckboxListTile(
          value: sustainableCleaning.value,
          onChanged: (bool? value) => sustainableCleaning.value = value!,
          title: Text('Use sustainable cleaning products'),
        ),
        CheckboxListTile(
          value: singleUsePlastic.value,
          onChanged: (bool? value) => singleUsePlastic.value = value!,
          title: Text('Not use single use plastic'),
        ),
        CheckboxListTile(
          value: sustainableFish.value,
          onChanged: (bool? value) => sustainableFish.value = value!,
          title: Text('Offer sustainable fish menu options'),
        ),
        CheckboxListTile(
          value: sustainableMeat.value,
          onChanged: (bool? value) => sustainableMeat.value = value!,
          title: Text('Offer locally sourced or organic meat menu options'),
        ),
        CheckboxListTile(
          value: plantBasedOptions.value,
          onChanged: (bool? value) => plantBasedOptions.value = value!,
          title: Text('Offer plant-based menu options'),
        ),
        Divider(height: 25),
        CustomTextField(validate: true,
            hint: '% food waste',
            label: 'What % of your food goes to waste?',
            textInputType: TextInputType.numberWithOptions(
                signed: false, decimal: false),
            controller: foodWasteTEC),
        CustomTextField(validate: true,
            hint: 'Co2 per meal',
            label: 'What is the average kg of carbon per meal at your venue?',
            textInputType: TextInputType.numberWithOptions(
                signed: false, decimal: false),
            controller: averageCarbonPerMealTEC),
        CustomTextField(validate: true,
            hint: 'Carbon footprint',
            label: 'What is overall carbon footprint of your venue in metric tons?',
            textInputType: TextInputType.numberWithOptions(
                signed: false, decimal: false),
            controller: venueCarbonFootprintTEC),
      ]);
     });
  }


}
