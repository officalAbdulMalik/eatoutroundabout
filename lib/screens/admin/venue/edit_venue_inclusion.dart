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

class EditVenueInclusion extends StatefulWidget {
  final Venue? venue;

  EditVenueInclusion({this.venue});

  @override
  _EditVenueInclusionState createState() => _EditVenueInclusionState();
}

class _EditVenueInclusionState extends State<EditVenueInclusion> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxInt index = 1.obs;
  final TextEditingController employeesCountTEC = TextEditingController(), disabledEmployeeCountTEC = TextEditingController();

  final utilService = Get.find<UtilService>();
  final storageService = Get.find<StorageService>();
  final userController = Get.find<UserController>();

  Rx<bool> dogFriendly = true.obs, inclusiveToilet = true.obs, disabledToilet = false.obs, lgbtq = false.obs, takeaway = false.obs, wheelChairAccess = false.obs, preTheatreDining = false.obs;
  Rx<bool> vegetarian = false.obs, vegan = false.obs, halal = false.obs, kosher = false.obs, paleo = false.obs, ketogenic = false.obs, checkMarketing = true.obs;
  Rx<bool> glutenIntolerance = false.obs, coeliacIntolerance = false.obs, lactoseIntolerance = false.obs, treeNutIntolerance = false.obs, peanutIntolerance = false.obs, fishIntolerance = false.obs, shellFishIntolerance = false.obs, yeastIntolerance = false.obs, glutenAllergy = false.obs, coeliacAllergy = false.obs, lactoseAllergy = false.obs, treeNutAllergy = false.obs, peanutAllergy = false.obs, fishAllergy = false.obs, shellFishAllergy = false.obs, yeastAllergy = false.obs;

  RxList<String> selectedFoodTypes = ['Other'].obs;
  List foodTypes = [
    'Abyssinian',
    'African',
    'Afternoon Tea',
    'American',
    'Bistro',
    'Brazilian',
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
    'Polish'
    'Portuguese',
    'Spanish',
    'Sushi',
    'Tapas',
    'Thai',
    'Traditional British',
    'Turkish',
    'Other'
];


  List<String> preferences = [], intolerances = [], allergies = [];

  FocusScopeNode node = FocusScopeNode();

  @override
  void initState() {
    employeesCountTEC.text = widget.venue!.noEmployees.toString();
    disabledEmployeeCountTEC.text = widget.venue!.noDisabledEmployees.toString()!;
    preTheatreDining.value = widget.venue!.preTheatreDining!;
    takeaway.value = widget.venue!.takeaway!;
    dogFriendly.value = widget.venue!.dogFriendly!;
    wheelChairAccess.value = widget.venue!.wheelChairAccess!;
    disabledToilet.value = widget.venue!.disabledToilet!;
    lgbtq.value = widget.venue!.lgbtq!;
    inclusiveToilet.value = widget.venue!.inclusiveToilets!;

    selectedFoodTypes.value = widget.venue!.foodTypes!.cast<String>();

    glutenIntolerance.value = widget.venue!.intolerances!.contains("Gluten Free");
    coeliacIntolerance.value = widget.venue!.intolerances!.contains("Coeliac");
    lactoseIntolerance.value = widget.venue!.intolerances!.contains("Lactose");
    treeNutIntolerance.value = widget.venue!.intolerances!.contains("Tree Nut");
    peanutIntolerance.value = widget.venue!.intolerances!.contains("Peanut");
    fishIntolerance.value = widget.venue!.intolerances!.contains("Fish");
    shellFishIntolerance.value = widget.venue!.intolerances!.contains("Shell Fish");
    yeastIntolerance.value = widget.venue!.intolerances!.contains("Yeast");
    glutenAllergy.value = widget.venue!.allergies!.contains("Gluten Free");
    coeliacAllergy.value = widget.venue!.allergies!.contains("Coeliac");
    lactoseAllergy.value = widget.venue!.allergies!.contains("Lactose");
    treeNutAllergy.value = widget.venue!.allergies!.contains("Tree Nut");
    peanutAllergy.value = widget.venue!.allergies!.contains("Peanut");
    fishAllergy.value = widget.venue!.allergies!.contains("Fish");
    shellFishAllergy.value = widget.venue!.allergies!.contains("Shell Fish");
    yeastAllergy.value = widget.venue!.allergies!.contains("Yeast");
    vegetarian.value = userController.currentUser.value.vegetarian!;
    vegan.value = userController.currentUser.value.vegan!;
    halal.value = userController.currentUser.value.halal!;
    paleo.value = userController.currentUser.value.paleo!;
    ketogenic.value = userController.currentUser.value.ketogenic!;
    setIntoleranceValue(1, widget.venue!.intolerances!.contains("Gluten Free"));
    setIntoleranceValue(2, widget.venue!.intolerances!.contains("Coeliac"));
    setIntoleranceValue(3, widget.venue!.intolerances!.contains("Lactose"));
    setIntoleranceValue(4, widget.venue!.intolerances!.contains("Tree Nut"));
    setIntoleranceValue(5, widget.venue!.intolerances!.contains("Peanut"));
    setIntoleranceValue(6, widget.venue!.intolerances!.contains("Fish"));
    setIntoleranceValue(7, widget.venue!.intolerances!.contains("Shell Fish"));
    setIntoleranceValue(8, widget.venue!.intolerances!.contains("Yeast"));
    setAllergyValue(1, widget.venue!.allergies!.contains("Gluten Free"));
    setAllergyValue(2, widget.venue!.allergies!.contains("Coeliac"));
    setAllergyValue(3, widget.venue!.allergies!.contains("Lactose"));
    setAllergyValue(4, widget.venue!.allergies!.contains("Tree Nut"));
    setAllergyValue(5, widget.venue!.allergies!.contains("Peanut"));
    setAllergyValue(6, widget.venue!.allergies!.contains("Fish"));
    setAllergyValue(7, widget.venue!.allergies!.contains("Shell Fish"));
    setAllergyValue(8, widget.venue!.allergies!.contains("Yeast"));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/applogo.png', height: AppBar().preferredSize.height - 15),
        backgroundColor: primaryColor,
        actions: [
          Center(child: InkWell(onTap: () => utilService.goBackDialog(), child: Text('Cancel'))),
          SizedBox(width: 15),
        ],
      ),
      body:WillPopScope(
        onWillPop: () => index.value == 1 ? utilService.goBackDialog() : index--,

        child: Column(
            children: [
              Heading(title: 'RECOMMENDATIONS'),
               Expanded(
                child: Container(
                  width: double.infinity,
                  color: appBackground,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(padding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        inclusionDetails(),
                        Divider(height: 50, color: Colors.white54),
                        CustomButton(
                          color: orangeColor,
                          text: 'Update recommendations',
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
                            'noEmployees': int.parse(employeesCountTEC.text),
                            'dogFriendly': dogFriendly.value,
                            'preTheatreDining': preTheatreDining.value,
                            'takeaway': takeaway.value,
                            'wheelChairAccess': wheelChairAccess.value,

                            //Location

                          //Food Types
          'foodTypes': selectedFoodTypes,
          //Preferences
          'vegetarian': vegetarian.value,
          'vegan': vegan.value,
          'halal': halal.value,
          'paleo': paleo.value,
          'ketogenic': ketogenic.value,
          'intolerances': intolerances,
          'allergies': allergies,

          };
          await cloudFunction(functionName: 'updateVenue', parameters: venue, action: () => Get.offAll(() => HomePage()));
          }
        ),

                      ],
                    ),
                  ),
                ),
              ),
          ]
        ),
      ),
    );
  }



  inclusionDetails() {
    return Column(children: [
      Text('Let\'s match customers to your venue', textScaleFactor: 1.5, style: TextStyle(fontWeight: FontWeight.bold)),
SizedBox(height: 10),
    Column(children: [
    Text('Dietary Preferences', textScaleFactor: 1.5, style: TextStyle(fontWeight: FontWeight.bold)),
    SizedBox(height: 20),
    Text('Select dietary preferences that your venue offers', style: TextStyle(color: Colors.grey)),
    SizedBox(height: 20),
    setting(0, 'Vegetarian'),
    setting(1, 'Vegan'),
    setting(2, 'Halal'),
    setting(3, 'Paleo'),
    setting(4, 'Ketogenic'),
    Divider(height: 25),
    Row(
    children: [
    Expanded(child: Text('Intolerance')),
    Expanded(child: Text('Allergy')),
    Expanded(child: Text('')),
    ],
    ),
    intoleranceAllergies('Gluten Free', 1),
    intoleranceAllergies('Coeliac', 2),
    intoleranceAllergies('Lactose', 3),
    intoleranceAllergies('Tree Nut', 4),
    intoleranceAllergies('Peanut', 5),
    intoleranceAllergies('Fish', 6),
    intoleranceAllergies('Shell Fish', 7),
    intoleranceAllergies('Yeast', 8),
    ]),
      SizedBox(height: 20),
      Text('Approach to inclusion', textScaleFactor: 1.5, style: TextStyle(fontWeight: FontWeight.bold)),
      CheckboxListTile(
        value: wheelChairAccess.value,
        onChanged: (val) => wheelChairAccess.value = val!,
        title: Text('Wheelchair access available'),
      ),
      CheckboxListTile(
        value: disabledToilet.value,
        onChanged: (val) => disabledToilet.value = val!,
        title: Text('Disabled toilet'),
      ),
      CheckboxListTile(
        value: lgbtq.value,
        onChanged: (val) => lgbtq.value = val!,
        title: Text('LGBTQ community friendly'),
      ),
      CheckboxListTile(
        value: inclusiveToilet.value,
        onChanged: (val) => inclusiveToilet.value = val!,
        title: Text('Gender inclusive toilet'),
      ),
      CheckboxListTile(
        value: dogFriendly.value,
        onChanged: (val) => dogFriendly.value = val!,
        title: Text('We are dog friendly'),
      ),
      CheckboxListTile(
        value: preTheatreDining.value,
        onChanged: (val) => preTheatreDining.value = val!,
        title: Text('Pre-theatre dining available'),
      ),
      CheckboxListTile(
        value: takeaway.value,
        onChanged: (val) => takeaway.value = val!,
        title: Text('Takeaways available'),
      ),

      Text('Food types', textScaleFactor: 1.5, style: TextStyle(fontWeight: FontWeight.bold)),

      GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3),
        itemCount: foodTypes.length,
        itemBuilder: (context, i) {
          return Obx(() {
            return CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              value: selectedFoodTypes.contains(foodTypes[i]),
              onChanged: (val) {
                if (selectedFoodTypes.contains(foodTypes[i]))
                  selectedFoodTypes.remove(foodTypes[i]);
                else
                  selectedFoodTypes.add(foodTypes[i]);
              },
              title: Text(foodTypes[i], textScaleFactor: 1),
            );
          });
        },
      ),
    ]);

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

  intoleranceAllergies(String title, int index) {
    return Row(
      children: [
        Expanded(
            child: Row(
          children: [
            Checkbox(onChanged: (value) => setIntoleranceValue(index, value!), value: getIntoleranceValue(index)),
          ],
        )),
        Expanded(
            child: Row(
          children: [
            Checkbox(onChanged: (value) => setAllergyValue(index, value!), value: getAllergyValue(index)),
          ],
        )),
        Expanded(child: Text(title)),
      ],
    );
  }

  getIntoleranceValue(int index) {
    switch (index) {
      case 1:
        return glutenIntolerance.value;
      case 2:
        return coeliacIntolerance.value;
      case 3:
        return lactoseIntolerance.value;
      case 4:
        return treeNutIntolerance.value;
      case 5:
        return peanutIntolerance.value;
      case 6:
        return fishIntolerance.value;
      case 7:
        return shellFishIntolerance.value;
      case 8:
        return yeastIntolerance.value;
    }
  }

  setIntoleranceValue(int index, bool value) {
    switch (index) {
      case 1:
        if (value)
          intolerances.add('Gluten Free');
        else
          intolerances.remove('Gluten Free');
        return glutenIntolerance.value = value;
      case 2:
        if (value)
          intolerances.add('Coeliac');
        else
          intolerances.remove('Coeliac');
        return coeliacIntolerance.value = value;
      case 3:
        if (value)
          intolerances.add('Lactose');
        else
          intolerances.remove('Lactose');
        return lactoseIntolerance.value = value;
      case 4:
        if (value)
          intolerances.add('Tree Nut');
        else
          intolerances.remove('Tree Nut');
        return treeNutIntolerance.value = value;
      case 5:
        if (value)
          intolerances.add('Peanut');
        else
          intolerances.remove('Peanut');
        return peanutIntolerance.value = value;
      case 6:
        if (value)
          intolerances.add('Fish');
        else
          intolerances.remove('Fish');
        return fishIntolerance.value = value;
      case 7:
        if (value)
          intolerances.add('Shell Fish');
        else
          intolerances.remove('Shell Fish');
        return shellFishIntolerance.value = value;
      case 8:
        if (value)
          intolerances.add('Yeast');
        else
          intolerances.remove('Yeast');
        return yeastIntolerance.value = value;
    }
  }

  getAllergyValue(int index) {
    switch (index) {
      case 1:
        return glutenAllergy.value;
      case 2:
        return coeliacAllergy.value;
      case 3:
        return lactoseAllergy.value;
      case 4:
        return treeNutAllergy.value;
      case 5:
        return peanutAllergy.value;
      case 6:
        return fishAllergy.value;
      case 7:
        return shellFishAllergy.value;
      case 8:
        return yeastAllergy.value;
    }
  }

  setAllergyValue(int index, bool value) {
    switch (index) {
      case 1:
        if (value)
          allergies.add('Gluten Free');
        else
          allergies.remove('Gluten Free');
        return glutenAllergy.value = value;
      case 2:
        if (value)
          allergies.add('Coeliac');
        else
          allergies.remove('Coeliac');
        return coeliacAllergy.value = value;
      case 3:
        if (value)
          allergies.add('Lactose');
        else
          allergies.remove('Lactose');
        return lactoseAllergy.value = value;
      case 4:
        if (value)
          allergies.add('Tree Nut');
        else
          allergies.remove('Tree Nut');
        return treeNutAllergy.value = value;
      case 5:
        if (value)
          allergies.add('Peanut');
        else
          allergies.remove('Peanut');
        return peanutAllergy.value = value;
      case 6:
        if (value)
          allergies.add('Fish');
        else
          allergies.remove('Fish');
        return fishAllergy.value = value;
      case 7:
        if (value)
          allergies.add('Shell Fish');
        else
          allergies.remove('Shell Fish');
        return shellFishAllergy.value = value;
      case 8:
        if (value)
          allergies.add('Yeast');
        else
          allergies.remove('Yeast');
        return yeastAllergy.value = value;
    }
  }

  setting(int i, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          FlutterSwitch(
            value: getValue(i),
            borderRadius: 30.0,
            padding: 8.0,
            activeColor: primaryColor,
            showOnOff: true,
            onToggle: (value) => setValue(i, value),
          ),
          SizedBox(width: 15),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  getValue(int i) {
    switch (i) {
      case 0:
        return vegetarian.value;
      case 1:
        return vegan.value;
      case 2:
        return halal.value;
      case 3:
        return paleo.value;
      case 4:
        return ketogenic.value;
    }
  }

  setValue(int i, bool value) {
    switch (i) {
      case 0:
        return vegetarian.value = value;
      case 1:
        return vegan.value = value;
      case 2:
        return halal.value = value;
      case 3:
        return paleo.value = value;
      case 4:
        return ketogenic.value = value;
    }
  }
}
