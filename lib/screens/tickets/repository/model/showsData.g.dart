// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'showsData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllShowsData _$AllShowsDataFromJson(Map<String, dynamic> json) => AllShowsData(
      (json['shows'] as List<dynamic>?)
          ?.map((e) => TicketData.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['combos'] as List<dynamic>?)
          ?.map((e) => CombosData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllShowsDataToJson(AllShowsData instance) =>
    <String, dynamic>{
      'shows': instance.shows,
      'combos': instance.combos,
    };

TicketData _$TicketDataFromJson(Map<String, dynamic> json) => TicketData(
      id: json['id'] as int?,
      price: (json['price'] as num?)?.toDouble(),
      timestamp: json['timestamp'] as String?,
      name: json['name'] as String?,
      allow_participants: json['allow_participants'] as bool?,
      allow_bitsians: json['allow_bitsians'] as bool?,
      tickets_available: json['tickets_available'] as bool?,
    );

Map<String, dynamic> _$TicketDataToJson(TicketData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'name': instance.name,
      'timestamp': instance.timestamp,
      'allow_bitsians': instance.allow_bitsians,
      'allow_participants': instance.allow_participants,
      'tickets_available': instance.tickets_available,
    };

CombosData _$CombosDataFromJson(Map<String, dynamic> json) => CombosData(
      id: json['id'] as int?,
      price: (json['price'] as num?)?.toDouble(),
      name: json['name'] as String?,
      allow_participants: json['allow_participants'] as bool?,
      allow_bitsians: json['allow_bitsians'] as bool?,
      shows: (json['shows'] as List<dynamic>?)
          ?.map((e) => Shows.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CombosDataToJson(CombosData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'name': instance.name,
      'allow_bitsians': instance.allow_bitsians,
      'allow_participants': instance.allow_participants,
      'shows': instance.shows,
    };

Shows _$ShowsFromJson(Map<String, dynamic> json) => Shows(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ShowsToJson(Shows instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
