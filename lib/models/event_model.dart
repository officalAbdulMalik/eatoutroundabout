import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String? accountID;
  final String? businessProfileID;
    final String? eventCode;
  final String? userID;
  final String? bookingLink;
  final String? facebookLink;
  final String? linkedInLink;
  final String? otherLink;
  final Timestamp? creationDate;
  final String? description;
  final List? attendeeUserIDs;
  final Timestamp? eventDateTimeFrom;
  final Timestamp? eventDateTimeTo;
  final String? eventID;
  final List? eventImages;
  final String? eventTitle;
  final String? eventType;
  final num? capacity;
  final num? pricePerHead;
  final bool? publicEvent;
  final String? summary;
  final String? category;
  final String? streetAddress;
  final String? townCity;
  final String? postCode;
  final String? eventBriteEventID;
  final String? eventBriteOrgID;
  final List? checkedInUserIDs;
  bool? privacyPolicy;
  bool? tnc;
  bool? approved;
  final String? buildingName;

  Event({
    this.accountID,
    this.businessProfileID,
        this.eventCode,
    this.userID,
    this.bookingLink,
    this.facebookLink,
    this.linkedInLink,
    this.otherLink,
    this.creationDate,
    this.description,
    this.attendeeUserIDs,
    this.eventDateTimeFrom,
    this.eventDateTimeTo,
    this.eventID,
    this.eventImages,
    this.eventTitle,
    this.eventType,
    this.capacity,
    this.pricePerHead,
    this.publicEvent,
    this.summary,
    this.category,
    this.streetAddress,
    this.townCity,
    this.postCode,
    this.eventBriteEventID,
    this.eventBriteOrgID,
    this.checkedInUserIDs,
    this.privacyPolicy,
    this.tnc,
    this.approved,
    this.buildingName,
  });

  factory Event.fromDocument(Map<String, dynamic> doc) {
      return Event(
        accountID: doc['accountID'] ?? '',
        businessProfileID: doc['businessProfileID'] ?? '',
        eventCode: doc['eventCode'] ?? '',
        userID: doc['userID'] ?? '',
        bookingLink: doc['bookingLink'] ?? '',
        facebookLink: doc['facebookLink'] ?? '',
        linkedInLink: doc['linkedInLink'] ?? '',
        otherLink: doc['otherLink'] ?? '',
        creationDate: doc['creationDate'] ?? Timestamp.now(),
        description: doc['description'] ?? '',
        attendeeUserIDs: doc['attendeeUserIDs'] ?? [],
        eventDateTimeFrom: doc['eventDateTimeFrom'] ?? Timestamp.now(),
        eventDateTimeTo: doc['eventDateTimeTo'] ?? Timestamp.now(),
        eventID: doc['eventID'] ?? '',
        eventImages: doc['eventImages'] ?? [''],
        eventTitle: doc['eventTitle'] ?? '',
        eventType: doc['eventType'] ?? '',
        capacity: doc['capacity'] ?? 0,
        pricePerHead: doc['pricePerHead'] ?? 0,
        publicEvent: doc['publicEvent'] ?? false,
        summary: doc['summary'] ?? '',
        category: doc['category'] ?? '',
        streetAddress: doc['streetAddress'] ?? '',
        townCity: doc['townCity'] ?? '',
        postCode: doc['postCode'] ?? '',
        eventBriteEventID: doc['eventBriteEventID']?? '',
        eventBriteOrgID: doc['eventBriteOrgID']?? '',
        checkedInUserIDs: doc['checkedInUserIDs']?? [],
        privacyPolicy: doc['privacyPolicy']?? true,
        tnc: doc['tnc']?? true,
        approved: doc['approved']?? false,
        buildingName: doc['buildingName'] ?? '',
      );
      try {
        return Event(
          accountID: doc['accountID'] ?? '',
          businessProfileID: doc['businessProfileID'] ?? '',
          eventCode: doc['eventCode'] ?? '',
          userID: doc['userID'] ?? '',
          bookingLink: doc['bookingLink'] ?? '',
          facebookLink: doc['facebookLink'] ?? '',
          linkedInLink: doc['linkedInLink'] ?? '',
          otherLink: doc['otherLink'] ?? '',
          creationDate: doc['creationDate'] ?? Timestamp.now(),
          description: doc['description'] ?? '',
          attendeeUserIDs: doc['attendeeUserIDs'] ?? [],
          eventDateTimeFrom: doc['eventDateTimeFrom'] ?? Timestamp.now(),
          eventDateTimeTo: doc['eventDateTimeTo'] ?? Timestamp.now(),
          eventID: doc['eventID'] ?? '',
          eventImages: doc['eventImages'] ?? [''],
          eventTitle: doc['eventTitle'] ?? '',
          eventType: doc['eventType'] ?? '',
          capacity: doc['capacity'] ?? 0,
          pricePerHead: doc['pricePerHead'] ?? 0,
          publicEvent: doc['publicEvent'] ?? false,
          summary: doc['summary'] ?? '',
          category: doc['category'] ?? '',
          streetAddress: doc['streetAddress'] ?? '',
          townCity: doc['townCity'] ?? '',
          postCode: doc['postCode'] ?? '',
          eventBriteEventID: doc['eventBriteEventID']?? '',
          eventBriteOrgID: doc['eventBriteOrgID']?? '',
          checkedInUserIDs: doc['checkedInUserIDs']?? [],
          privacyPolicy: doc['privacyPolicy']?? true,
          tnc: doc['tnc']?? true,
          approved: doc['approved']?? false,
          buildingName: doc['buildingName'] ?? '',
        );
      } catch (e) {
        print('****** EVENT MODEL ******');
        print(e);
        return null!;
      }
    }


  Map<String, Object> toJson() {
    return {
      'accountID': accountID!,
      'businessProfileID': businessProfileID!,
            'eventCode': eventCode!,
      'userID': userID!,
      'bookingLink': bookingLink!,
      'facebookLink': facebookLink!,
      'linkedInLink': linkedInLink!,
      'otherLink': otherLink!,
      'creationDate': creationDate!,
      'description': description!,
      'attendeeUserIDs': attendeeUserIDs!,
      'eventDateTimeFrom': eventDateTimeFrom!,
      'eventDateTimeTo': eventDateTimeTo!,
      'eventID': eventID!,
      'eventImages': eventImages!,
      'eventTitle': eventTitle!,
      'eventType': eventType!,
      'capacity': capacity!,
      'pricePerHead': pricePerHead!,
      'publicEvent': publicEvent!,
      'summary': summary!,
      'category': category!,
      'streetAddress': streetAddress!,
      'townCity': townCity!,
      'postCode': postCode!,
      'eventBriteEventID': eventBriteEventID!,
      'eventBriteOrgID': eventBriteOrgID!,
      'checkedInUserIDs': checkedInUserIDs!,
      'privacyPolicy': privacyPolicy!,
      'tnc': tnc!,
      'approved': approved!,
      'buildingName': buildingName!
    };
  }
}
