// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:update_cart/dummy_data/local_data.dart';
import 'package:update_cart/dummy_data/online_data.dart';
import 'package:update_cart/models/cart_item_model.dart';
import 'package:update_cart/models/place_model.dart';
import 'package:update_cart/models/product_model.dart';

late List<RemovedCartItem> removedCartItems;
late List<ModifiedPlaces> modifiedPlaces;
late List<RemovedCartProduct> removedCartProducts;
late List<ModifiedProducts> modifiedProducts;

class CartProvider {
  final List<CartItem> cartItems = List.from(localCartITems, growable: true);

  final onlinePlaces = placesList;

  final onlineProducts = productsList;

  num _total = 0;
  num get totalCartPrice {
    _total = 0;
    for (final item in cartItems) {
      _total += item.totalPrice;
    }
    return _total;
  }

  List<CartItem> updateCart() {
    removedCartItems = [];
    modifiedPlaces = [];
    removedCartProducts = [];
    modifiedProducts = [];
    //1- TODO: implement updateCart.
    for (var i = 0; i < cartItems.length; i++) {
      Place? onlinePlace = _getOnlinePlaceById(cartItems[i].place);
      if (onlinePlace == null) {
        _removeCart(cartItems[i], 'Place Is Not Fuound');
        i--;
        continue;
      }
      if (onlinePlace.isActive != true) {
        _removeCart(cartItems[i], 'Place Is Not Active');
        i--;
        continue;
      }

      _updateSinglePlace(cartItems[i].place, onlinePlace);

      _updateProducts(cartItems[i].products);
    }
    //2- ptint items after update.
    //3- Display the changes, that were made on user cart, on home page.

    return cartItems;
    // _printItemsAfterUpdate(cartItems);
  }

  // _printItemsAfterUpdate(List<CartItem> localCartItems) {
  //   for (final item in localCartItems) {
  //     print('############ START of cartItem id: ${item.id} ##########');
  //     print('Place: ${item.place.title}');
  //     print('isActive: ${item.place.isActive}');
  //     print('Place image: ${item.place.placeImage}');
  //     print('Place shipping price: ${item.place.shippingPrice}');
  //     for (final product in item.products) {
  //       _printCartProduct(product);
  //     }
  //     print('CartItem total price: ${item.totalPrice}');
  //     print('############ END of cartItem id: ${item.id} ##########');
  //   }
  //   print("Total cart price: $totalCartPrice");
  // }

  // _printCartProduct(CartProduct product) {
  //   print('Product: ${product.title}');
  //   print('Product description: ${product.description}');
  //   print('Product image : ${product.image}');
  //   print('Product price: ${product.price}');
  //   print('Product min items: ${product.minItems}');
  //   print('Product available qty: ${product.availableQuantity}');
  //   print('Product selected quantity: ${product.selectedQuantity}');
  //   print('Product total price: ${product.totalPrice}');
  //   print('############ END of Product ${product.title} ##########');
  // }

//? this functin return the online place with the same id of the locale place.
//? if this function return null that means the place in not found in the online places
  Place? _getOnlinePlaceById(Place place) {
    if (place.id == null) return null;
    Place? foundedPlace;
    for (Place onlinePlace in onlinePlaces) {
      if (place.id == onlinePlace.id) {
        foundedPlace = onlinePlace;
        break;
      }
    }
    return foundedPlace;
  }

//? this function remove the cartItem from CartItems.
  void _removeCart(CartItem cartItem, String reason) {
    removedCartItems
        .add(RemovedCartItem(removedProduct: cartItem, removalReason: reason));
    cartItems.remove(cartItem);
  }

  void _updateSinglePlace(Place oldPlace, Place onlinePlace) {
    if (oldPlace.shippingPrice != onlinePlace.shippingPrice) {
      _addPlaceToModifiedPlaces(oldPlace, onlinePlace);
      oldPlace.shippingPrice = onlinePlace.shippingPrice;
    }
  }

