class FoodStallInCartScreen {
  String foodStall;
  List<MenuItemInCartScreen> menuList;

  FoodStallInCartScreen({required this.foodStall, required this.menuList});
}

class MenuItemInCartScreen {
  String menuItemName;
  String foodStallName;
  int menuItemQuantity;
  int menuItemId;
  int menuItemPrice;

  MenuItemInCartScreen(
      {required this.menuItemId,
      required this.menuItemName,
      required this.menuItemPrice,
      required this.foodStallName,
      required this.menuItemQuantity});
}
