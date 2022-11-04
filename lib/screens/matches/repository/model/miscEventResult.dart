// To parse this JSON data, do
//
//     final miscEvent = miscEventFromJson(jsonString);
import 'package:json_annotation/json_annotation.dart';

part 'miscEventResult.g.dart';

class MiscEventResult {
  static List<MiscEventData>? miscEventList;
  static String? error;
}

@JsonSerializable()
class MiscEventData {
  MiscEventData(
      {this.id,
      this.day,
      this.description,
      this.name,
      this.organiser,
      this.timestamp,
      this.venue_name});

  int? id;
  int? day;
  String? description;
  String? name;
  String? organiser;
  String? timestamp;
  String? venue_name;

  factory MiscEventData.fromJson(Map<String, dynamic> json) =>
      _$MiscEventDataFromJson(json);
}
