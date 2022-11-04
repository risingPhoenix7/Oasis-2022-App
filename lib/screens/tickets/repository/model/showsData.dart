import 'package:json_annotation/json_annotation.dart';

part 'showsData.g.dart';

class ShowsResult {
  static AllShowsData? allShowsData = AllShowsData([], []);
  static String? error;
}

@JsonSerializable()
class AllShowsData {
  AllShowsData(this.shows, this.combos);

  List<TicketData>? shows = [];
  List<CombosData>? combos = [];

  factory AllShowsData.fromJson(Map<String, dynamic> json) =>
      _$AllShowsDataFromJson(json);
}

@JsonSerializable()
class TicketData {
  int? id;
  double? price;
  String? name;
  String? timestamp;
  bool? allow_bitsians, allow_participants, tickets_available;

  TicketData({
    this.id,
    this.price,
    this.timestamp,
    this.name,
    this.allow_participants,
    this.allow_bitsians,
    this.tickets_available,
  });

  factory TicketData.fromJson(Map<String, dynamic> json) =>
      _$TicketDataFromJson(json);
}

@JsonSerializable()
class CombosData {
  int? id;
  double? price;
  String? name;
  bool? allow_bitsians, allow_participants;
  List<Shows>? shows;

  CombosData({
    this.id,
    this.price,
    this.name,
    this.allow_participants,
    this.allow_bitsians,
    this.shows,
  });

  factory CombosData.fromJson(Map<String, dynamic> json) =>
      _$CombosDataFromJson(json);
}

@JsonSerializable()
class Shows {
  int? id;
  String? name;

  Shows({
    this.id,
    this.name,
  });

  factory Shows.fromJson(Map<String, dynamic> json) => _$ShowsFromJson(json);
}
