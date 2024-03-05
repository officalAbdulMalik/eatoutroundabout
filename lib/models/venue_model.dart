class Venue {
  //venue details
  final String? accountID;
  final String? accountAdmin;
  final List? receptionist;
  final String? venueID;
  final String? venueName;
  final String? streetAddress;
  final String? townCity;
  final String? postCode;
  final String? venueDescription;
  final String? venuePhoneNumber;
  final String? venueBookingLink;
  final String? website;
  final String? logo;
  final List? images;
  final String? coverURL;
  bool? paused;
  final bool? approved;
  final List? foodTypes;
  final String? otherFoodType;
  final Days? monday, tuesday, wednesday, thursday, friday, saturday, sunday;
  final String? venueType;

  //preferences
  final bool? vegan;
  final bool? vegetarian;
  final bool? halal;
  final bool? paleo;
  final bool? ketogenic;
  final bool? dairyFree;

  //economy
  final String? lepRestricted;
  final String? localAuthRestricted;
  final String? wardRestricted;
  final String? venueRestricted;
  final String? bidRestricted;

  // sustainability
  final String? venueImpactStatus;
  final bool? sourceLocally;
  final num? foodWaste;
  final bool? cleanEnergy;
  final bool? singleUsePlastic;
  final bool? sustainableFish;
  final bool? sustainableMeat;
  final bool? plantBasedOptions;
  final num? averageCarbonPerMeal;
  final num? venueCarbonFootprint;
  final bool? sustainableCleaning;
  final num? sustainabilityRating;

  //Partner Memberships
 final List? membershipLogo;
 final List? membershipURL;

  // equality diversity and inclusion
  final bool? preTheatreDining;
  final bool? dogFriendly;
  final bool? wheelChairAccess;
  final bool? disabledToilet;
  final bool? dietaryPrefBool;
  final List? intolerances;
  final List? allergies;
  final bool? lgbtq;
  final bool? inclusiveToilets;
  final num? noEmployees;
  final num? noDisabledEmployees;
  final num? inclusiveRating;

  // marketing

  final num? averageRating;
  final num? totalRatingsCount;
  final String? facebook;
  final String? instagram;
  final String? twitter;
  final String? linkedin;

  // covid
  final bool? takeaway;

  // recommendations
  final List? recommendationIDs;

  Venue({
    //venue details
    this.accountID,
    this.accountAdmin,
    this.receptionist,
    this.venueID,
    this.venueName,
    this.streetAddress,
    this.townCity,
    this.postCode,
    this.venueDescription,
    this.venueBookingLink,
    this.website,
    this.venuePhoneNumber,
    this.logo,
    this.images,
    this.coverURL,
    this.paused,
    this.approved,
    this.foodTypes,
    this.otherFoodType,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
    this.venueType,

    // diets
    this.vegan,
    this.vegetarian,
    this.halal,
    this.paleo,
    this.ketogenic,
    this.dairyFree,

    //Partner Memberships
   this.membershipLogo,
   this.membershipURL,

    //economy
    this.lepRestricted,
    this.localAuthRestricted,
    this.wardRestricted,
    this.venueRestricted,
    this.bidRestricted,

    // sustainability
    this.venueImpactStatus,
    this.sourceLocally,
    this.foodWaste,
    this.cleanEnergy,
    this.singleUsePlastic,
    this.sustainableFish,
    this.sustainableMeat,
    this.plantBasedOptions,
    this.averageCarbonPerMeal,
    this.venueCarbonFootprint,
    this.sustainableCleaning,
    this.sustainabilityRating,

// equality diversity and inclusion
    this.dogFriendly,
    this.wheelChairAccess,
    this.disabledToilet,
    this.dietaryPrefBool,
    this.intolerances,
    this.allergies,
    this.lgbtq,
    this.inclusiveToilets,
    this.noDisabledEmployees,
    this.noEmployees,
    this.inclusiveRating,

    // marketing
    this.preTheatreDining,
    this.averageRating,
    this.totalRatingsCount,
    this.facebook,
    this.instagram,
    this.twitter,
    this.linkedin,

    //covid
    this.takeaway,

    // recommendations
    this.recommendationIDs
  });

  factory Venue.fromDocument(Map<String, dynamic> doc) {
    return Venue(
      accountID: doc['accountID'] ?? ' ',
      accountAdmin: doc['accountAdmin'] ?? '',
      receptionist: doc['receptionist'] ?? [],
      venueID: doc['venueID'] ?? '',
      venueName: doc['venueName'] ?? '',
      streetAddress: doc['streetAddress'] ?? '',
      townCity: doc['townCity'] ?? '',
      postCode: doc['postCode'] ?? '',
      venueDescription: doc['venueDescription'] ?? '',
      venueBookingLink: doc['venueBookingLink'] ?? '',
      website: doc['website'] ?? '',
      venuePhoneNumber: doc['venuePhoneNumber'] ?? '',
      logo: doc['logo'] ?? '',
      images: doc['images'] ?? doc['coverURL'] ?? ''??[],
      coverURL: doc['coverURL'] ?? '',
      paused: doc['paused'] ?? false,
      approved: doc['approved'] ?? false,
      foodTypes: doc['foodTypes'] ?? [],

      otherFoodType: doc['otherFoodType'] ?? 'other',
      monday: doc['monday'] != null ? Days.fromDocument(doc['monday']as Map<dynamic,dynamic>) : Days(isOpen: false, open: 0, close: 0),
      tuesday: doc['tuesday'] != null ? Days.fromDocument(doc['tuesday']as Map<dynamic,dynamic>) : Days(isOpen: false, open: 0, close: 0),
      wednesday: doc['wednesday'] != null ? Days.fromDocument(doc['wednesday']as Map<dynamic,dynamic>) : Days(isOpen: false, open: 0, close: 0),
      thursday: doc['thursday'] != null ? Days.fromDocument(doc['thursday']as Map<dynamic,dynamic>) : Days(isOpen: false, open: 0, close: 0),
      friday: doc['friday'] != null ? Days.fromDocument(doc['friday']as Map<dynamic,dynamic>) : Days(isOpen: false, open: 0, close: 0),
      saturday: doc['saturday'] != null ? Days.fromDocument(doc['saturday']as Map<dynamic,dynamic>) : Days(isOpen: false, open: 0, close: 0),
      sunday: doc['sunday'] != null ? Days.fromDocument(doc['sunday'] as Map<dynamic,dynamic>) : Days(isOpen: false, open: 0, close: 0),
      venueType: doc['venueType'] ?? '',

      //Diets
      vegan: doc['vegan'] ?? false,
      vegetarian: doc['vegetarian'] ?? false,
      halal: doc['halal'] ?? false,
      paleo: doc['paleo'] ?? false,
      ketogenic: doc['ketogenic'] ?? false,
      dairyFree: doc['dairyFree'] ?? false,

      //Partner Memberships
      membershipLogo: doc['membershipLogo'] ?? [],
      membershipURL: doc['membershipURL'] ?? [],

      //economy
      lepRestricted: doc['lepRestricted'] ?? '',
      localAuthRestricted: doc['localAuthRestricted'] ?? '',
      wardRestricted: doc['wardRestricted'] ?? '',
      venueRestricted: doc['venueRestricted'] ?? '',
      bidRestricted: doc['bidRestricted'] ?? '',

      // sustainability

      venueImpactStatus: doc['venueImpactStatus'] ?? 'none',
      sourceLocally: doc['sourceLocally'] ?? 0,
      foodWaste: doc['foodWaste'] ?? 0,
      cleanEnergy: doc['cleanEnergy'] ?? false,
      singleUsePlastic: doc['singleUsePlastic'] ?? true,
      sustainableFish: doc['sustainableFish'] ?? false,
      sustainableMeat: doc['sustainableMeat'] ?? false,
      plantBasedOptions: doc['plantBasedOptions'] ?? false,
      averageCarbonPerMeal: doc['averageCarbonPerMeal'] ?? 0,
      venueCarbonFootprint: doc['venueCarbonFootprint'] ?? 0,
      sustainableCleaning: doc['sustainableCleaning'] ?? 0,
      sustainabilityRating: doc['sustainabilityRating'] ?? 0,

// equality diversity and inclusion
      dogFriendly: doc['dogFriendly'] ?? false,
      wheelChairAccess: doc['wheelChairAccess'] ?? false,
      disabledToilet: doc['disabledToilet'] ?? false,
      dietaryPrefBool: doc['dietaryPrefBool'] ?? false,
      intolerances: doc['intolerances'] ?? [],
      allergies: doc['allergies'] ?? [],
      lgbtq: doc['lgbtq'] ?? true,
      inclusiveToilets: doc['inclusiveToilets'] ?? false,
      noEmployees: doc['noEmployees'] ?? 0,
      noDisabledEmployees: doc['noDisabledEmployees'] ?? 0,
      inclusiveRating: doc['inclusiveRating'] ?? 0,

      // marketing
      preTheatreDining: doc['preTheatreDining'] ?? false,
      facebook: doc['facebook'] ?? '',
      instagram: doc['instagram'] ?? '',
      twitter: doc['twitter'] ?? '',
      linkedin: doc['linkedin'] ?? '',
      averageRating: doc['averageRating'] ?? 0,
      totalRatingsCount: doc['totalRatingsCount'] ?? 0,

      //covid
        takeaway: doc['takeaway'] ?? false,

        //recommendations
      recommendationIDs: doc['recommendationIDs'] ?? [],

    );
    try {
      return Venue(
        accountID: doc['accountID'] ?? ' ',
        accountAdmin: doc['accountAdmin'] ?? '',
        receptionist: doc['receptionist'] ?? [],
        venueID: doc['venueID'] ?? '',
        venueName: doc['venueName'] ?? '',
        streetAddress: doc['streetAddress'] ?? '',
        townCity: doc['townCity'] ?? '',
        postCode: doc['postCode'] ?? '',
        venueDescription: doc['venueDescription'] ?? '',
        venueBookingLink: doc['venueBookingLink'] ?? '',
        website: doc['website'] ?? '',
        venuePhoneNumber: doc['venuePhoneNumber'] ?? '',
        logo: doc['logo'] ?? '',
        images: doc['images'] ?? doc['coverURL'] ?? ''??[],
        coverURL: doc['coverURL'] ?? '',
        paused: doc['paused'] ?? false,
        approved: doc['approved'] ?? false,
        foodTypes: doc['foodTypes'] ?? [],
        otherFoodType: doc['otherFoodType'] ?? '',
        monday: doc['monday'] != null ? Days.fromDocument(doc['monday']as Map<dynamic,dynamic>) : Days(isOpen: false, open: 0, close: 0),
        tuesday: doc['tuesday'] != null ? Days.fromDocument(doc['tuesday']as Map<dynamic,dynamic>) : Days(isOpen: false, open: 0, close: 0),
        wednesday: doc['wednesday'] != null ? Days.fromDocument(doc['wednesday']as Map<dynamic,dynamic>) : Days(isOpen: false, open: 0, close: 0),
        thursday: doc['thursday'] != null ? Days.fromDocument(doc['thursday']as Map<dynamic,dynamic>) : Days(isOpen: false, open: 0, close: 0),
        friday: doc['friday'] != null ? Days.fromDocument(doc['friday']as Map<dynamic,dynamic>) : Days(isOpen: false, open: 0, close: 0),
        saturday: doc['saturday'] != null ? Days.fromDocument(doc['saturday']as Map<dynamic,dynamic>) : Days(isOpen: false, open: 0, close: 0),
        sunday: doc['sunday'] != null ? Days.fromDocument(doc['sunday'] as Map<dynamic,dynamic>) : Days(isOpen: false, open: 0, close: 0),
        venueType: doc['venueType'] ?? '',


        //Diets
        vegan: doc['vegan'] ?? false,
        vegetarian: doc['vegetarian'] ?? false,
        halal: doc['halal'] ?? false,
        paleo: doc['paleo'] ?? false,
        ketogenic: doc['ketogenic'] ?? false,
        dairyFree: doc['dairyFree'] ?? false,

        //economy
        lepRestricted: doc['lepRestricted'] ?? '',
        localAuthRestricted: doc['localAuthRestricted'] ?? '',
        wardRestricted: doc['wardRestricted'] ?? '',
        venueRestricted: doc['venueRestricted'] ?? '',
        bidRestricted: doc['bidRestricted'] ?? '',

        //Partner Memberships
        //Partner Memberships
        membershipLogo: doc['yorkshireMark'] ?? [],
        membershipURL: doc['yorkshireMarkApproved'] ?? [],


        // sustainability

        venueImpactStatus: doc['venueImpactStatus'] ?? 'none',
        sourceLocally: doc['sourceLocally'] ?? 0,
        foodWaste: doc['foodWaste'] ?? 0,
        cleanEnergy: doc['cleanEnergy'] ?? false,
        singleUsePlastic: doc['singleUsePlastic'] ?? true,
        sustainableFish: doc['sustainableFish'] ?? false,
        sustainableMeat: doc['sustainableMeat'] ?? false,
        plantBasedOptions: doc['plantBasedOptions'] ?? false,
        averageCarbonPerMeal: doc['averageCarbonPerMeal'] ?? 0,
        venueCarbonFootprint: doc['venueCarbonFootprint'] ?? 0,
        sustainableCleaning: doc['sustainableCleaning'] ?? 0,
        sustainabilityRating: doc['sustainabilityRating'] ?? 0,

// equality diversity and inclusion
        dogFriendly: doc['dogFriendly'] ?? false,
        wheelChairAccess: doc['wheelChairAccess'] ?? false,
        disabledToilet: doc['disabledToilet'] ?? false,
        dietaryPrefBool: doc['dietaryPrefBool'] ?? false,
        intolerances: doc['intolerances'] ?? [],
        allergies: doc['allergies'] ?? [],
        lgbtq: doc['lgbtq'] ?? true,
        inclusiveToilets: doc['inclusiveToilets'] ?? false,
        noEmployees: doc['noEmployees'] ?? 0,
        noDisabledEmployees: doc['noDisabledEmployees'] ?? 0,
        inclusiveRating: doc['inclusiveRating'] ?? 0,

        // marketing
        preTheatreDining: doc['preTheatreDining'] ?? false,
        facebook: doc['facebook'] ?? '',
        instagram: doc['instagram'] ?? '',
        twitter: doc['twitter'] ?? '',
        linkedin: doc['linkedin'] ?? '',
        averageRating: doc['averageRating'] ?? 0,
        totalRatingsCount: doc['totalRatingsCount'] ?? 0,

        //covid
       takeaway: doc['takeaway'] ?? false,

        //recommendations
        recommendationIDs: doc['recommendationIDs'] ?? [],

      );
    } catch (e) {
      print('########## VENUE MODEL ###########');
      print(e);
      return null!;
    }
  }

 Map<String, Object> toJson() {
    return {

      //venue details
      'accountID': accountID!,
      'accountAdmin': accountAdmin!,
      'receptionist': receptionist!,
      'venueID': venueID!,
      'venueName': venueName!,
      'streetAddress': streetAddress!,
      'townCity': townCity!,
      'postCode': postCode!,
      'venueDescription': venueDescription!,
      'venueBookingLink': venueBookingLink!,
      'website': website!,
      'venuePhoneNumber': venuePhoneNumber!,
      'logo': logo!,
      'images': images!,
      'coverURL': coverURL!,
      'paused': paused!,
      'approved': approved!,
      'foodTypes': foodTypes!,
      'otherFoodType':otherFoodType!,
      'monday': monday!.toMap(),
      'tuesday': tuesday!.toMap(),
      'wednesday': wednesday!.toMap(),
      'thursday': thursday!.toMap(),
      'friday': friday!.toMap(),
      'saturday': saturday!.toMap(),
      'sunday': sunday!.toMap(),
      'venueType': venueType!,

      //economy
      'lepRestricted': lepRestricted!,
      'localAuthRestricted': localAuthRestricted!,
      'wardRestricted': wardRestricted!,
      'venueRestricted': venueRestricted!,
      'bidRestricted': bidRestricted!,

      //Memberships and Accreditations
     'membershipLogo': membershipLogo!,
     'membershipURL': membershipURL!,

      // sustainability
      'venueImpactStatus': venueImpactStatus!,

      'sourceLocally': sourceLocally!,
      'cleanEnergy': cleanEnergy!,
      'singleUsePlastic': singleUsePlastic!,
      'sustainableFish': sustainableFish!,
      'sustainableMeat': sustainableMeat!,
      'plantBasedOptions': plantBasedOptions!,
      'sustainableCleaning':sustainableCleaning!,

      'foodWaste': foodWaste!,
      'averageCarbonPerMeal': averageCarbonPerMeal!,
      'venueCarbonFootprint':venueCarbonFootprint!,

      'sustainabilityRating': sustainabilityRating!,

      // equality diversity and inclusion
      'dogFriendly': dogFriendly!,
      'wheelChairAccess': wheelChairAccess!,
      'disabledToilet': disabledToilet!,
      'dietaryPrefBool': dietaryPrefBool!,
      'intolerances': intolerances!,
      'allergies': allergies!,
      'lgbtq': lgbtq!,
      'inclusiveToilets': inclusiveToilets!,
      'noDisabledEmployees': noDisabledEmployees!,
      'noEmployees': noEmployees!,
      'inclusiveRating': inclusiveRating!,


      // marketing
      'preTheatreDining': preTheatreDining!,
      'facebook': facebook!,
      'instagram': instagram!,
      'twitter': twitter!,
      'linkedin': linkedin!,
      'averageRating': averageRating!,
      'totalRatingsCount': totalRatingsCount!,

      //covid
     'takeaway': takeaway!,

      //diets
      'vegan': vegan!,
      'vegetarian': vegetarian!,
      'dairyFree': dairyFree!,
      'halal': halal!,
      'ketogenic': ketogenic!,
      'paleo': paleo!,

      //recommendations
      'recommendationIDs': recommendationIDs!,
    };
  }

  static Venue? fromMap(Map<String, dynamic> data) {}
}

class Days {
  num? open;
  num? close;
  bool? isOpen;

  Days({this.open, this.close, this.isOpen});

  factory Days.fromDocument(Map doc) {
    try {
      return Days(
        open: doc['open'] ?? '',
        close: doc['close'] ?? '',
        isOpen: doc['isOpen'] ?? true,
      );
    } catch (e) {
      print('#########  Days  #########');
      print(e);
      return null!;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'open': open,
      'close': close,
      'isOpen': isOpen,
    };
  }
}


