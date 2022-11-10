// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'miscEventResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MiscEventCategory _$MiscEventCategoryFromJson(Map<String, dynamic> json) =>
    MiscEventCategory(
      category_name: json['category_name'] as String?,
      events: (json['events'] as List<dynamic>?)
          ?.map((e) => MiscEventData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MiscEventCategoryToJson(MiscEventCategory instance) =>
    <String, dynamic>{
      'category_name': instance.category_name,
      'events': instance.events,
    };

MiscEventData _$MiscEventDataFromJson(Map<String, dynamic> json) =>
    MiscEventData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      about: json['about'] as String?,
      organiser: json['organiser'] as String?,
      time: json['time'] as String?,
      date_time: json['date_time'] as String?,
      venue_name: json['venue_name'] as String?,
    );

Map<String, dynamic> _$MiscEventDataToJson(MiscEventData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'organiser': instance.organiser,
      'time': instance.time,
      'date_time': instance.date_time,
      'venue_name': instance.venue_name,
      'about': instance.about,
    };
