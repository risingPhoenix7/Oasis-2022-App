// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'miscEventResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MiscEventData _$MiscEventDataFromJson(Map<String, dynamic> json) =>
    MiscEventData(
      id: json['id'] as int?,
      day: json['day'] as int?,
      description: json['description'] as String?,
      name: json['name'] as String?,
      organiser: json['organiser'] as String?,
      timestamp: json['timestamp'] as String?,
      venue_name: json['venue_name'] as String?,
    );

Map<String, dynamic> _$MiscEventDataToJson(MiscEventData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'day': instance.day,
      'description': instance.description,
      'name': instance.name,
      'organiser': instance.organiser,
      'timestamp': instance.timestamp,
      'venue_name': instance.venue_name,
    };
