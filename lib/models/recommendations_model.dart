import 'package:cloud_firestore/cloud_firestore.dart';

class Recommendations {

  List? venueIDs;
  List? userIDs;
  List? matchFields;

  Recommendations({
    this.venueIDs,
    this.userIDs,
    this.matchFields,
  });

  factory Recommendations.fromDocument(Map<String, dynamic> doc) {
    return Recommendations(
      venueIDs: doc['venueIDs'] ?? [],
      userIDs: doc['userIDs'] ?? [],
      matchFields: doc['matchFields'] ?? [],
    );
    try {
      return Recommendations(
        venueIDs: doc['venueIDs'] ?? [],
        userIDs: doc['userIDs'] ?? [],
        matchFields: doc['matchFields'] ?? [],
      );
    } catch (e) {
      print(e);
      return null!;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'venueIDs': venueIDs,
      'userIDs':userIDs,
      'matchFields':matchFields,
    };
  }
}