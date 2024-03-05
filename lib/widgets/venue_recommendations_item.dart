import 'package:cached_network_image/cached_network_image.dart';
import 'package:eatoutroundabout/models/recommendations_model.dart';
import 'package:eatoutroundabout/models/venue_model.dart';
import 'package:eatoutroundabout/screens/admin/venue/venue_details.dart';
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

class VenueRecommendationsItem extends StatelessWidget {
  final Venue? venue;
  final bool? isMyVenue;

  VenueRecommendationsItem({this.venue, this.isMyVenue});

  final miscService = Get.find<UtilService>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => isMyVenue!
          ? venue!.approved!
          ? Get.to(() => VenueDetails(venue: venue!))
          : Get.defaultDialog(
        radius: padding / 2,
        title: 'Awaiting Approval',
        content: buildText(
          'Your venue is not approved yet. \n\nIf you have not heard from us within 48 hours, please contact support@EatOutRoundAbout.co.uk',
        ),
        actions: [
          CustomButton(
            function: () => Get.back(),
            text: 'OK',
            color: primaryColor,
          ),
        ],
      )
          : Get.to(() => ViewVenue(venueID: venue!.venueID)),
      child: Container(
        height: Get.width * 0.85,
        margin: const EdgeInsets.fromLTRB(padding, 0, padding, padding),
        decoration: BoxDecoration(
          color: lightGreenColor,
          borderRadius: BorderRadius.circular(padding / 2),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 10),
          ],
          image: DecorationImage(
            image: venue!.coverURL == '' ? AssetImage('assets/images/logo.png') as ImageProvider: CachedNetworkImageProvider(venue!.coverURL!),
            fit: venue!.coverURL == '' ? BoxFit.contain : BoxFit.cover,
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
                  child: CachedImage(url: venue!.logo, height: 50, roundedCorners: true),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(padding / 2)),
                    color: orangeColor,
                  ),
                  child: Text(venue!.averageRating!.toStringAsFixed(1) + ' ★', textScaleFactor: 0.85, style: TextStyle(color: Colors.white)),
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
                      Expanded(child:Text(venue!.venueName!, textScaleFactor: 0.9, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
                      ),
                      buildEcoIcon(),
                    ],
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      Expanded(child: Text(venue!.streetAddress! + ','+ venue!.townCity!+ ','+ venue!.postCode!.toUpperCase(), textScaleFactor: 0.85, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: greenColor))),
                    ],
                  ),
                  Row(
                    children: [
                       buildRecommendationDetails(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildRecommendationDetails() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height:5),
                        if (venue!.foodTypes!.isNotEmpty)
                        Container(
                          width: 325,
                           child: Row(
                             crossAxisAlignment: CrossAxisAlignment.start,

                             children: [
                               Text(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    softWrap: true,
                                    'Food types: ', style: TextStyle(fontSize:12, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
                             SizedBox(
                               width: 250,
                               child: Text(
                                   overflow: TextOverflow.ellipsis,
                                   maxLines: 2,
                                   softWrap: true,
                                   venue!.foodTypes!.join(", "), style: TextStyle(fontSize:12, fontStyle: FontStyle.italic)),
                             ),
                             ],
                           ),
                        ),
                      ],
                      ),
                     if (venue!.allergies!.isNotEmpty)
                       Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                               overflow: TextOverflow.ellipsis,
                               maxLines: 2,
                               softWrap: true,
                               'Allergies: ', style: TextStyle(fontSize:12, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
                           SizedBox(
                             width: 250,
                             child: Text(
                                 overflow: TextOverflow.ellipsis,
                                 maxLines: 2,
                                 softWrap: true,
                                venue!.allergies!.join(", "), style: TextStyle(fontSize:12, fontStyle: FontStyle.italic)),
                           ),
                         ],
                       ),
                    if (venue!.intolerances!.isNotEmpty)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: true,
                              'Intolerances: ', style: TextStyle(fontSize:12, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 250,
                            child: Text(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                softWrap: true,
                                venue!.intolerances!.join(", "), style: TextStyle(fontSize:12, fontStyle: FontStyle.italic)),
                          ),
                        ],
                      ),
                    if (venue!.vegan! == true || venue!.vegetarian! == true || venue!.dairyFree! == true || venue!.ketogenic! == true || venue!.paleo! == true || venue!.halal! == true)
                    Row(
                      children: [
                        Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: true,
                            'Diet: ', style: TextStyle(fontSize:12, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),

                        SizedBox(height: 5),
                        if (venue!.vegan! == true)
                          Text(' Vegan,', style: TextStyle(fontSize:12, fontStyle: FontStyle.italic, )),
                        if (venue!.vegetarian! == true)
                          Text(' Vegetarian,', style: TextStyle(fontSize:12, fontStyle: FontStyle.italic)),
                        if (venue!.dairyFree! == true)
                          Text(' Dairy Free,', style: TextStyle(fontSize:12, fontStyle: FontStyle.italic)),
                        if (venue!.ketogenic! == true)
                          Text(' Ketogenic,', style: TextStyle(fontSize:12, fontStyle: FontStyle.italic)),
                        if (venue!.halal! == true)
                          Text(' Halal,', style: TextStyle(fontSize:12, fontStyle: FontStyle.italic)),
                        if (venue!.paleo! == true)
                          Text(' Paleo,', style: TextStyle(fontSize:12, fontStyle: FontStyle.italic)),
                      ],

                    )
                    ],
      ),
    );
  }

  buildEcoIcon() {
    return InkWell(
      onTap: () {
        Get.defaultDialog(
          radius: padding / 2,
          title: 'Environmental Details',
          content: Column(
            children: [
              if (venue!.venueImpactStatus!.toUpperCase() != 'NONE')
                infoItem(Icons.star, '${venue!.venueImpactStatus!.toUpperCase()}' + ' Sustainability Rating', venue!.venueImpactStatus!.toUpperCase() != 'NONE'),
              if (venue!.foodWaste! <= 10)
                infoItem(FontAwesomeIcons.trashCan, '${venue!.foodWaste!.toString()}' + '% Food waste', venue!.foodWaste!.toString() != 'UNKNOWN'),
              if (venue!.singleUsePlastic! == true)
                infoItem(Icons.recycling, (venue!.singleUsePlastic! ? 'No single use plastic' : 'yes'), venue!.singleUsePlastic!),
              if (venue!.sourceLocally! == true)
                infoItem(Icons.local_drink_outlined,(venue!.sourceLocally! ? 'We source locally' : ': No'), venue!.sourceLocally!),
              if (venue!.cleanEnergy! == true)
                infoItem(Icons.wind_power_outlined, (venue!.cleanEnergy! ? 'We use clean energy' : ': No'), venue!.cleanEnergy!),
              if (venue!.sustainableFish! == true)
                infoItem(Icons.set_meal_outlined, (venue!.sustainableFish! ? 'Sustainable fish available': ': N/A'), venue!.sustainableFish!),
              if (venue!.sustainableMeat! == true)
                infoItem(Icons.kebab_dining_outlined, (venue!.sustainableMeat! ? 'Locally sourced meat available' : ': N/A'), venue!.sustainableMeat!),
              if (venue!.plantBasedOptions! == true)
                infoItem(Icons.eco_outlined, (venue!.plantBasedOptions! ? 'Plant based options available' : ' not available'), venue!.plantBasedOptions!),
              if (venue!.sustainableCleaning! == true)
                infoItem(Icons.cleaning_services_outlined, (venue!.sustainableCleaning! ? 'We use eco friendly products to clean' : ' N/A'), venue!.sustainableCleaning!),
              if (venue!.averageCarbonPerMeal! != 0)
                infoItem(Icons.co2_outlined, 'Average Co2 per meal: ${venue!.averageCarbonPerMeal!.toString()}' + 'kg', venue!.averageCarbonPerMeal!.toString() != 'UNKNOWN'),
              if (venue!.venueCarbonFootprint! != 0)
                infoItem(Icons.co2_outlined, 'Venue annual Co2: ${venue!.venueCarbonFootprint!.toString()}' + ' metric tons', venue!.venueCarbonFootprint!.toString() != 'UNKNOWN'),
            ],
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
                Text( venue!.sustainabilityRating!.toStringAsFixed(1) + ' ★', textScaleFactor: 0.8, style: TextStyle(color: Colors.white)),
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
