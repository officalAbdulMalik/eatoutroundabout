import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatoutroundabout/controllers/user_controller.dart';
import 'package:get/get.dart';

class Orders {
  final String? orderID;
  final String? businessProfileID;
  final String? beneficiaryProjectID;
  final num? membershipQty;
  final String? accountID;
  final String? createdBy;
  final String? status;
  final String? orderType;
  final num? unitPrice;
  final num? price;
  final num? VAT;
  final num? total;
  final Timestamp? creationDate;
  final String? invoiceURL;

  Orders({
    this.orderID,
    this.businessProfileID,
    this.beneficiaryProjectID,
    this.membershipQty,
    this.accountID,
    this.createdBy,
    this.status,
    this.creationDate,
    this.orderType,
    this.unitPrice,
    this.price,
    this.VAT,
    this.total,
    this.invoiceURL,
  });

  factory Orders.fromDocument(Map<String, dynamic> doc) {

    return Orders(
      orderID: doc['orderID'] ?? '',
      businessProfileID: doc['businessProfileID'] ?? '',
      beneficiaryProjectID: doc['beneficiaryProjectID'] ?? '',
      membershipQty: doc['membershipQty'] ?? 0,
      accountID: doc['accountID'] ?? '',
      createdBy: doc['createdBy'] ?? '',
      status: doc['status'] ?? '',
      orderType: doc['orderType'] ?? '',
      unitPrice: doc['unitPrice'] ?? 0,
      price: doc['price'] ?? 0,
      VAT: doc['VAT'] ?? 0,
      total: doc['total'] ?? 0,
      creationDate: doc['creationDate'] ?? Timestamp.now(),
      invoiceURL: doc['invoiceURL'] ?? '',
    );

    try {
      return Orders(
        orderID: doc['orderID'] ?? '',
        orderType: doc['orderType'] ?? '',
        unitPrice: doc['unitPrice'] ?? 0,
        price: doc['price'] ?? 0,
        VAT: doc['VAT'] ?? 0,
        total: doc['total'] ?? 0,
        businessProfileID: doc['businessProfileID'] ?? '',
        membershipQty: doc['membershipQty'] ?? 0,
        beneficiaryProjectID: doc['beneficiaryProjectID'] ?? '',
        accountID: doc['accountID'] ?? '',
        createdBy: doc['createdBy'] ?? '',
        status: doc['status'] ?? '',
        creationDate: doc['creationDate'] ?? Timestamp.now(),
        invoiceURL: doc['invoiceURL'] ?? '',
      );
    } catch (e) {
      print('****** CARBON MODEL ******');
      print(e);
      return null!;
    }
  }

  Map<String, Object> toJson() {
    return {
      'orderID': orderID!,
      'orderType': orderType!,
      'unitPrice': unitPrice!,
      'price': price!,
      'VAT' : VAT!,
      'total': total!,
      'businessProfileID':businessProfileID!,
      'membershipQty': membershipQty!,
      'beneficiaryProjectID': beneficiaryProjectID!,
      'accountID': accountID!,
      'createdBy' : createdBy!,
      'status': status!,
      'Timestamp':creationDate!,
      'invoiceURL': invoiceURL!,
    };
  }
}

