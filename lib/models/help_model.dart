import 'package:cloud_firestore/cloud_firestore.dart';

class HelpModel {
  final String? helpUserType;
  final String? categoryID;
  final String? helpSubCategory;
  final String? helpID;
  final String? helpImage;
  final String? helpTitle;
  final String? helpDescription;
  final Timestamp? helpCreatedDate;
  final String? helpCreatedBy;

  HelpModel({
    this.helpUserType,
    this.categoryID,
    this.helpSubCategory,
    this.helpID,
    this.helpImage,
    this.helpTitle,
    this.helpDescription,
    this.helpCreatedDate,
    this.helpCreatedBy,

  });

  factory HelpModel.fromDocument(Map<String, dynamic> doc) {
      return HelpModel(
        helpUserType: doc['helpUserType'] ?? '',
        categoryID: doc['categoryID'] ?? '',
        helpSubCategory: doc['helpSubCategory'] ?? '',
        helpID: doc['helpID'] ?? '',
        helpImage: doc['helpImage'] ?? '',
        helpTitle: doc['helpTitle'] ?? '',
        helpDescription: doc['helpDescription'] ?? '',
        helpCreatedDate: doc['helpCreatedDate'] ?? doc['helpCreatedDate'] ?? Timestamp.fromDate(DateTime(2024, 1, 1)),
        helpCreatedBy: doc['helpCreatedBy'] ?? '',
    );
    /* try {
      return HelpModel(

  Map<String, Object> toJson() {
    return {
       helpUserType: doc['helpUserType'] ?? '',
        categoryID: doc['categoryID'] ?? '',
        helpSubCategory: doc['helpSubCategory'] ?? '',
        helpID: doc['helpID'] ?? '',
        helpImage: doc['helpImage'] ?? '',
        helpTitle: doc['helpTitle'] ?? '',
        helpDescription: doc['helpDescription'] ?? '',
        helpCreatedDate: doc['helpCreatedDate'] ?? doc['helpCreatedDate'] ?? Timestamp.fromDate(DateTime(2024, 1, 1)),
        helpCreatedBy: doc['helpCreatedBy'] ?? '',
    };
     } catch (e) {
      print('****** HELP MODEL ******');
      print(e);
      return null!;
    }
  }
     */
  }


  Map<String, Object> toJson() {
    return {
      'helpUserType': helpUserType!,
      'categoryID': categoryID!,
      'helpSubCategory': helpSubCategory!,
      'helpID': helpID!,
      'helpImage': helpImage!,
      'helpTitle': helpTitle!,
      'helpDescription': helpDescription!,
      'helpCreatedDate': helpCreatedDate!,
      'helpCreatedBy': helpCreatedBy!,
    };
  }
}



