import 'package:cloud_firestore/cloud_firestore.dart';

class HelpCategoryModel {
  final String? categoryName;
  final String? categoryID;
  final String? createdBy;
  final Timestamp? creationDate;



  HelpCategoryModel({
   this.categoryName,
    this.categoryID,
    this.createdBy,
   this.creationDate,

  });

  factory HelpCategoryModel.fromDocument(Map<String, dynamic> doc) {
      return HelpCategoryModel(
       categoryName: doc['categoryName'] ?? '',
        categoryID: doc['categoryID'] ?? '',
       createdBy: doc['createdBy'] ?? '',
        creationDate: doc['creationDate'] ?? doc['creationDate'] ?? Timestamp.fromDate(DateTime(2024, 1, 1)),

          );
    /* try {
      return HelpCategoryModel(
  Map<String, Object> toJson() {
    return {
       categoryName: doc['categoryName'] ?? '',
        categoryID: doc['categoryID'] ?? '',
        createdBy: doc['createdBy'] ?? '',
        creationDate: doc['creationDate'] ?? doc['creationDate'] ?? Timestamp.fromDate(DateTime(2024, 1, 1)),

         };
     } catch (e) {
      print('****** HELP CATEGORY MODEL ******');
      print(e);
      return null!;
    }
  }
     */
  }

  Map<String, Object> toJson() {
    return {
      'categoryName': categoryName!,
      'categoryID': categoryID!,
      'createdBy' : createdBy!,
      'creationDate' : creationDate!,
    };
  }
}



