import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatoutroundabout/controllers/user_controller.dart';
import 'package:get/get.dart';

class Voucher {
  final String? voucherID;
  final String? batchNo;
  final String? campaignID;
  final bool? claimable;
  final String? displayMessage;
  final bool? redeemable;
  final String? issuedCampaignName;
  final String? voucherOrderID;
  final String? redeemedVenueID;
  final String? voucherLogo;
  final String? voucherImage;
  final String? voucherRedemptionCode;
  final String? promoCode;
  final String? voucherOffer;
  final String? voucherType;
  final String? voucherSubType;
  final num? daysValid;
  final num? remainingVouchers;
  final num? maxClaimsPerUser;
  final String? lepRestricted;
  final String? localAuthRestricted;
  final String? wardRestricted;
  final String? venueRestricted;
  final String? bidRestricted;
  final Timestamp? definedExpiryDate;
  final String? venuePostcode;
  final Days? monday, tuesday, wednesday, thursday, friday, saturday, sunday;
  final String? venueName;
  final String? venueLocalAuthName;

  Voucher({
    this.voucherID,
    this.batchNo,
    this.campaignID,
    this.claimable,
    this.displayMessage,
    this.redeemable,
    this.issuedCampaignName,
    this.voucherOrderID,
    this.redeemedVenueID,
    this.voucherLogo,
    this.voucherImage,
    this.voucherRedemptionCode,
    this.promoCode,
    this.voucherOffer,
    this.voucherType,
    this.voucherSubType,
    this.daysValid,
    this.remainingVouchers,
    this.maxClaimsPerUser,
    this.lepRestricted,
    this.localAuthRestricted,
    this.wardRestricted,
    this.venueRestricted,
    this.bidRestricted,
    this.definedExpiryDate,
    this.venuePostcode,
    this.venueName,
    this.venueLocalAuthName,

    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
  });

  factory Voucher.fromDocument(Map<String, dynamic> doc) {
    final userController = Get.find<UserController>();
    String displayMessage = doc['displayMessage'] as String?? '';
    displayMessage = displayMessage.replaceAll('!@#\$%', userController.currentUser.value.firstName!);
    return Voucher(
      voucherID: doc['voucherID'] ?? doc['voucherId'] ?? null,
      batchNo: doc['batchNo'] ?? '',
      campaignID: doc['campaignID'] ?? '',
      claimable: doc['claimable'] as bool?? false,
      displayMessage: displayMessage,
      redeemable: doc['redeemable'] as bool?? false,
      issuedCampaignName: doc['issuedCampaignName'] ?? '',
      voucherOrderID: doc['voucherOrderID'] ?? '',
      redeemedVenueID: doc['redeemedVenueID'] ?? '',
      voucherLogo: doc['voucherLogo'] ?? '',
      voucherImage: doc['voucherImage'] ?? '',
      promoCode: doc['promoCode'] ?? '',
      voucherRedemptionCode: doc['voucherRedemptionCode'] ?? '',
      voucherOffer: doc['voucherOffer'] ?? 'Save 50% on food and soft drinks off-peak up to £10 per voucher. T&C\'s apply.',
      voucherType: doc['voucherType'] ?? '',
      voucherSubType: doc['voucherSubType'] ?? '',
      daysValid: doc['daysValid'] ?? 0,
      remainingVouchers: doc['remainingVouchers'] ?? 0,
      maxClaimsPerUser: doc['maxClaimsPerUser'] ?? 1,
      lepRestricted: doc['lepRestricted'] ?? '',
      localAuthRestricted: doc['localAuthRestricted'] ?? '',
      wardRestricted: doc['wardRestricted'] ?? '',
      venueRestricted: doc['venueRestricted'] ?? '',
      bidRestricted: doc['bidRestricted'] ?? '',
      definedExpiryDate: doc['definedExpiryDate'] ?? Timestamp.fromDate(DateTime(2100, 1, 1)),
      venuePostcode: doc['venuePostcode'] ?? '',
      venueName: doc['venueName'] ?? '',
      venueLocalAuthName: doc['venueLocalAuthName'] ?? '',

      monday: doc['monday'] != null ? Days.fromDocument(doc['monday']) : Days(accept: false, acceptTimeStart: 0, acceptTimeEnd: 0),
      tuesday: doc['tuesday'] != null ? Days.fromDocument(doc['tuesday']) : Days(accept: false, acceptTimeStart: 0, acceptTimeEnd: 0),
      wednesday: doc['wednesday'] != null ? Days.fromDocument(doc['wednesday']) : Days(accept: false, acceptTimeStart: 0, acceptTimeEnd: 0),
      thursday: doc['thursday'] != null ? Days.fromDocument(doc['thursday']) : Days(accept: false, acceptTimeStart: 0, acceptTimeEnd: 0),
      friday: doc['friday'] != null ? Days.fromDocument(doc['friday']) : Days(accept: false, acceptTimeStart: 0, acceptTimeEnd: 0),
      saturday: doc['saturday'] != null ? Days.fromDocument(doc['saturday']) : Days(accept: false, acceptTimeStart: 0, acceptTimeEnd: 0),
      sunday: doc['sunday'] != null ? Days.fromDocument(doc['sunday']) : Days(accept: false, acceptTimeStart: 0, acceptTimeEnd: 0),

    );

    try {
      final userController = Get.find<UserController>();
      String displayMessage = doc['displayMessage'] as String?? '';
      displayMessage = displayMessage.replaceAll('!@#\$%', userController.currentUser.value.firstName!);
      return Voucher(
        voucherID: doc['voucherID'] as String?? doc['voucherId'] as String?? null,
        batchNo: doc['batchNo'] as String?? '',
        campaignID: doc['campaignID'] as String?? '',
        claimable: doc['claimable'] as bool?? false,
        displayMessage: displayMessage,
        redeemable: doc['redeemable'] as bool?? false,
        issuedCampaignName: doc['issuedCampaignName'] as String?? '',
        voucherOrderID: doc['voucherOrderID'] as String?? '',
        redeemedVenueID: doc['redeemedVenueID'] as String?? '',
        voucherLogo: doc['voucherLogo'] as String?? '',
        voucherImage: doc['voucherImage'] as String?? '',
        promoCode: doc['promoCode'] as String?? '',
        voucherRedemptionCode: doc['voucherRedemptionCode'] as String?? '',
        voucherOffer: doc['voucherOffer'] as String?? 'Save 50% on food and soft drinks off-peak up to £10 per voucher. T&C\'s apply.',
        voucherType: doc['voucherType'] as String?? '',
        voucherSubType: doc['voucherSubType'] as String?? '',
        daysValid: doc['daysValid'] as num?? 0,
        remainingVouchers: doc['remainingVouchers'] as num?? 0,
        maxClaimsPerUser: doc['maxClaimsPerUser'] as num?? 1,
        lepRestricted: doc['lepRestricted'] as String?? '',
        localAuthRestricted: doc['localAuthRestricted'] as String?? '',
        wardRestricted: doc['wardRestricted'] as String?? '',
        venueRestricted: doc['venueRestricted'] as String?? '',
        bidRestricted: doc['bidRestricted'] as String?? '',
        definedExpiryDate: doc['definedExpiryDate'] as Timestamp?? Timestamp.fromDate(DateTime(2100, 1, 1)),
        venuePostcode: doc['venuePostcode'] ?? '',
        venueName: doc['venueName'] ?? '',
        venueLocalAuthName: doc['venueLocalAuthName'] ?? '',


        monday: doc['monday'] != null ? Days.fromDocument(doc['monday']) : Days(accept: false, acceptTimeStart: 0, acceptTimeEnd: 0),
        tuesday: doc['tuesday'] != null ? Days.fromDocument(doc['tuesday']) : Days(accept: false, acceptTimeStart: 0, acceptTimeEnd: 0),
        wednesday: doc['wednesday'] != null ? Days.fromDocument(doc['wednesday']) : Days(accept: false, acceptTimeStart: 0, acceptTimeEnd: 0),
        thursday: doc['thursday'] != null ? Days.fromDocument(doc['thursday']) : Days(accept: false, acceptTimeStart: 0, acceptTimeEnd: 0),
        friday: doc['friday'] != null ? Days.fromDocument(doc['friday']) : Days(accept: false, acceptTimeStart: 0, acceptTimeEnd: 0),
        saturday: doc['saturday'] != null ? Days.fromDocument(doc['saturday']) : Days(accept: false, acceptTimeStart: 0, acceptTimeEnd: 0),
        sunday: doc['sunday'] != null ? Days.fromDocument(doc['sunday']) : Days(accept: false, acceptTimeStart: 0, acceptTimeEnd: 0),


      );
    } catch (e) {
      print('****** VOUCHER MODEL ******');
      print(e);
      return null!;
    }
  }

