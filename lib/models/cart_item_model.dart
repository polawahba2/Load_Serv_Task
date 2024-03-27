import 'package:update_cart/models/place_model.dart';
import 'package:update_cart/models/product_model.dart';

class CartItem {
  int id;
  Place
      place; //! first i will check if thie place is still avalible and all its information is still ok.
  List<CartProduct>
      products; //! second i'll also check if every single cart product is still ok.
  num totalPrice;
  CartItem(
      {required this.id,
      required this.place,
      required this.products,
      this.totalPrice = 0});
  num calculateTotalAmount() {
    totalPrice = 0;
    for (final product in products) {
      totalPrice += product.totalPrice;
    }
    totalPrice += place.shippingPrice!;
    return totalPrice;
  }
}

class CartProduct extends Product {
  int selectedQuantity;
  num totalPrice;
  CartProduct({
    super.id,
    super.title,
    super.description,
    super.image,
    super.price,
    super.minItems,
    super.availableQuantity,
    this.selectedQuantity = 0,
    this.totalPrice = 0,
  });
  num? calculateProductTotalPrice() {
    totalPrice = (selectedQuantity * (price ?? 0));
    return totalPrice;
  }
}
