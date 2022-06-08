

import 'package:equatable/equatable.dart';
import 'package:magang/constant/common/constants.dart';
import 'package:magang/modules/models/menu_model.dart';

class DetailOrder extends Equatable {
  MenuData menu;
  int quantity;
  String note;
  MenuVariant? level;
  List<MenuVariant>? toppings;

  DetailOrder({
    required this.menu,
    required this.quantity,
    required this.note,
    required this.level,
    required this.toppings,
  });

  /// Getter untuk makanan
  bool get isFood => menu.kategori == foodCategory;

  /// Getter untuk minuman
  bool get isDrink => menu.kategori == drinkCategory;

  /// Total level price
  int get totalLevelPrice {
    if (level == null) {
      return 0;
    } else {
      return level!.harga;
    }
  }

  /// Total topping price
  int get totalToppingsPrice {
    if (toppings == null) {
      return 0;
    } else {
      return toppings!.fold<int>(0, (total, topping) => total + topping.harga);
    }
  }

  /// Price per item with level or topping
  int get price {
    return menu.harga + totalLevelPrice + totalToppingsPrice;
  }

  /// Total price = price * quantity
  int get totalPrice {
    return price * quantity;
  }

  @override
  List<Object?> get props => [menu.id_menu];
}
