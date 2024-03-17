import 'package:update_cart/dummy_data/local_data.dart';
import 'package:update_cart/dummy_data/online_data.dart';
import 'package:update_cart/models/cart_item_model.dart';

class CartProvider {
  final List<CartItem> cartITems = List.from(localCartITems, growable: true);

  final onlinePlaces = placesList;

  final onlineProducts = productsList;

  num _total = 0;
  num get totalCartPrice {
    _total = 0;
    for (final item in cartITems) {
      _total += item.totalPrice;
    }
    return _total;
  }

  void updateCart() {
    //1- TODO: implement updateCart
    //2- ptint items after update
    //3- Display the changes, that were made on user cart, on home page.
    _printItemsAfterUpdate(cartITems);
  }

  _printItemsAfterUpdate(List<CartItem> localCartItems) {
    for (final item in localCartItems) {
      print('############ START of cartItem id: ${item.id} ##########');
      print('Place: ${item.place.title}');
      print('isActive: ${item.place.isActive}');
      print('Place image: ${item.place.placeImage}');
      print('Place shipping price: ${item.place.shippingPrice}');
      for (final product in item.products) {
        _printCartProduct(product);
      }
      print('CartItem total price: ${item.totalPrice}');
      print('############ END of cartItem id: ${item.id} ##########');
    }
    print("Total cart price: $totalCartPrice");
  }

  _printCartProduct(CartProduct product) {
    print('Product: ${product.title}');
    print('Product description: ${product.description}');
    print('Product image : ${product.image}');
    print('Product price: ${product.price}');
    print('Product min items: ${product.minItems}');
    print('Product available qty: ${product.availableQuantity}');
    print('Product selected quantity: ${product.selectedQuantity}');
    print('Product total price: ${product.totalPrice}');
    print('############ END of Product ${product.title} ##########');
  }
}
