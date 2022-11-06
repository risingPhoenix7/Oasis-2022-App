// To parse this JSON data, do
//
//     final miscEvent = miscEventFromJson(jsonString);
import 'package:json_annotation/json_annotation.dart';

part 'miscEventResult.g.dart';

@JsonSerializable()
class MiscEventCategory {
  MiscEventCategory(
      {
        this.category_name,
        this.events,
       });

  String? category_name;
  List<MiscEventData>? events;

  factory MiscEventCategory.fromJson(Map<String, dynamic> json) =>
      _$MiscEventCategoryFromJson(json);
}

@JsonSerializable()
class MiscEventData {
  MiscEventData(
      {this.id,
      this.name,
      this.about,
      this.organiser,
      this.time,//like TBA will be same as backend puts it
      this.date_time,// to get date
      this.venue_name});

  int? id;
  String? name;
  String? organiser;
  String? time;
  String? date_time;
  String? venue_name;
  String? about;

  factory MiscEventData.fromJson(Map<String, dynamic> json) =>
      _$MiscEventDataFromJson(json);
}
