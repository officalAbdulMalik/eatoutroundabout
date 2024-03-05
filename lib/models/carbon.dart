import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatoutroundabout/controllers/user_controller.dart';
import 'package:get/get.dart';

class Carbon {
  final String? carbonID;
  final num? distance;
  final String? travelMode;
  final num? travelCarbonEstimate;
  final bool? mealType;
  final num? mealCarbonEstimate;
  final num? totalCarbonEstimate;
  final String? totalOffset;
  final num? totalCarbon;
  final Timestamp? creationDate;


  Carbon({
    this.carbonID,
    this.distance,
    this.travelMode,
    this.travelCarbonEstimate,
    this.mealType,
    this.mealCarbonEstimate,
    this.totalCarbonEstimate,
    this.totalOffset,
    this.totalCarbon,
    this.creationDate,

});

  factory Carbon.fromDocument(Map<String, dynamic> doc) {

    return Carbon(
      carbonID: doc['carbonID'] ?? '',
      distance: doc['distance'] ?? 0,
      travelMode: doc['travelMode'] ?? '',
      travelCarbonEstimate: doc['travelCarbonEstimate'] ?? 0,
      mealType: doc['mealType'] ?? '',
      mealCarbonEstimate: doc['mealCarbonEstimate'] ?? 0,
      totalCarbonEstimate: doc['totalCarbonEstimate'] ?? 0,
      totalOffset: doc['totalOffset'] ?? 0,
      totalCarbon: doc['totalCarbon'] ?? 0,
      creationDate: doc['creationDate'] ?? Timestamp.now(),
    );

    try {
       return Carbon(
         carbonID: doc['carbonID'] ?? '',
         distance: doc['distance'] ?? 0,
         travelMode: doc['travelMode'] ?? '',
         travelCarbonEstimate: doc['travelCarbonEstimate'] ?? 0,
         mealType: doc['mealType'] ?? '',
         mealCarbonEstimate: doc['mealCarbonEstimate'] ?? 0,
         totalCarbonEstimate: doc['totalCarbonEstimate'] ?? 0,
         totalOffset: doc['totalOffset'] ?? 0,
         totalCarbon: doc['totalCarbon'] ?? 0,
         creationDate: doc['creationDate'] ?? Timestamp.now(),
      );
    } catch (e) {
      print('****** CARBON MODEL ******');
      print(e);
      return null!;
    }
  }

  Map<String, Object> toJson() {
    return {
      'carbonID': carbonID!,
      'distance': distance!,
      'travelMode': travelMode!,
      'travelCarbonEstimate': travelCarbonEstimate!,
      'mealType': mealType!,
      'mealCarbonEstimate': mealCarbonEstimate!,
      'totalCarbonEstimate': totalCarbonEstimate!,
      'totalOffset': totalOffset!,
      'totalCarbon': totalCarbon!,
      'Timestamp': creationDate!,
    };
  }
}

