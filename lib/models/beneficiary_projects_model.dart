import 'package:cloud_firestore/cloud_firestore.dart';

class BeneficiaryProjects {
  String? beneficiaryProfileID;
  String? sponsorProfileID;
  List? frameworkIDs;
  String? frameworkID;
  String? projectType;
  num? noMemberships;
  String? beneficiaryProjectID;
  String? beneficiaryProjectName;
  //List? recipientUserIDs;
  num? remainingMemberships;
  num? totalImpact;
  Timestamp? creationDate;
  Timestamp? projectStartDate;
  Timestamp? projectEndDate;
  String? summary;
  String? logo;
  List? localAuths;
  List? sponsors;


  BeneficiaryProjects({
    this.beneficiaryProfileID,
    this.sponsorProfileID,
    this.creationDate,
    this.frameworkIDs,
    this.frameworkID,
    this.projectType,
    this.noMemberships,
    this.beneficiaryProjectID,
    this.beneficiaryProjectName,
    //this.recipientUserIDs,
    this.remainingMemberships,
    this.totalImpact,
    this.projectStartDate,
    this.projectEndDate,
    this.summary,
    this.logo,
    this.localAuths,
    this.sponsors,

  });

  factory BeneficiaryProjects.fromDocument(Map<String, dynamic> doc) {
    return BeneficiaryProjects(
      beneficiaryProfileID: doc['beneficiaryProfileID'] ?? '',
      sponsorProfileID: doc['sponsorProfileID'] ?? '',
      frameworkIDs: doc['frameworkIDs'] ?? [],
      frameworkID: doc['frameworkID'] ?? '',
      projectType: doc['projectType'] ?? '',
      noMemberships: doc['noMemberships'] ?? 0,
      beneficiaryProjectName: doc['beneficiaryProjectName'] ?? '',
      beneficiaryProjectID: doc['beneficiaryProjectID'] ?? '',
      //recipientUserIDs: doc['recipientUserIDs'] ?? List,
      remainingMemberships: doc['remainingMemberships'] ?? 0,
      totalImpact: doc['totalImpact'] ?? 0,
      projectStartDate: doc['projectStartDate'] ?? doc['projectCreationDate'] ?? Timestamp.fromDate(DateTime(2024, 1, 1)),
      creationDate: doc['creationDate'] ?? doc['creationDate'] ?? Timestamp.fromDate(DateTime(2024, 1, 1)),
      summary: doc['summary'] ?? '',
      logo: doc['logo'] ?? '',
      localAuths: doc['localAuths'] ?? [],
      sponsors: doc['sponsors'] ?? [],

    );
    try {
      return BeneficiaryProjects(
        beneficiaryProfileID: doc['beneficiaryProfileID'] ?? '',
        sponsorProfileID: doc['sponsorProfileID'] ?? '',
        frameworkIDs: doc['frameworkIDs'] ?? [],
        frameworkID: doc['frameworkID'] ?? '',
        projectType: doc['projectType'] ?? '',
        noMemberships: doc['noMemberships'] ?? 0,
        beneficiaryProjectName: doc['beneficiaryProjectName'] ?? '',
        beneficiaryProjectID: doc['beneficiaryProjectID'] ?? '',
        //recipientUserIDs: doc['recipientUserIDs'] ?? List,
        remainingMemberships: doc['remainingMemberships'] ?? 0,
        totalImpact: doc['totalImpact'] ?? 0,
        projectStartDate: doc['projectStartDate'] ?? doc['projectCreationDate'] ?? Timestamp.fromDate(DateTime(2024, 1, 1)),
        creationDate: doc['creationDate'] ?? doc['creationDate'] ?? Timestamp.fromDate(DateTime(2024, 1, 1)),
        summary: doc['summary'] ?? '',
        logo: doc['logo'] ?? '',
        localAuths: doc['localAuths'] ?? [],
        sponsors: doc['sponsors'] ?? [],

      );
    } catch (e) {
      print(e);
      return null!;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'beneficiaryProfileID': beneficiaryProfileID,
      'sponsorProfileID':sponsorProfileID,
      'frameworkIDs':frameworkIDs,
      'frameworkID': frameworkID,
      'projectType':projectType,
      'noMemberships':noMemberships,
      'beneficiaryProjectID':beneficiaryProjectID,
      'benficiaryProjectName':beneficiaryProjectName,
      //'recipientUserIDs':recipientUserIDs,
      'remainingMemberships':remainingMemberships,
      'totalImpact':totalImpact,
      'projectStartDate':projectStartDate,
      'projectEndDate': projectEndDate,
      'creationDate': creationDate,
      'summary': summary,
      'logo': logo,
      'localAuths': localAuths,
      'sponsors': sponsors,
    };
  }
}