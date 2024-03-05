class PostCode {
  final String? bid;
  final String? cty;
  final num? lat;
  final String? laua;
  final String? lep1;
  final num? long;
  final String? ward;

  PostCode({
    this.bid,
    this.cty,
    this.lat,
    this.laua,
    this.lep1,
    this.long,
    this.ward,
  });

  factory PostCode.fromDocument(Map<String, dynamic> doc) {
    try {
      return PostCode(
        bid: doc['bid'] ?? '',
        cty: doc['cty'] ?? '',
        lat: doc['lat'] ?? 0,
        laua: doc['laua'] ?? '',
        lep1: doc['lep1'] ?? '',
        long: doc['long'] ?? 0,
        ward: doc['ward'] ?? '',
      );
    } catch (e) {
      print('****** POST CODE MODEL ******');
      print(e);
      return null!;
    }
  }

  Map<String, Object> toJson() {
    return {
      'bid': bid!,
      'cty': cty!,
      'lat': lat!,
      'laua': laua!,
      'lep1': lep1!,
      'long': long!,
      'ward': ward!,
    };
  }
}
