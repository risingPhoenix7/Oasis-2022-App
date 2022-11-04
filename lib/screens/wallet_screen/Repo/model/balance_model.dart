import 'package:json_annotation/json_annotation.dart';

part 'balance_model.g.dart';

@JsonSerializable()
class BalanceModel {
  BalanceModel({
    required this.data,
  });

  BalanceData? data;

  factory BalanceModel.fromJson(Map<String, dynamic> json) =>
      _$BalanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$BalanceModelToJson(this);
}

@JsonSerializable()
class BalanceData {
  BalanceData(
      {required this.cash,
      required this.pg,
      required this.swd,
      required this.transfers});

  int? cash;
  int? pg;
  int? swd;
  int? transfers;

  factory BalanceData.fromJson(Map<String, dynamic> json) =>
      _$BalanceDataFromJson(json);
}
