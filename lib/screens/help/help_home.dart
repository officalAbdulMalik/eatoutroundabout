import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatoutroundabout/controllers/user_controller.dart';
import 'package:eatoutroundabout/models/business_profile.dart';
import 'package:eatoutroundabout/models/help_category_model.dart';
import 'package:eatoutroundabout/models/venue_model.dart';
import 'package:eatoutroundabout/screens/admin/admin_home.dart';
import 'package:eatoutroundabout/screens/admin/business/add_business_profile.dart';
import 'package:eatoutroundabout/screens/admin/venue/add_a_venue.dart';
import 'package:eatoutroundabout/screens/auth/section_splash.dart';
import 'package:eatoutroundabout/services/cloud_function.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/business_profile_item.dart';
import 'package:eatoutroundabout/widgets/custom_button.dart';
import 'package:eatoutroundabout/widgets/empty_box.dart';
import 'package:eatoutroundabout/widgets/heading.dart';
import 'package:eatoutroundabout/widgets/help_list_item.dart';
import 'package:eatoutroundabout/widgets/loading.dart';
import 'package:eatoutroundabout/widgets/venue_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class HelpHome extends StatelessWidget {
  final userController = Get.find<UserController>();
  final firestoreService = Get.find<FirestoreService>();

  //final utilService = Get.find<UtilService>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(
          title: Image.asset('assets/images/applogo.png',
              height: AppBar().preferredSize.height - 15),
          actions: [
            IconButton(onPressed: () =>
                utilService.openLink('https://wa.me/message/IC4Q25UGDJGZA1'),
                icon: Icon(Icons.help_outline_rounded)),
          ],
        ),
        body: Column(
          children: [
            Heading(title: 'HELP'),

                    Expanded(
              child: ListView.builder(
            itemCount: userController.currentUser.value.helpMainCategories!.length,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemBuilder: (context, i) {
    return FutureBuilder(
    builder: (context, AsyncSnapshot<DocumentSnapshot<HelpCategoryModel>> snapshot) {
    if (snapshot.hasData) {
    HelpCategoryModel helpCategory = snapshot.data!.data() as HelpCategoryModel;
    return HelpCategoryItem(helpCategory: helpCategory, isMyHelpCategory: true);
    } else
    return Container();
    },
    future: firestoreService.getHelpCategoryByHelpCategoryID(userController.currentUser.value.helpMainCategories![i]),
    );
    },
    )
            )

    ]
        )
                  );


  }

  }




