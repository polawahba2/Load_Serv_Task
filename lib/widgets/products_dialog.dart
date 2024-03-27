import 'package:flutter/material.dart';

import '../cart_rpovider/cart_provider.dart';

import '../models/cart_item_model.dart';

late double height;

class ProductsDialog extends StatelessWidget {
  final List<CartItem> cartItems;
  const ProductsDialog({required this.cartItems, super.key});

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.02, horizontal: 10),
      child: SizedBox(
        height: height * 0.9,
        child: ListView(
          shrinkWrap: true,
          children: [
            if (cartItems.isNotEmpty) _LocalCartItems(cartItems: cartItems),
            if (removedCartItems.isNotEmpty) const _RemovedCartItems(),
            if (modifiedPlaces.isNotEmpty) const _ModifiedPlaces(),
            if (removedCartProducts.isNotEmpty) const _RemovedProducts(),
            if (modifiedProducts.isNotEmpty) const _ModifiedProducts()
          ],
        ),
      ),
    );
  }
}

class _LocalCartItems extends StatelessWidget {
  final List<CartItem> cartItems;
  const _LocalCartItems({
    required this.cartItems,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: height * 0.01),
        const Text(
          'This is Updated Cart Items',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                if (cartItems.isNotEmpty)
                  Text(
                    'Local Cart Item ${index + 1}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                Text('Title :${cartItems[index].place.title}'),
                Text('Product Name :${cartItems[index].products[0].title}'),
                Text('Shipping Price :${cartItems[index].place.shippingPrice}'),
                Text('Price :${cartItems[index].products[0].price}'),
                Text('Total Price :${cartItems[index].products[0].totalPrice}'),
                Text(
                    'Available Quantity :${cartItems[index].products[0].availableQuantity}'),
                Text('Min Items :${cartItems[index].products[0].minItems}'),
                Text(
                    'Selected Quantity :${cartItems[index].products[0].selectedQuantity}'),
              ],
            );
          },
          separatorBuilder: (context, index) => SizedBox(
            height: height * 0.01,
          ),
          itemCount: cartItems.length,
        ),
      ],
    );
  }
}

class _RemovedCartItems extends StatelessWidget {
  const _RemovedCartItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: height * 0.01),
        const Text(
          'This is the Removed Cart Items',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Text(
                  'Removed Cart Item ${index + 1}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: height * 0.01),
                Text('Cart id :${removedCartItems[index].removedProduct.id}'),
                SizedBox(height: height * 0.01),
                Text(
                    'Removal Reason :${removedCartItems[index].removalReason}'),
              ],
            );
          },
          separatorBuilder: (context, index) => const SizedBox.shrink(),
          itemCount: removedCartItems.length,
        ),
      ],
    );
  }
}

class _ModifiedPlaces extends StatelessWidget {
  const _ModifiedPlaces({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: height * 0.01),
        const Text(
          'This is the modified places',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Text(
                  'Modified place ${index + 1}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                if (modifiedPlaces[index].oldPlace.shippingPrice !=
                    modifiedPlaces[index].newPlace.shippingPrice) ...[
                  SizedBox(height: height * 0.01),
                  Text(
                    'old shipping price:${modifiedPlaces[index].oldPlace.shippingPrice} => \n new shipping price:${modifiedPlaces[index].newPlace.shippingPrice}',
                  ),
                ],
                if (modifiedPlaces[index].oldPlace.title !=
                    modifiedPlaces[index].newPlace.title) ...[
                  SizedBox(height: height * 0.01),
                  Text(
                    'old title:${modifiedPlaces[index].oldPlace.title} => \n new title:${modifiedPlaces[index].newPlace.title}',
                  ),
                ],
                if (modifiedPlaces[index].oldPlace.placeImage !=
                    modifiedPlaces[index].newPlace.placeImage) ...[
                  SizedBox(height: height * 0.01),
                  Text(
                    'old place image:${modifiedPlaces[index].oldPlace.placeImage} => \n new place image:${modifiedPlaces[index].newPlace.placeImage}',
                  ),
                ],
              ],
            );
          },
          separatorBuilder: (context, index) => const SizedBox.shrink(),
          itemCount: modifiedPlaces.length,
        ),
      ],
    );
  }
}

class _RemovedProducts extends StatelessWidget {
  const _RemovedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: height * 0.01),
        const Text(
          'This is the removed products',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Text(
                  'Removed Products ${index + 1}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: height * 0.01),
                Text(
                    'product id :${removedCartProducts[index].cartProduct.id}'),
                SizedBox(height: height * 0.01),
                Text('Removal Reason :${removedCartProducts[index].reason}'),
              ],
            );
          },
          separatorBuilder: (context, index) => const SizedBox.shrink(),
          itemCount: removedCartProducts.length,
        ),
      ],
    );
  }
}

class _ModifiedProducts extends StatelessWidget {
  const _ModifiedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: height * 0.01),
        const Text(
          'This is the modified products',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Text(
                  'Modified products ${index + 1}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                if (modifiedProducts[index].oldProduct.price !=
                    modifiedProducts[index].newProduct.price) ...[
                  SizedBox(height: height * 0.01),
                  Text(
                    'old price:${modifiedProducts[index].oldProduct.price} => \n new price:${modifiedProducts[index].newProduct.price}',
                  ),
                ],
                if (modifiedProducts[index].oldProduct.title !=
                    modifiedProducts[index].newProduct.title) ...[
                  SizedBox(height: height * 0.01),
                  Text(
                    'old title:${modifiedProducts[index].oldProduct.title} => \n new title:${modifiedProducts[index].newProduct.title}',
                  ),
                ],
                if (modifiedProducts[index].oldProduct.minItems !=
                    modifiedProducts[index].newProduct.minItems) ...[
                  SizedBox(height: height * 0.01),
                  Text(
                    'old min items:${modifiedProducts[index].oldProduct.minItems} => \n new min items:${modifiedProducts[index].newProduct.minItems}',
                  ),
                ],
                if (modifiedProducts[index].oldProduct.availableQuantity !=
                    modifiedProducts[index].newProduct.availableQuantity) ...[
                  SizedBox(height: height * 0.01),
                  Text(
                    'old available quantaty:${modifiedProducts[index].oldProduct.availableQuantity} => \n new available quantaty:${modifiedProducts[index].newProduct.availableQuantity}',
                  ),
                ],
                if (modifiedProducts[index].oldProduct.image !=
                    modifiedProducts[index].newProduct.image) ...[
                  SizedBox(height: height * 0.01),
                  Text(
                    'old image:${modifiedProducts[index].oldProduct.image} => \n new  image:${modifiedProducts[index].newProduct.image}',
                  ),
                ],
              ],
            );
          },
          separatorBuilder: (context, index) => const SizedBox.shrink(),
          itemCount: modifiedProducts.length,
        ),
      ],
    );
  }
}
