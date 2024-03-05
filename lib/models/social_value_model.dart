import 'package:cloud_firestore/cloud_firestore.dart';

//consoldates social impacts from different sources and pulls in evidence
class SocialValue {
  // from project, userVoucher, venue or order
  String? ID;
  String? businessProfileID;
  String? beneficiaryBusinessProfileID;
  Timestamp? creationDate;
  String? sponsorID;
  String? frameworkItemID;
  String? localAuth;
  String? partnerbusinessProfileID;
  String? projectID;
  String? title;
  String? userID;
  num? value;
  String? valueType;
  String? venueID;
  String? trailingValueType;


  SocialValue({
    this.ID,
    this.businessProfileID,
    this.beneficiaryBusinessProfileID,
    this.creationDate,
    this.sponsorID,
    this.frameworkItemID,
    this.localAuth,
    this.partnerbusinessProfileID,
    this.projectID,
    this.title,
    this.userID,
    this.value,
    this.valueType,
    this.venueID,
    this.trailingValueType,

  });

  factory SocialValue.fromDocument(Map<String, dynamic> doc) {
    return SocialValue(

      ID: doc['ID'] ?? '',
      businessProfileID: doc['businessProfileID'] ?? '',
      creationDate: doc['creationDate'] ?? doc['creationDate'] ?? Timestamp.fromDate(DateTime(2024, 1, 1)),
      beneficiaryBusinessProfileID: doc['beneficiaryBusinessProfileID'] ?? '',
      sponsorID: doc['sponsorID'] ?? '',
      frameworkItemID: doc['frameworkItemID'] ?? '',
      localAuth: doc['localAuth'] ?? '',
      partnerbusinessProfileID: doc['partnerbusinessProfileID'] ?? '',
      projectID: doc['projectID'] ?? '',
      title: doc['title'] ?? '',
      userID: doc['userID'] ?? '',
      value: doc['value'] ?? 0,
      valueType: doc['valueType'] ?? '',
      venueID: doc['venueID'] ?? '',
      trailingValueType: doc['trailingValueType'] ?? '',

    );
    try {
      return SocialValue(
        ID: doc['ID'] ?? '',
        businessProfileID: doc['businessProfileID'] ?? '',
        creationDate: doc['creationDate'] ?? doc['creationDate'] ?? Timestamp.fromDate(DateTime(2024, 1, 1)),
        beneficiaryBusinessProfileID: doc['beneficiaryBusinessProfileID'] ?? '',
        sponsorID: doc['sponsorID'] ?? '',
        frameworkItemID: doc['frameworkItemID'] ?? '',
        localAuth: doc['localAuth'] ?? '',
        partnerbusinessProfileID: doc['partnerbusinessProfileID'] ?? '',
        projectID: doc['projectID'] ?? '',
        title: doc['title'] ?? '',
        userID: doc['userID'] ?? '',
        value: doc['value'] ?? 0,
        valueType: doc['valueType'] ?? '',
        venueID: doc['venueID'] ?? '',
        trailingValueType: doc['trailingValueType'] ?? '',
      );
    } catch (e) {
      print(e);
      return null!;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': ID,
      'businessProfileID': businessProfileID,
      'creationDate': creationDate,
      'beneficiaryBusinessProfileID': beneficiaryBusinessProfileID,
      'sponsorID': sponsorID,
      'frameworkItemID': frameworkItemID,
      'localAuth': localAuth,
      'partnerbusinessProfileID': partnerbusinessProfileID,
      'projectID': projectID,
      'title': title,
      'userID': userID,
      'value': value,
      'valueType': valueType,
      'venueID': venueID,
      'trailingValueType': trailingValueType,
    };
  }
}