import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/services/util_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/heading.dart';
import 'package:eatoutroundabout/models/business_profile.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:eatoutroundabout/widgets/loading.dart';
import 'package:eatoutroundabout/controllers/user_controller.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class ViewSocialValueCertificate extends StatefulWidget {
  final BusinessProfile? businessProfile;


  ViewSocialValueCertificate({this.businessProfile});

  @override
  State<ViewSocialValueCertificate> createState() => _ViewSocialValueCertificateState();
}

class _ViewSocialValueCertificateState extends State<ViewSocialValueCertificate> {
  final firestoreService = Get.find<FirestoreService>();

  final utilService = Get.find<UtilService>();
  var formatter = NumberFormat('#,##,000');



  @override
  Widget build(BuildContext context) {
    num number_socialValue = widget.businessProfile!.socialValueScore!;
    String socialValue_output = NumberFormat.decimalPattern().format(number_socialValue);


    return

      Scaffold(
        appBar: AppBar(
            title: Image.asset('assets/images/applogo.png',
                height: AppBar().preferredSize.height - 15)),
        body:
        //DefaultTabController(length: 3, child:
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     Heading(title: 'CERTIFICATE'),
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Card(
        //         child: Container(
        //           child: Column(
        //             children: [
        //               Container(
        //                 height: 120,
        //                 color: primaryColor,
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   children: [
        //                     Expanded(
        //                         child: Padding(
        //                           padding: const EdgeInsets.all(10.0),
        //                           child: Image.asset('assets/images/applogo.png'),
        //                         ))
        //                   ],
        //                 ),
        //               ),
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Text('Certificate', textScaleFactor: 3, style: TextStyle(color: primaryColor)),
        //                 ],
        //               ),
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Text('of Social Value', textScaleFactor: 2, style: TextStyle(color: primaryColor)),
        //                 ],
        //               ),
        //               SizedBox(height: 20),
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Text(businessProfile!.businessName!, textScaleFactor: 1.5, style: TextStyle(color: primaryColor)),
        //                 ],
        //               ),
        //               SizedBox(height: 20),
        //               Row(
        //                 children: List.generate(150~/10, (index) => Expanded(
        //                   child: Container(
        //                     color: index%2==0?Colors.transparent
        //                         :Colors.grey,
        //                     height: 2,
        //                   ),
        //                 )
        //                 ),
        //               ),
        //               SizedBox(height: 20),
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Text('Registration No:', textScaleFactor: 1, style: TextStyle(color: primaryColor)),
        //                 ],
        //               ),
        //
        //               SizedBox(height: 20),
        //               Row(
        //                 children: List.generate(150~/10, (index) => Expanded(
        //                   child: Container(
        //                     color: index%2==0?Colors.transparent
        //                         :Colors.grey,
        //                     height: 2,
        //                   ),
        //                 )
        //                 ),
        //               ),
        //               SizedBox(height: 20),
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Text('Since: ' + DateFormat('MMM yyyy').format(businessProfile!.creationDate!.toDate()), textScaleFactor: 1),
        //                   //Text(businessProfile!.socialValueScore!),
        //                 ],
        //               ),
        //
        //               SizedBox(height: 20),
        //               Row(
        //                 children: List.generate(150~/10, (index) => Expanded(
        //                   child: Container(
        //                     color: index%2==0?Colors.transparent
        //                         :Colors.grey,
        //                     height: 2,
        //                   ),
        //                 )
        //                 ),
        //               ),
        //               SizedBox(height: 20),
        //           Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Container(
        //                 child: Row(
        //                   children: <Widget>[
        //                     Flexible(
        //                     // child: new Text('This certifies that the member named above has contributed £750,000 in social value with Eat Out Round About' + Emojis.symbols_registered, textScaleFactor: 1, style: TextStyle(color: primaryColor)
        //                     // )
        //                        child: new Text('This certifies that the member named above has contributed £' + businessProfile!.socialValueScore!.toString() + ' in social value with Eat Out Round About' + Emojis.symbols_registered, textScaleFactor: 1, style: TextStyle(color: primaryColor)
        //                 ))
        //                   ],
        //
        //                 )
        //
        //                             ),
        //           ),
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   // Container(
        //                   //   height: 100.0,
        //                   //   decoration: new BoxDecoration(
        //                   //     color: Colors.white,
        //                   //     shape: BoxShape.circle,
        //                   //   ),
        //                   //   child: Center(
        //                   //     child: Stack(
        //                   //       alignment: Alignment.center,
        //                   //       children: <Widget>[
        //                   //         Icon(Icons.star, color: silverColor, size: 75,),
        //                   //
        //                   //         Text(
        //                   //             businessProfile!.svProfileRating!.toString(),
        //                   //           style: TextStyle(fontSize: 18,color: Colors.white),
        //                   //         ),
        //                   //       ],
        //                   //     ),
        //                   //   ),
        //                   // )
        //
        //                    ],
        //               ),
        //               Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Container(
        //                     child: Row(
        //                       children: <Widget>[
        //                         Flexible(
        //                             child: new Text('Not Usual Ltd, Company Registration Number: ', textScaleFactor: 0.8, style: TextStyle(color: primaryColor)
        //                             )) ],
        //
        //                     )
        //
        //                 ),
        //               ),
        //             ],
        //
        //           ),
        //         ),
        //
        //         ),
        //       ),
        //
        //   ],
        //
        // ),
        // ),

        Center(
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.network(
                  'https://alig10.sg-host.com/images/certificate.png',
                  height: 600,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.businessProfile!.businessName!, textScaleFactor: 1.5, style: TextStyle(color: primaryColor)),
                      SizedBox(height: 10),
                      Text('for generating £' + socialValue_output + ' in social value', textScaleFactor: 1, style: TextStyle(color: primaryColor)),
                      SizedBox(height: 10),
                      Text('since ' + DateFormat('dd MMM yyyy').format(widget.businessProfile!.creationDate!.toDate()), textScaleFactor: 1, style: TextStyle(color: primaryColor)),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      );
  }}
