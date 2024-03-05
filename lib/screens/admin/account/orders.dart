import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatoutroundabout/controllers/user_controller.dart';
import 'package:eatoutroundabout/models/account_model.dart';
import 'package:eatoutroundabout/models/orders.dart';
import 'package:eatoutroundabout/services/firestore_service.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:eatoutroundabout/widgets/empty_box.dart';
import 'package:eatoutroundabout/widgets/heading.dart';
import 'package:eatoutroundabout/widgets/loading.dart';
import 'package:eatoutroundabout/widgets/order_item.dart';
import 'package:eatoutroundabout/widgets/orders_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountOrders extends StatefulWidget {
  final String? accountID;

  AccountOrders({this.accountID});

  @override
  _AccountOrdersState createState() => _AccountOrdersState();
}

class _AccountOrdersState extends State<AccountOrders> {
  final firestoreService = Get.find<FirestoreService>();
  final userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Image.asset('assets/images/applogo.png', height: AppBar().preferredSize.height - 15), backgroundColor: primaryColor),
      body: Column(
        children: <Widget>[
          Heading(title: 'ORDERS'),
          Expanded(
            child: Container(
              width: double.infinity,
              color: appBackground,
              child: FutureBuilder(
                future: firestoreService.getOrdersForAccount(),
                builder: (context, AsyncSnapshot<QuerySnapshot<Orders>> snapshot) {
                  if (snapshot.hasData)
                    return snapshot.data!.docs.isNotEmpty
                        ? ListView.builder(
                      padding: EdgeInsets.all(padding),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, i) {
                        Orders orders = snapshot.data!.docs[i].data();
                        return OrdersItem(orders: orders);
                        //return Text(orders!.orderID!);
                      },
                    )
                        : EmptyBox(text: 'No orders to show');
                  else
                    return LoadingData();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
