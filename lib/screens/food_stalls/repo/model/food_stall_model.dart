import 'package:json_annotation/json_annotation.dart';

part 'food_stall_model.g.dart';

@JsonSerializable()
class FoodStall {
  String name;
  String image_url;
  int id;
  bool closed;
  int min_price;
  int max_price;
  String description;
  String tags;
  List<MenuItem> menu;

  FoodStall(
      {required this.name,
      required this.image_url,
      required this.id,
      required this.closed,
      required this.description,
      required this.max_price,
      required this.min_price,
      required this.tags,
      required this.menu});

  factory FoodStall.fromJson(Map<String, dynamic> json) =>
      _$FoodStallFromJson(json);

  Map<String, dynamic> toJson() => _$FoodStallToJson(this);
}

@JsonSerializable()
class MenuItem {
  int price;
  String name;
  bool is_veg;
  String description;
  bool is_available;
  int id;
  int vendor_id;
  bool is_combo;

  MenuItem(
      {required this.name,
      required this.description,
      required this.id,
      required this.is_available,
      required this.price,
      required this.is_combo,
      required this.is_veg,
      required this.vendor_id});

  factory MenuItem.fromJson(Map<String, dynamic> json) =>
      _$MenuItemFromJson(json);

  Map<String, dynamic> toJson() => _$MenuItemToJson(this);
}
