import 'package:cloud_firestore/cloud_firestore.dart';

class Projects {
  String? beneficiaryBusinessProfileID;
  String? beneficiarySVProfileName;
  String? businessProfileID;
  String? donatorSVProfileName;
  List? frameworkIDs;
  String? frameworkID;
  String? projectType;
  num? noMemberships;
  String? projectID;
  String? projectName;
  //List? recipientUserIDs;
  num? remainingMemberships;
  num? totalImpact;
  Timestamp? creationDate;
  Timestamp? projectStartDate;
  Timestamp? projectEndDate;
  String? summary;
  String? logo;
  String? region;
  String? promocode;
  num? maxClaimsPerUser;


  Projects({
    this.beneficiaryBusinessProfileID,
    this.beneficiarySVProfileName,
    this.businessProfileID,
    this.donatorSVProfileName,
    this.creationDate,
    this.frameworkIDs,
    this.frameworkID,
    this.projectType,
    this.noMemberships,
    this.projectID,
    this.projectName,
    //this.recipientUserIDs,
    this.remainingMemberships,
    this.totalImpact,
    this.projectStartDate,
    this.projectEndDate,
    this.summary,
    this.logo,
    this.region,
    this.promocode,
    this.maxClaimsPerUser,
  });

  factory Projects.fromDocument(Map<String, dynamic> doc) {
    return Projects(
      beneficiaryBusinessProfileID: doc['beneficiaryBusinessProfileID'] ?? '',
      beneficiarySVProfileName: doc['beneficiarySVProfileName'] ?? '',
      businessProfileID: doc['businessProfileID'] ?? '',
      donatorSVProfileName: doc['donatorSVProfileName'] ?? '',
      frameworkIDs: doc['frameworkIDs'] ?? [],
      frameworkID: doc['frameworkID'] ?? '',
      projectType: doc['projectType'] ?? '',
      noMemberships: doc['noMemberships'] ?? 0,
      projectName: doc['projectName'] ?? '',
      projectID: doc['projectID'] ?? '',
      //recipientUserIDs: doc['recipientUserIDs'] ?? List,
      remainingMemberships: doc['remainingMemberships'] ?? 0,
      totalImpact: doc['totalImpact'] ?? 0,
      projectStartDate: doc['projectStartDate'] ?? doc['projectCreationDate'] ?? Timestamp.fromDate(DateTime(2024, 1, 1)),
      creationDate: doc['creationDate'] ?? doc['creationDate'] ?? Timestamp.fromDate(DateTime(2024, 1, 1)),
      summary: doc['summary'] ?? '',
      logo: doc['logo'] ?? '',
      region: doc['region'] ?? '',
      promocode: doc['promocode'] ?? '',
      maxClaimsPerUser: doc['maxClaimsPerUser'] ?? 0,
    );
    try {
      return Projects(
        beneficiaryBusinessProfileID: doc['beneficiaryBusinessProfileID'] ?? '',
        beneficiarySVProfileName: doc['beneficiarySVProfileName'] ?? '',
        businessProfileID: doc['businessProfileID'] ?? '',
        donatorSVProfileName: doc['donatorSVProfileName'] ?? '',
        frameworkIDs: doc['frameworkIDs'] ?? [],
        frameworkID: doc['frameworkID'] ?? '',
        projectType: doc['projectType'] ?? '',
        noMemberships: doc['noMemberships'] ?? 0,
        projectName: doc['projectName'] ?? '',
        projectID: doc['projectID'] ?? '',
        //recipientUserIDs: doc['recipientUserIDs'] ?? List,
        remainingMemberships: doc['remainingMemberships'] ?? 0,
        totalImpact: doc['totalImpact'] ?? 0,
        projectStartDate: doc['projectStartDate'] ?? doc['projectCreationDate'] ?? Timestamp.fromDate(DateTime(2024, 1, 1)),
        projectEndDate: doc['projectEndDate'] ?? doc['projectCreationDate'] ?? Timestamp.fromDate(DateTime(2024, 1, 1)),
        creationDate: doc['creationDate'] ?? doc['creationDate'] ?? Timestamp.fromDate(DateTime(2024, 1, 1)),
        summary: doc['summary'] ?? '',
        logo: doc['logo'] ?? '',
        region: doc['region'] ?? '',
        promocode: doc['promocode'] ?? '',
        maxClaimsPerUser: doc['maxClaimsPerUser'] ?? 0,

      );
    } catch (e) {
      print(e);
      return null!;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'beneficiaryBusinessProfileID': beneficiaryBusinessProfileID,
      'beneficiarySVProfileName':beneficiarySVProfileName,
      'businessProfileID':businessProfileID,
      'donatorSVProfileName':donatorSVProfileName,
      'frameworkIDs':frameworkIDs,
      'frameworkID': frameworkID,
      'projectType':projectType,
      'noMemberships':noMemberships,
      'projectID':projectID,
      'projectName':projectName,
      //'recipientUserIDs':recipientUserIDs,
      'remainingMemberships':remainingMemberships,
      'totalImpact':totalImpact,
      'projectStartDate':projectStartDate,
      'projectEndDate': projectEndDate,
      'creationDate': creationDate,
      'summary': summary,
      'logo': logo,
      'region': region,
      'promocode': promocode,
      'maxClaimsPerUser': maxClaimsPerUser,
    };
  }
}