import 'package:cached_network_image/cached_network_image.dart';
import 'package:eatoutroundabout/models/popup_model.dart';
import 'package:eatoutroundabout/models/venue_model.dart';
import 'package:eatoutroundabout/screens/admin/venue/popup_details.dart';
import 'package:eatoutroundabout/screens/admin/venue/venue_details.dart';
import 'package:eatoutroundabout/screens/venues/view_popup.dart';
import 'package:eatoutroundabout/screens/venues/view_venue.dart';
import 'package:eatoutroundabout/services/util_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/cached_image.dart';
import 'package:eatoutroundabout/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PopUpItem extends StatelessWidget {
  final PopUp? popup;
  final bool? isMyPopup;

  PopUpItem({this.popup, this.isMyPopup});

  final miscService = Get.find<UtilService>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => isMyPopup!
          ? popup!.approved!
              ? Get.to(() => PopUpDetails(popup: popup!))
              : Get.defaultDialog(
                  radius: padding / 2,
                  title: 'Awaiting Approval',
                  content: buildText(
                    'Your popup is not approved yet. \n\nIf you have not heard from us within 48 hours, please contact support@EatOutRoundAbout.co.uk',
                  ),
                  actions: [
                    CustomButton(
                      function: () => Get.back(),
                      text: 'OK',
                      color: primaryColor,
                    ),
                  ],
                )
          : Get.to(() => ViewPopUp(popupID: popup!.popupID)),
      child: Container(
        height: Get.width * 0.65,
        margin: const EdgeInsets.fromLTRB(padding, 0, padding, padding),
        decoration: BoxDecoration(
          color: lightGreenColor,
          borderRadius: BorderRadius.circular(padding / 2),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 10),
          ],
          image: DecorationImage(
            image: popup!.coverURL == '' ? AssetImage('assets/images/logo.png') as ImageProvider: CachedNetworkImageProvider(popup!.coverURL!),
            fit: popup!.coverURL == '' ? BoxFit.contain : BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: CachedImage(url: popup!.logo, height: 50, roundedCorners: true),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(padding / 2), bottomRight: Radius.circular(padding / 2)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [

                      Expanded(child:Text(popup!.popupName!, textScaleFactor: 0.9, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
                      ),
                      buildEcoIcons(),
                      buildIcons(),
                    ],
                  ),
                  SizedBox(height: 2),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildIcons() {
    return InkWell(
      onTap: () {
        Get.defaultDialog(
          radius: padding / 2,
          title: 'Inclusive Facilities & Services',
          content: Expanded(
            child: Column(
              children: [
                Text('Food Types', style: TextStyle(color: Colors.teal.shade400, fontWeight: FontWeight.normal, fontSize: 14)),
                SizedBox(height: 5),
                if (popup!.foodTypes!.isNotEmpty)
                Text(popup!.foodTypes!.join(", "), style: TextStyle(fontSize:12, fontStyle: FontStyle.italic)),
                SizedBox(height: 10),
                if (popup!.allergies!.isNotEmpty)
                Text('We accommodate the following allergies', style: TextStyle(color: Colors.teal.shade400, fontWeight: FontWeight.normal, fontSize: 14)),
                SizedBox(height: 10),
                Text(popup!.allergies!.join(", "), style: TextStyle(fontSize:12, fontStyle: FontStyle.italic)),
                SizedBox(height: 10),
                if (popup!.intolerances!.isNotEmpty)
                Text('We accommodate the following intolerances', style: TextStyle(color: Colors.teal.shade400, fontWeight: FontWeight.normal, fontSize: 14)),
                SizedBox(height: 10),
                Text(popup!.intolerances!.join(", "), style: TextStyle(fontSize:12, fontStyle: FontStyle.italic)),
                SizedBox(height: 20),
                if (popup!.vegetarian! == true || popup!.vegan! == true || popup!.paleo! == true || popup!.dairyFree! == true || popup!.ketogenic! == true || popup!.halal! == true)
                  Text('We accommodate the following diets', style: TextStyle(color: Colors.teal.shade400, fontWeight: FontWeight.normal, fontSize: 14)),
                SizedBox(height: 10),
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (popup!.vegan! == true)
                       // Icon(FontAwesomeIcons.leaf, color: primaryColor),
                      Text(' Vegan,', style: TextStyle(fontSize:12, fontStyle: FontStyle.italic, )),
                      if (popup!.vegetarian! == true)
                       // Icon(FontAwesomeIcons., color: primaryColor),
                      Text(' Vegetarian,', style: TextStyle(fontSize:12, fontStyle: FontStyle.italic)),
                      if (popup!.dairyFree! == true)
                      // Icon(FontAwesomeIcons., color: primaryColor),
                        Text(' Dairy Free,', style: TextStyle(fontSize:12, fontStyle: FontStyle.italic)),
                      if (popup!.ketogenic! == true)
                      // Icon(FontAwesomeIcons., color: primaryColor),
                        Text(' Ketogenic,', style: TextStyle(fontSize:12, fontStyle: FontStyle.italic)),
                      if (popup!.halal! == true)
                      // Icon(FontAwesomeIcons., color: primaryColor),
                        Text(' Halal,', style: TextStyle(fontSize:12, fontStyle: FontStyle.italic)),
                      if (popup!.paleo! == true)
                      // Icon(FontAwesomeIcons., color: primaryColor),
                        Text(' Paleo,', style: TextStyle(fontSize:12, fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
                if (popup!.dietaryPrefBool! == true)
                  infoItem(Icons.menu_book, (popup!.dietaryPrefBool! ? 'Dietary requirements': 'N/A'), popup!.dietaryPrefBool!),
               if (popup!.lgbtq! == true)
                  infoItem(Icons.diversity_2_outlined, (popup!.lgbtq! ? 'LGBTQ friendly': 'N/A'), popup!.lgbtq!),
                if (popup!.preTheatreDining! == true)
                infoItem(Icons.theater_comedy_outlined, (popup!.preTheatreDining! ? 'Pre-theatre dining available' : ' not available'), popup!.preTheatreDining!),
              ],
            ),
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
              color: primaryColor,
            ),
            child: Row(
              children: [
                Icon(Icons.people_outline, color: Colors.white, size: 16),SizedBox(width: 5),
                Text(popup!.inclusiveRating!.toStringAsFixed(1) + ' ★', textScaleFactor: 0.8, style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildEcoIcons() {
    return InkWell(
      onTap: () {
        Get.defaultDialog(
          radius: padding / 2,
          title: 'Environmental Details',
          content: Expanded(
            child: Column(
              children: [
                if (popup!.popupImpactStatus!.toUpperCase() != 'NONE')
                infoItem(Icons.star, '${popup!.popupImpactStatus!.toUpperCase()}' + ' Sustainability Rating', popup!.popupImpactStatus!.toUpperCase() != 'NONE'),
                if (popup!.foodWaste! <= 10)
                infoItem(FontAwesomeIcons.trashCan, '${popup!.foodWaste!.toString()}' + '% Food waste', popup!.foodWaste!.toString() != 'UNKNOWN'),
                if (popup!.singleUsePlastic! == true)
                infoItem(Icons.recycling, (popup!.singleUsePlastic! ? 'No single use plastic' : 'yes'), popup!.singleUsePlastic!),
                if (popup!.sourceLocally! == true)
                infoItem(Icons.local_drink_outlined,(popup!.sourceLocally! ? 'We source locally' : ': No'), popup!.sourceLocally!),
                if (popup!.cleanEnergy! == true)
                infoItem(Icons.wind_power_outlined, (popup!.cleanEnergy! ? 'We use clean energy' : ': No'), popup!.cleanEnergy!),
                if (popup!.sustainableFish! == true)
                infoItem(Icons.set_meal_outlined, (popup!.sustainableFish! ? 'Sustainable fish available': ': N/A'), popup!.sustainableFish!),
                if (popup!.sustainableMeat! == true)
                infoItem(Icons.kebab_dining_outlined, (popup!.sustainableMeat! ? 'Locally sourced meat available' : ': N/A'), popup!.sustainableMeat!),
                if (popup!.plantBasedOptions! == true)
                infoItem(Icons.eco_outlined, (popup!.plantBasedOptions! ? 'Plant based options available' : ' not available'), popup!.plantBasedOptions!),
                if (popup!.sustainableCleaning! == true)
                infoItem(Icons.cleaning_services_outlined, (popup!.sustainableCleaning! ? 'We use eco friendly products to clean' : ' N/A'), popup!.sustainableCleaning!),
                if (popup!.averageCarbonPerMeal! != 0)
                infoItem(Icons.co2_outlined, 'Average Co2 per meal: ${popup!.averageCarbonPerMeal!.toString()}' + 'kg', popup!.averageCarbonPerMeal!.toString() != 'UNKNOWN'),
                if (popup!.popupCarbonFootprint! != 0)
                infoItem(Icons.co2_outlined, 'Venue annual Co2: ${popup!.popupCarbonFootprint!.toString()}' + ' metric tons', popup!.popupCarbonFootprint!.toString() != 'UNKNOWN'),
              ],
            ),
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
              color: greenColor,
            ),
            child: Row(
              children: [
                Icon(Icons.eco_outlined, color: Colors.white, size:16),SizedBox(width: 5),
                Text(popup!.sustainabilityRating!.toStringAsFixed(1) + ' ★', textScaleFactor: 0.8, style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          // Image.asset(miscService.getPinColor(venue!.venueImpactStatus!), height: 18, width: 18),
          //
          // Icon(Icons.compost_outlined, size: 20, color: venue!.foodWaste! ? greenColor : Colors.grey.shade300),
          // SizedBox(width: 5),
          // Icon(Icons.local_drink_outlined, size: 20, color: venue!.singleUsePlastic! ? greenColor : Colors.grey.shade300),
          // SizedBox(width: 5),
          // Icon(Icons.wind_power_outlined, size: 20, color: venue!.cleanEnergy! ? greenColor : Colors.grey.shade300),
          // SizedBox(width: 5),
          // Icon(Icons.set_meal_outlined, size: 20, color: venue!.sustainableFish! ? greenColor : Colors.grey.shade300),
          // SizedBox(width: 5),
          // Icon(Icons.kebab_dining_outlined, size: 20, color: venue!.sustainableMeat! ? greenColor : Colors.grey.shade300),
          // SizedBox(width: 5),
          // Icon(Icons.eco_outlined, color: greenColor),
          // SizedBox(width: 5),
          // Icon(Icons.cleaning_services_outlined, size: 20, color: venue!.sustainableCleaning! ? greenColor : Colors.grey.shade300),
          // SizedBox(width: 5),
          // Icon(Icons.co2_outlined, color: primaryColor, size: 20),
        ],
      ),
    );
  }


  infoItem(IconData icon, String title, bool val) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: val ? greenColor : Colors.grey.shade400),
          SizedBox(width: 10),
          Text(title, textScaleFactor: 0.95, style: TextStyle(color: val ? greenColor : Colors.grey.shade400)),
        ],
      ),
    );
  }



  buildText(String text) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Linkify(
        text: text,
        onOpen: (link) => miscService.openLink(link.url),
        options: LinkifyOptions(humanize: true),
        linkStyle: TextStyle(color: greenColor),
        style: TextStyle(color: Colors.black),
        textAlign: TextAlign.center,
        textScaleFactor: 1.1,
      ),
    );
  }
}
