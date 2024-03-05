import 'package:cloud_firestore/cloud_firestore.dart';

class Evidence {
  String? evidenceID;
  Timestamp? creationDate;
  String? socialValueID;
  String? evidenceType;
  num? value;
  String? measure;

  Evidence({
    this.evidenceID,
    this.creationDate,
    this.socialValueID,
    this.evidenceType,
    this.value,
    this.measure,
  });

  factory Evidence.fromDocument(Map<String, dynamic> doc) {
    return Evidence(
      evidenceID: doc['evidenceID'] ?? '',
      creationDate: doc['creationDate'] ?? doc['creationDate'] ?? Timestamp.fromDate(DateTime(2024, 1, 1)),
      socialValueID: doc['socialValueID'] ?? '',
      evidenceType: doc['evidenceType'] ?? '',
      value: doc['value'] ?? 0,
      measure: doc['measure'] ?? '',
    );
    try {
      return Evidence(
        evidenceID: doc['evidenceID'] ?? '',
        creationDate: doc['creationDate'] ?? doc['creationDate'] ?? Timestamp.fromDate(DateTime(2024, 1, 1)),
        socialValueID: doc['socialValueID'] ?? '',
        evidenceType: doc['evidenceType'] ?? '',
        value: doc['value'] ?? 0,
        measure: doc['measure'] ?? '',
      );
    } catch (e) {
      print(e);
      return null!;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'evidenceID': evidenceID,
      'creationDate': creationDate,
      'socialValueID': socialValueID,
      'evidenceType': evidenceType,
      'value': value,
      'measure': measure,
    };
  }
}