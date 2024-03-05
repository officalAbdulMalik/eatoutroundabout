import 'package:cloud_firestore/cloud_firestore.dart';

class Referrals {
  final String? referralID;
  final String? referralAccountID;
  final String? referralUserID;
  final Timestamp? referralDate;
  final String? referredAccountID;
  final String? referredUserID;
  final bool? venueAccount;


  Referrals({
    this.referralID,
    this.referralAccountID,
    this.referralUserID,
    this.referralDate,
    this.referredAccountID,
    this.referredUserID,
    this.venueAccount
  });

  factory Referrals.fromDocument(Map<String, dynamic> doc) {
    return Referrals(
      referralID: doc['referralID'] ?? '',
      referralAccountID: doc['referralAccountID'] ?? '',
      referralUserID: doc['referralUserID'] ?? '',
      referralDate: doc['referralDate'] ?? null,
      referredAccountID: doc['referredAccountID'] ?? '',
      referredUserID: doc['referredUserID'] ?? '',
      venueAccount: doc['venueAccount'] ?? false,

    );
    try {
      return Referrals(
        referralAccountID: doc['referralAccountID'] ?? '',
        referralUserID: doc['referralUserID'] ?? '',
        referralDate: doc['referralDate'] ?? null,
        referredAccountID: doc['referredAccountID'] ?? '',
        referredUserID: doc['referredUserID'] ?? '',
        venueAccount: doc['venueAccount'] ?? false,
      );
    } catch (e) {
      print('****** USER VOUCHERS MODEL ******');
      print(e);
      return null!;
    }
  }

  Map<String, Object> toJson() {
    return {
      'referralID': referralID!,
      'referralAccountID': referralAccountID!,
      'referralUserID': referralUserID!,
      'referralDate': referralDate!,
      'referredAccountID': referredAccountID!,
      'referredUserID': referredUserID!,
      'venueAccount': venueAccount!,
    };
  }
}
