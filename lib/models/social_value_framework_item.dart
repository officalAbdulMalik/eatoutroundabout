import 'package:cloud_firestore/cloud_firestore.dart';

class SocialValueFrameworkItem

{
  Timestamp? creationDate;
  String? framework;
  String? frameworkID;
  String? frameworkItemID;
  String? frameworkItemTitle;
  String? image;
  //List? localAuths;

  SocialValueFrameworkItem({
    this.creationDate,
    this.frameworkID,
    this.frameworkItemID,
    this.frameworkItemTitle,
    this.framework,
    this.image,
    //this.localAuths,
  });

  factory SocialValueFrameworkItem.fromDocument(Map<String, dynamic> doc) {
    return SocialValueFrameworkItem(
      creationDate: doc['creationDate'] ?? doc['creationDate'] ?? Timestamp.fromDate(DateTime(2024, 1, 1)),
      frameworkID: doc['frameworkID'] ?? '',
      frameworkItemID: doc['frameworkItemID'] ?? '',
      frameworkItemTitle: doc['frameworkItemTitle'] ?? '',
      framework: doc['framework'] ?? '',
      image: doc['image'] ?? '',
      // localAuths: doc['localAuths'] ?? [],
    );
    try {
      return SocialValueFrameworkItem(
        creationDate: doc['creationDate'] ?? doc['creationDate'] ?? Timestamp.fromDate(DateTime(2024, 1, 1)),
        frameworkID: doc['frameworkID'] ?? '',
        frameworkItemID: doc['frameworkItemID'] ?? '',
        frameworkItemTitle: doc['frameworkItemTitle'] ?? '',
        framework: doc['framework'] ?? '',
        image: doc['image'] ?? '',
        // localAuths: doc['localAuths'] ?? [],

      );
    } catch (e) {
      print(e);
      return null!;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'creationDate': creationDate,
      'frameworkID':frameworkID,
      'framework':framework,
      'frameworkItemID':frameworkItemID,
      'frameworkItemTitle':frameworkItemTitle,
      'image': image,
      // 'localAuths': localAuths,
    };
  }
}