  Map<String, Object> toJson() {
    return {
      'voucherID': voucherID!,
      'batchNo': batchNo!,
      'campaignID': campaignID!,
      'claimable': claimable!,
      'displayMessage': displayMessage!,
      'redeemable': redeemable!,
      'issuedCampaignName': issuedCampaignName!,
      'voucherOrderID': voucherOrderID!,
      'redeemedVenueID': redeemedVenueID!,
      'voucherLogo': voucherLogo!,
      'voucherImage': voucherImage!,
      'promoCode': promoCode!,
      'voucherRedemptionCode': voucherRedemptionCode!,
      'voucherOffer': voucherOffer!,
      'voucherType': voucherType!,
      'voucherSubType': voucherSubType!,
      'daysValid': daysValid!,
      'remainingVouchers': remainingVouchers!,
      'maxClaimsPerUser': maxClaimsPerUser!,
      'lepRestricted': lepRestricted!,
      'localAuthRestricted': localAuthRestricted!,
      'wardRestricted': wardRestricted!,
      'venueRestricted': venueRestricted!,
      'bidRestricted': bidRestricted!,
      'definedExpiryDate': definedExpiryDate!,
      'venuePostcode':venuePostcode!,
      'venueName': venueName!,
      'venueLocalAuthName': venueLocalAuthName!,

      'monday': monday!.toMap(),
      'tuesday': tuesday!.toMap(),
      'wednesday': wednesday!.toMap(),
      'thursday': thursday!.toMap(),
      'friday': friday!.toMap(),
      'saturday': saturday!.toMap(),
      'sunday': sunday!.toMap(),
    };
  }
}

class Days {
  num acceptTimeStart;
  num acceptTimeEnd;
  bool accept;
  bool isAccepting;

  Days({this.acceptTimeStart = 0, this.acceptTimeEnd =0, this.accept = true, this.isAccepting = true});

  factory Days.fromDocument(Map doc) {
    try {
      return Days(
        acceptTimeStart: doc['open'] ?? '',
        acceptTimeEnd: doc['close'] ?? '',
        accept: doc['accepts'] ?? true,
        isAccepting: doc['isAccepting'] ?? true,
      );
    } catch (e) {
      print('#########  Days  #########');
      print(e);
      return null!;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'open': acceptTimeStart,
      'close': acceptTimeEnd,
      'accept': accept,
      'isAccepting': isAccepting,
    };
  }
}