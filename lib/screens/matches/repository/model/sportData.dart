import 'package:json_annotation/json_annotation.dart';

part 'sportData.g.dart';

@JsonSerializable()
class SportsData {
  SportsData({
    this.id,
    this.name,
    this.layout_number,
  });

  int? id;
  String? name;
  int? layout_number;

  factory SportsData.fromJson(Map<String, dynamic> json) =>
      _$SportsDataFromJson(json);
}
