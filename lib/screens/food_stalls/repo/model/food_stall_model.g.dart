// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_stall_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodStall _$FoodStallFromJson(Map<String, dynamic> json) => FoodStall(
      name: json['name'] as String,
      image_url: json['image_url'] as String,
      id: json['id'] as int,
      closed: json['closed'] as bool,
      description: json['description'] as String,
      max_price: json['max_price'] as int,
      min_price: json['min_price'] as int,
      tags: json['tags'] as String,
      menu: (json['menu'] as List<dynamic>)
          .map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FoodStallToJson(FoodStall instance) => <String, dynamic>{
      'name': instance.name,
      'image_url': instance.image_url,
      'id': instance.id,
      'closed': instance.closed,
      'min_price': instance.min_price,
      'max_price': instance.max_price,
      'description': instance.description,
      'tags': instance.tags,
      'menu': instance.menu,
    };

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) => MenuItem(
      name: json['name'] as String,
      description: json['description'] as String,
      id: json['id'] as int,
      is_available: json['is_available'] as bool,
      price: json['price'] as int,
      is_combo: json['is_combo'] as bool,
      is_veg: json['is_veg'] as bool,
      vendor_id: json['vendor_id'] as int,
    );

Map<String, dynamic> _$MenuItemToJson(MenuItem instance) => <String, dynamic>{
      'price': instance.price,
      'name': instance.name,
      'is_veg': instance.is_veg,
      'description': instance.description,
      'is_available': instance.is_available,
      'id': instance.id,
      'vendor_id': instance.vendor_id,
      'is_combo': instance.is_combo,
    };
