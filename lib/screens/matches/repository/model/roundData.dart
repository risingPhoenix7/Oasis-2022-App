import 'package:json_annotation/json_annotation.dart';

part 'roundData.g.dart';

@JsonSerializable()
class RoundData {
  RoundData({
    this.id,
    this.venue_name,
    this.round_name,
    this.round_type,
    this.gender,
    this.is_score,
    this.sport_name,
    this.timestamp,
    this.score1,
    this.score2,
    this.team1_college_name,
    this.team2_college_name,
    this.team3_college_name,
    this.team4_college_name,
    this.team5_college_name,
    this.team6_college_name,
    this.team7_college_name,
    this.team8_college_name,
    this.part1,
    this.part2,
    this.part3,
    this.part4,
    this.part5,
    this.part6,
    this.part7,
    this.part8,
    this.winner1,
    this.sport_id,
    this.winner2,
    this.winner3,
  });

  int? id;
  String? venue_name;
  String? round_name;
  String? round_type;
  String? gender;
  String? is_score;
  String? sport_name;
  int? sport_id;
  String? timestamp;
  var score1; // if isScore is off this will become string, else int
  var score2;
  String? team1_college_name;
  String? team2_college_name;
  String? team3_college_name;
  String? team4_college_name;
  String? team5_college_name;
  String? team6_college_name;
  String? team7_college_name;
  String? team8_college_name;
  String? part1;
  String? part2;
  String? part3;
  String? part4;
  String? part5;
  String? part6;
  String? part7;
  String? part8;
  String? winner1;
  String? winner2;
  String? winner3;

  factory RoundData.fromJson(Map<String, dynamic> json) =>
      _$RoundDataFromJson(json);
}
