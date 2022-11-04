// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sportData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SportsData _$SportsDataFromJson(Map<String, dynamic> json) => SportsData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      layout_number: json['layout_number'] as int?,
    );

Map<String, dynamic> _$SportsDataToJson(SportsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'layout_number': instance.layout_number,
    };
