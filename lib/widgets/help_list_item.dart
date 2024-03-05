
import 'package:eatoutroundabout/models/help_category_model.dart';
import 'package:eatoutroundabout/screens/help/help_article_list.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/services/util_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class HelpCategoryItem extends StatelessWidget {
  final HelpCategoryModel? helpCategory;
  final bool? isMyHelpCategory;

  HelpCategoryItem({this.helpCategory, this.isMyHelpCategory});
  final miscService = Get.find<UtilService>();
  final firestoreService = Get.find<FirestoreService>();


  @override
  Widget build(BuildContext context) {

    return

      Column(
        children: [
          SizedBox(height:15),
          CustomListTile(
            onTap: () => Get.to(() => HelpArticleList(helpCategory: helpCategory!, isMyHelpCategory: true)),
              trailing: Icon(Icons.keyboard_arrow_right_rounded, color: primaryColor),
              //leading: Icon(helpCategory!.icon!, color: primaryColor),
            title: Text(helpCategory!.categoryName!, style: TextStyle(color: primaryColor),
                //trailing: Icon(Icons.keyboard_arrow_right_rounded, color: primaryColor),
            )
          ),
        ],
      );

  }
}
