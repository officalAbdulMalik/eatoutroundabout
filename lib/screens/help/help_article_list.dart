import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatoutroundabout/controllers/user_controller.dart';
import 'package:eatoutroundabout/models/business_profile.dart';
import 'package:eatoutroundabout/models/help_category_model.dart';
import 'package:eatoutroundabout/models/help_model.dart';
import 'package:eatoutroundabout/models/venue_model.dart';
import 'package:eatoutroundabout/screens/admin/admin_home.dart';
import 'package:eatoutroundabout/screens/admin/business/add_business_profile.dart';
import 'package:eatoutroundabout/screens/admin/venue/add_a_venue.dart';
import 'package:eatoutroundabout/screens/auth/section_splash.dart';
import 'package:eatoutroundabout/screens/help/help_article.dart';
import 'package:eatoutroundabout/services/cloud_function.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/business_profile_item.dart';
import 'package:eatoutroundabout/widgets/custom_button.dart';
import 'package:eatoutroundabout/widgets/empty_box.dart';
import 'package:eatoutroundabout/widgets/heading.dart';
import 'package:eatoutroundabout/widgets/help_article_list_item.dart';
import 'package:eatoutroundabout/widgets/help_list_item.dart';
import 'package:eatoutroundabout/widgets/loading.dart';
import 'package:eatoutroundabout/widgets/venue_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class HelpArticleList extends StatelessWidget {
  final HelpCategoryModel? helpCategory;
  final bool? isMyHelpCategory;

  HelpArticleList({this.helpCategory, this.isMyHelpCategory});
  //final miscService = Get.find<UtilService>();
  final firestoreService = Get.find<FirestoreService>();



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
              Heading(title: 'HELP ARTICLES'),

              Expanded(child:
                PaginateFirestore(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  isLive: true,
                  key: GlobalKey(),
                  padding: EdgeInsets.symmetric(horizontal: padding),
                  itemBuilderType: PaginateBuilderType.listView,
                  itemBuilder: (context, documentSnapshot, i) {
                    HelpModel help = documentSnapshot[i].data() as HelpModel;
                    return HelpArticleListItem(help: help, isMyHelp: true);
                  },
                  query: firestoreService
                      .getMyHelpArticlesByCategoryID(helpCategory!.categoryID!),
                  onEmpty: Padding(
                    padding: EdgeInsets.only(
                        bottom: Get.height / 2 - 200, left: 25, right: 25),
                    child: Text(
                      'No help articles to show',
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.15,
                    ),
                  ),
                  itemsPerPage: 10,
                  bottomLoader: LoadingData(),
                  initialLoader: LoadingData(),
                ),
              )
            ]
        )
    );


  }

}




