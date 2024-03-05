
import 'package:eatoutroundabout/models/help_category_model.dart';
import 'package:eatoutroundabout/models/help_model.dart';
import 'package:eatoutroundabout/screens/help/help_article.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/services/util_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/cached_image.dart';
import 'package:eatoutroundabout/widgets/custom_list_tile.dart';
import 'package:eatoutroundabout/widgets/heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';



class HelpArticleListItem extends StatelessWidget {
  final HelpModel? help;
  final bool? isMyHelp;

  HelpArticleListItem({this.help, this.isMyHelp});
  final miscService = Get.find<UtilService>();
  final firestoreService = Get.find<FirestoreService>();


  @override
  Widget build(BuildContext context) {

    return

      Column(
        children: [
          SizedBox(height:15),
          CustomListTile(
              onTap: () => Get.to(() => HelpArticle(help: help!, isMyHelpArticle: true)),
              trailing: Icon(Icons.keyboard_arrow_right_rounded, color: primaryColor),
              leading: Icon(Icons.question_mark, color: primaryColor),
              title: Text(help!.helpTitle!, style: TextStyle(color: primaryColor),
                //trailing: Icon(Icons.keyboard_arrow_right_rounded, color: primaryColor),
              )
          ),
        ],
      );

  }
}