  void _addPlaceToModifiedPlaces(Place oldPlace, Place onlinePlace) {
    final ModifiedPlaces modifiedPlace = ModifiedPlaces(
      oldPlace: Place(
        id: oldPlace.id,
        isActive: oldPlace.isActive,
        placeImage: oldPlace.placeImage,
        shippingPrice: oldPlace.shippingPrice,
        title: oldPlace.title,
      ),
      newPlace: onlinePlace,
    );
    modifiedPlaces.add(modifiedPlace);
  }

//? this function will loop for every product and update it
  void _updateProducts(List<CartProduct> products) {
    if (products.isEmpty) return;
    for (int j = 0; j < products.length; j++) {
      Product? onlineProduct = getOnlineProductById(products[j]);
      if (onlineProduct == null) {
        _addProdutToRemovedProductsList(
            products[j], 'This Product Is Not found in online products');
        products.remove(products[j]);
        j--;
        continue;
      }
      if (onlineProduct.availableQuantity == null ||
          onlineProduct.minItems == null) {
        _addProdutToRemovedProductsList(
            products[j], 'Sorry ,we lost some data about this product');
        products.remove(products[j]);
        j--;
        continue;
      }
      if (onlineProduct.availableQuantity! < products[j].selectedQuantity) {
        _addProdutToRemovedProductsList(
            products[j], 'This Product Is Out of Stock');
        products.remove(products[j]);
        j--;
        continue;
      }
      _updateSingleProduct(products[j], onlineProduct);
    }
  }

//? this function return the online product with the same id of the locale product.
//? if this function reutn null that means the id of this product is not found in the online products
  Product? getOnlineProductById(CartProduct product) {
    if (product.id == null) return null;
    Product? foundedProduct;
    for (Product onlineProducts in onlineProducts) {
      if (product.id == onlineProducts.id) {
        foundedProduct = onlineProducts;
        break;
      }
    }
    return foundedProduct;
  }

  void _addProdutToRemovedProductsList(
      CartProduct cartProduct, String reaseon) {
    removedCartProducts.add(RemovedCartProduct(
      cartProduct: cartProduct,
      reason: reaseon,
    ));
  }

//* this functinon check if any important changes happened in the product then update it if yes
  void _updateSingleProduct(CartProduct cartProduct, Product onlineProduct) {
    if (cartProduct.selectedQuantity > onlineProduct.availableQuantity! ||
        cartProduct.selectedQuantity < onlineProduct.minItems! ||
        cartProduct.price != onlineProduct.price) {
      //? creating local procut to save it in the modified products
      //! creating now Product to save it in new adress in the memory then we will update the our local product
      final Product localeProductBeforeUpdate = Product(
        id: cartProduct.id,
        availableQuantity: cartProduct.availableQuantity,
        minItems: cartProduct.minItems,
        description: cartProduct.description,
        image: cartProduct.image,
        price: cartProduct.price,
        title: cartProduct.title,
      );
      modifiedProducts.add(ModifiedProducts(
        oldProduct: localeProductBeforeUpdate,
        newProduct: onlineProduct,
      ));

      //? update the locale product
      cartProduct.price = onlineProduct.price;
      cartProduct.totalPrice =
          onlineProduct.price! * cartProduct.selectedQuantity;
      cartProduct.availableQuantity = onlineProduct.availableQuantity;
      cartProduct.minItems = onlineProduct.minItems;
      cartProduct.description = onlineProduct.description;
      cartProduct.image = onlineProduct.image;
      cartProduct.title = onlineProduct.title;
    }
  }
}

//! These classes are separated to facilitate future enhancements such as adding filters
//! to inform the user about changed places and products.

/* 
? This class will be used to hold the cart item that was removed. 
? We will remove the entire cart if the place is no longer available.
 */
class RemovedCartItem {
  final CartItem removedProduct;
  final String removalReason;

  RemovedCartItem({
    required this.removedProduct,
    required this.removalReason,
  });
}

//? This class will be used to hold the places that was modified.
class ModifiedPlaces {
  final Place oldPlace;
  final Place newPlace;
  ModifiedPlaces({
    required this.oldPlace,
    required this.newPlace,
  });
}

//? This class will be used to hold the removed product.
class RemovedCartProduct {
  final Product cartProduct;
  final String reason;
  RemovedCartProduct({
    required this.cartProduct,
    required this.reason,
  });
}

//? This class will be used to hold the product that was modified.
class ModifiedProducts {
  final Product oldProduct;
  final Product newProduct;
  ModifiedProducts({
    required this.oldProduct,
    required this.newProduct,
  });
}
