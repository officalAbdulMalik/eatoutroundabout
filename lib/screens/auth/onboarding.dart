import 'package:eatoutroundabout/screens/auth/signup.dart';
import 'package:eatoutroundabout/utils/preferences.dart';
import 'package:eatoutroundabout/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  SwiperController controller = SwiperController();
  List<String> titles = [
    'Eat out more sustainably',
    'Feel good',
    'Make a difference',
    'Save money & do more good!',
//    'Receive bites as rewards to discount vouchers',
  ];
  List<String> description = [
    'Make positive sustainable choices when you eat out',
    'See the difference you make for your local community and for the environment',
    'Support local jobs, local businesses and local supply chains',
    'Enter your promocode to offset your Co2 footprint and save over £150+ with vouchers for eating out!',
//    'See the impact you make to the local economy when you dine out and receive bites as rewards',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Swiper(
          controller: controller,
          loop: false,
          itemBuilder: (context, i) {
            return page(i);
          },
          itemCount: 4,
          pagination: new SwiperPagination(builder: SwiperCustomPagination(builder: (BuildContext context, SwiperPluginConfig config) {
            return SingleChildScrollView(scrollDirection: Axis.horizontal, child: DotSwiperPaginationBuilder(color: Colors.grey, activeColor: Colors.white, size: 10.0, activeSize: 15.0).build(context, config));
          })),
        ));
  }

  page(int pageNumber) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/s${pageNumber + 1}.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(titles[pageNumber], textAlign: TextAlign.center, textScaleFactor: 1.75, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(height: 25),
          Text(description[pageNumber], textAlign: TextAlign.center, textScaleFactor: 1.15, style: TextStyle(color: Colors.white54)),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 25, 50, 50),
            child: CustomButton(
              text: pageNumber < 3 ? 'Next' : 'Proceed',
              function: () async {
                if (pageNumber < 3)
                  controller.next(animation: true);
                else {
                  await Preferences.setOnboardingStatus(true);
                  Get.off(() => SignUp());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
