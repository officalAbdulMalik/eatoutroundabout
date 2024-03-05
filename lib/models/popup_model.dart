class PopUp {
  //popup details
  final String? accountID;
  final String? accountAdmin;
  final String? popupID;
  final String? popupName;
  final String? popupDescription;
  final String? popupPhoneNumber;
  final String? website;
  final String? logo;
  final List? images;
  final String? coverURL;
  bool? paused;
  final bool? approved;
  final List? foodTypes;
  final String? otherFoodType;
  final List? eventIDs;

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
  final String? popupRestricted;
  final String? bidRestricted;

  // sustainability
  final String? popupImpactStatus;
  final bool? sourceLocally;
  final num? foodWaste;
  final bool? cleanEnergy;
  final bool? singleUsePlastic;
  final bool? sustainableFish;
  final bool? sustainableMeat;
  final bool? plantBasedOptions;
  final num? averageCarbonPerMeal;
  final num? popupCarbonFootprint;
  final bool? sustainableCleaning;
  final num? sustainabilityRating;

  //Partner Memberships
 final List? partnerLogos;

  // equality diversity and inclusion
  final bool? preTheatreDining;
  final bool? dietaryPrefBool;
  final List? intolerances;
  final List? allergies;
  final bool? lgbtq;
  final num? noEmployees;
  final num? noDisabledEmployees;
  final num? inclusiveRating;

  // marketing

  final String? facebook;
  final String? instagram;
  final String? twitter;
  final String? linkedin;

  // covid

  final bool? takeaway;

  // recommendations
  final List? recommendationIDs;

  PopUp({
    //popup details
    this.accountID,
    this.accountAdmin,
    this.popupID,
    this.popupName,
    this.popupDescription,
    this.website,
    this.popupPhoneNumber,
    this.logo,
    this.images,
    this.coverURL,
    this.paused,
    this.approved,
    this.foodTypes,
    this.otherFoodType,
    this.eventIDs,

    // diets
    this.vegan,
    this.vegetarian,
    this.halal,
    this.paleo,
    this.ketogenic,
    this.dairyFree,

    //Partner Memberships
   this.partnerLogos,

    //economy
    this.lepRestricted,
    this.localAuthRestricted,
    this.wardRestricted,
    this.popupRestricted,
    this.bidRestricted,

    // sustainability
    this.popupImpactStatus,
    this.sourceLocally,
    this.foodWaste,
    this.cleanEnergy,
    this.singleUsePlastic,
    this.sustainableFish,
    this.sustainableMeat,
    this.plantBasedOptions,
    this.averageCarbonPerMeal,
    this.popupCarbonFootprint,
    this.sustainableCleaning,
    this.sustainabilityRating,

// equality diversity and inclusion
    this.dietaryPrefBool,
    this.intolerances,
    this.allergies,
    this.lgbtq,
    this.noDisabledEmployees,
    this.noEmployees,
    this.inclusiveRating,

    // marketing
    this.preTheatreDining,
    this.facebook,
    this.instagram,
    this.twitter,
    this.linkedin,

    //covid
    this.takeaway,

    // recommendations
    this.recommendationIDs
  });

  factory PopUp.fromDocument(Map<String, dynamic> doc) {
    return PopUp(
      accountID: doc['accountID'] ?? ' ',
      accountAdmin: doc['accountAdmin'] ?? '',
      popupID: doc['popupID'] ?? '',
      popupName: doc['popupName'] ?? '',
      popupDescription: doc['popupDescription'] ?? '',
      website: doc['website'] ?? '',
      popupPhoneNumber: doc['popupPhoneNumber'] ?? '',
      logo: doc['logo'] ?? '',
      images: doc['images'] ?? doc['coverURL'] ?? ''??[],
      coverURL: doc['coverURL'] ?? '',
      paused: doc['paused'] ?? false,
      approved: doc['approved'] ?? false,
      foodTypes: doc['foodTypes'] ?? [],
      eventIDs: doc['eventIDs'] ?? [],

      otherFoodType: doc['otherFoodType'] ?? 'other',

      //Diets
      vegan: doc['vegan'] ?? false,
      vegetarian: doc['vegetarian'] ?? false,
      halal: doc['halal'] ?? false,
      paleo: doc['paleo'] ?? false,
      ketogenic: doc['ketogenic'] ?? false,
      dairyFree: doc['dairyFree'] ?? false,

      //Partner Memberships
      partnerLogos: doc['partnerLogos'] ?? [],

      //economy
      lepRestricted: doc['lepRestricted'] ?? '',
      localAuthRestricted: doc['localAuthRestricted'] ?? '',
      wardRestricted: doc['wardRestricted'] ?? '',
      popupRestricted: doc['popupRestricted'] ?? '',
      bidRestricted: doc['bidRestricted'] ?? '',

      // sustainability

      popupImpactStatus: doc['popupImpactStatus'] ?? 'none',
      sourceLocally: doc['sourceLocally'] ?? 0,
      foodWaste: doc['foodWaste'] ?? 0,
      cleanEnergy: doc['cleanEnergy'] ?? false,
      singleUsePlastic: doc['singleUsePlastic'] ?? false,
      sustainableFish: doc['sustainableFish'] ?? false,
      sustainableMeat: doc['sustainableMeat'] ?? false,
      plantBasedOptions: doc['plantBasedOptions'] ?? false,
      averageCarbonPerMeal: doc['averageCarbonPerMeal'] ?? 0,
      popupCarbonFootprint: doc['popupCarbonFootprint'] ?? 0,
      sustainableCleaning: doc['sustainableCleaning'] ?? 0,
      sustainabilityRating: doc['sustainabilityRating'] ?? 0,

// equality diversity and inclusion
      dietaryPrefBool: doc['dietaryPrefBool'] ?? false,
      intolerances: doc['intolerances'] ?? [],
      allergies: doc['allergies'] ?? [],
      lgbtq: doc['lgbtq'] ?? true,
      noEmployees: doc['noEmployees'] ?? 0,
      noDisabledEmployees: doc['noDisabledEmployees'] ?? 0,
      inclusiveRating: doc['inclusiveRating'] ?? 0,

      // marketing
      preTheatreDining: doc['preTheatreDining'] ?? false,
      facebook: doc['facebook'] ?? '',
      instagram: doc['instagram'] ?? '',
      twitter: doc['twitter'] ?? '',
      linkedin: doc['linkedin'] ?? '',

      //covid
    takeaway: doc['takeaway'] ?? false,

        //recommendations
      recommendationIDs: doc['recommendationIDs'] ?? [],

    );
    try {
      return PopUp(
        accountID: doc['accountID'] ?? ' ',
        accountAdmin: doc['accountAdmin'] ?? '',
        popupID: doc['popupID'] ?? '',
        popupName: doc['popupName'] ?? '',
        popupDescription: doc['popupDescription'] ?? '',
        website: doc['website'] ?? '',
        popupPhoneNumber: doc['popupPhoneNumber'] ?? '',
        logo: doc['logo'] ?? '',
        images: doc['images'] ?? doc['coverURL'] ?? ''??[],
        coverURL: doc['coverURL'] ?? '',
        paused: doc['paused'] ?? false,
        approved: doc['approved'] ?? false,
        foodTypes: doc['foodTypes'] ?? [],
        eventIDs: doc['eventIDs'] ?? [],

        otherFoodType: doc['otherFoodType'] ?? 'other',

        //Diets
        vegan: doc['vegan'] ?? false,
        vegetarian: doc['vegetarian'] ?? false,
        halal: doc['halal'] ?? false,
        paleo: doc['paleo'] ?? false,
        ketogenic: doc['ketogenic'] ?? false,
        dairyFree: doc['dairyFree'] ?? false,

        //Partner Memberships
        partnerLogos: doc['yorkshireMark'] ?? [],

        //economy
        lepRestricted: doc['lepRestricted'] ?? '',
        localAuthRestricted: doc['localAuthRestricted'] ?? '',
        wardRestricted: doc['wardRestricted'] ?? '',
        popupRestricted: doc['popupRestricted'] ?? '',
        bidRestricted: doc['bidRestricted'] ?? '',

        // sustainability

        popupImpactStatus: doc['popupImpactStatus'] ?? 'none',
        sourceLocally: doc['sourceLocally'] ?? 0,
        foodWaste: doc['foodWaste'] ?? 0,
        cleanEnergy: doc['cleanEnergy'] ?? false,
        singleUsePlastic: doc['singleUsePlastic'] ?? false,
        sustainableFish: doc['sustainableFish'] ?? false,
        sustainableMeat: doc['sustainableMeat'] ?? false,
        plantBasedOptions: doc['plantBasedOptions'] ?? false,
        averageCarbonPerMeal: doc['averageCarbonPerMeal'] ?? 0,
        popupCarbonFootprint: doc['popupCarbonFootprint'] ?? 0,
        sustainableCleaning: doc['sustainableCleaning'] ?? 0,
        sustainabilityRating: doc['sustainabilityRating'] ?? 0,

// equality diversity and inclusion
        dietaryPrefBool: doc['dietaryPrefBool'] ?? false,
        intolerances: doc['intolerances'] ?? [],
        allergies: doc['allergies'] ?? [],
        lgbtq: doc['lgbtq'] ?? true,
        noEmployees: doc['noEmployees'] ?? 0,
        noDisabledEmployees: doc['noDisabledEmployees'] ?? 0,
        inclusiveRating: doc['inclusiveRating'] ?? 0,

        // marketing
        preTheatreDining: doc['preTheatreDining'] ?? false,
        facebook: doc['facebook'] ?? '',
        instagram: doc['instagram'] ?? '',
        twitter: doc['twitter'] ?? '',
        linkedin: doc['linkedin'] ?? '',

        //covid
        takeaway: doc['takeaway'] ?? false,

        //recommendations
        recommendationIDs: doc['recommendationIDs'] ?? [],

      );
    } catch (e) {
      print('########## POPUP MODEL ###########');
      print(e);
      return null!;
    }
  }

  Map<String, Object> toJson() {
    return {
      //popup details
      'accountID': accountID!,
      'accountAdmin': accountAdmin!,
      'popupID': popupID!,
      'popupName': popupName!,
      'popupDescription': popupDescription!,
      'website': website!,
      'popupPhoneNumber': popupPhoneNumber!,
      'logo': logo!,
      'images': images!,
      'coverURL': coverURL!,
      'paused': paused!,
      'approved': approved!,
      'foodTypes': foodTypes!,
      'otherFoodType':otherFoodType!,
      'eventIDs': eventIDs!,

      //economy
      'lepRestricted': lepRestricted!,
      'localAuthRestricted': localAuthRestricted!,
      'wardRestricted': wardRestricted!,
      'popupRestricted': popupRestricted!,
      'bidRestricted': bidRestricted!,

      //Memberships and Accreditations
     'partnerLogos': partnerLogos!,

      // sustainability
      'popupImpactStatus': popupImpactStatus!,
      'sourceLocally': sourceLocally!,
      'foodWaste': foodWaste!,
      'cleanEnergy': cleanEnergy!,
      'singleUsePlastic': singleUsePlastic!,
      'sustainableFish': sustainableFish!,
      'sustainableMeat': sustainableMeat!,
      'plantBasedOptions': plantBasedOptions!,
      'averageCarbonPerMeal': averageCarbonPerMeal!,
      'popupCarbonFootprint':popupCarbonFootprint!,
      'sustainableCleaning':sustainableCleaning!,
      'sustainabilityRating': sustainabilityRating!,

      // equality diversity and inclusion
      'dietaryPrefBool': dietaryPrefBool!,
      'intolerances': intolerances!,
      'allergies': allergies!,
      'lgbtq': lgbtq!,
      'noDisabledEmployees': noDisabledEmployees!,
      'noEmployees': noEmployees!,
      'inclusiveRating': inclusiveRating!,

      // marketing
      'preTheatreDining': preTheatreDining!,
      'facebook': facebook!,
      'instagram': instagram!,
      'twitter': twitter!,
      'linkedin': linkedin!,

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
}








