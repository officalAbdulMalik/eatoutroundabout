import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatoutroundabout/controllers/user_controller.dart';
import 'package:eatoutroundabout/models/community_members_model.dart';
import 'package:eatoutroundabout/models/community_model.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/services/util_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JoinCommunityButton extends StatefulWidget {
  final Community? community;

  JoinCommunityButton({this.community});

  @override
  _JoinCommunityButtonState createState() => _JoinCommunityButtonState();
}

class _JoinCommunityButtonState extends State<JoinCommunityButton> {
  final communityService = Get.find<FirestoreService>();
  final utilService = Get.find<UtilService>();
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: communityService.checkIfJoinedCommunity(widget.community!.communityID!),
      builder: (context, AsyncSnapshot<DocumentSnapshot<CommunityMember>> snapshot) {
        if (snapshot.hasData) {
          CommunityMember communityMember = snapshot.data!.data() as CommunityMember;
          return Padding(
            padding: const EdgeInsets.all(padding),
            child: CustomButton(
              color: communityMember != null ? Colors.grey.shade400 : primaryColor,
              text: getText(communityMember),
              function: () {
                if (!communityMember.approved!) {
                  showRedAlert('Already requested. The admin will allow you to access the community');
                } else
                  Get.defaultDialog(
                    radius: padding / 2,
                    title: 'Confirm',
                    content: Text("Would you like to ${communityMember != null ? 'Leave' : 'Join'} this community?", textScaleFactor: 1, textAlign: TextAlign.center),
                    actions: [
                      CustomButton(
                        color: primaryColor,
                        text: 'Yes',
                        function: () async {
                          Get.back(); // Close Alert Dialog
                          if (widget.community!.admin!.length == 1 && widget.community!.admin!.contains(userController.currentUser.value.userID))
                            showRedAlert('Please make someone an admin before leaving the community');
                          else {
                            utilService.showLoading();
                            communityService.exitCommunity(widget.community!);
                            Get.back();
                          }
                        },
                      ),
                      CustomButton(function: () => Get.back(), text: 'Cancel', color: Colors.grey),
                    ],
                  );
              },
            ),
          );
        } else
          return Container();
      },
    );
  }

  getText(CommunityMember communityMembersModel) {
    if (communityMembersModel.approved!)
      return 'Leave Community';
    else
      return 'Requested';
  }
}
