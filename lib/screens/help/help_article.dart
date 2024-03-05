import 'package:eatoutroundabout/controllers/user_controller.dart';
import 'package:eatoutroundabout/models/event_model.dart';
import 'package:eatoutroundabout/models/help_category_model.dart';
import 'package:eatoutroundabout/models/help_model.dart';
import 'package:eatoutroundabout/screens/events/view_users.dart';
import 'package:eatoutroundabout/screens/home/popup_venues.dart';
import 'package:eatoutroundabout/services/cloud_function.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/attend_button.dart';
import 'package:eatoutroundabout/widgets/cached_image.dart';
import 'package:eatoutroundabout/widgets/check_in_button.dart';
import 'package:eatoutroundabout/widgets/custom_button.dart';
import 'package:eatoutroundabout/widgets/custom_list_tile.dart';
import 'package:eatoutroundabout/widgets/heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HelpArticle extends StatelessWidget {
  final HelpModel? help;
  final bool? isMyHelpArticle;

  HelpArticle ({this.help, this.isMyHelpArticle});

  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(title: Image.asset('assets/images/applogo.png', height: AppBar().preferredSize.height - 15), backgroundColor: primaryColor,actions: [
        IconButton(onPressed: () =>
            utilService.openLink('https://wa.me/message/IC4Q25UGDJGZA1'),
            icon: Icon(Icons.help_outline_rounded)),
      ],),
      
        body: Column(
        children: [
          Heading(title: 'HELP'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(padding),
                    child: Column(
                      children: [
                        if (help!.helpImage!.isNotEmpty)
                        Container(
                          height: MediaQuery.of(context).size.height * .35,
                          child:
                          CachedImage(
                            roundedCorners: true,
                            height: double.infinity,
                            url: help!.helpImage,
                          ),
                        ),
                        SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(padding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10),
                                    Text(help!.helpTitle!, textScaleFactor: 1.1, style: TextStyle(fontWeight: FontWeight.bold)),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ),


                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(padding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(help!.helpDescription!, style: TextStyle(fontWeight: FontWeight.bold, color: greenColor)),
                                    SizedBox(height: 10),
                                ],
                                ),
                              ),
                            ),


                          ],
                        ),

                      ],
                    ),
                  ),

                ],
                  ),
    )
          ),
          Column(
            children: [
              Text('Still Need Help?', style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor)),
              Text('Contact us on WhatsApp', style: TextStyle(fontWeight: FontWeight.normal, color: primaryColor)),
              IconButton(onPressed: () =>
                  utilService.openLink('https://wa.me/message/IC4Q25UGDJGZA1'),
                  icon: Icon(FontAwesomeIcons.whatsapp, color: Colors.green, size: 50)),
            SizedBox(height: 25),
            ],
          )
        ]
      )
    );
  }

  // openLink(String link) async {
  //   if (!link.startsWith('tel')) link = link.startsWith('http') ? link : 'https://' + link;
  //   utilService.openLink(link);
  // }



}
