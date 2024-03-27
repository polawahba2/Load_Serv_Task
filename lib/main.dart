import 'package:flutter/material.dart';
import 'package:update_cart/cart_rpovider/cart_provider.dart';
import 'package:update_cart/widgets/products_dialog.dart';

import 'models/cart_item_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter test project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Update Cart Project'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isChanged = false;
  late List<CartItem> cartItems;
  updateCart() {
    cartItems = CartProvider().updateCart();

    setState(() {
      // Notify user of the changes you have made on the home page.
      // isChanged = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  updateCart();

                  showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      child: ProductsDialog(cartItems: cartItems),
                    ),
                  );
                },
                child: const Text('Press To Update Cart')),
            const SizedBox(height: 20),
            const Text(
              'Check cosole for updated cart items',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            if (isChanged)
              const Text(
                'Changes that were done are shown here',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
