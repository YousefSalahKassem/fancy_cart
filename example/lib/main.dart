import 'dart:developer';
import 'package:fancy_cart/fancy_cart.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize fancy cart
  initializeFancyCart(
    child: const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: _navKey,

        /// Example of using Fancy Cart
        home: const MyPage());
  }
}

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int time = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ----------------- Add To Cart ----------------- //
          AddToCartButton(
            actionAfterAdding: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyCart()));
              setState(() {
                time = DateTime.now().millisecondsSinceEpoch;
              });
            },
            cartModel: CartItem(
                id: time.toString(), name: 'Test', price: 100, image: ""),
            child: Container(
              height: 50,
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "Add to cart",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyCart extends StatelessWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Test Cart'),
          actions: [
            // ----------------- Clear Cart ----------------- //
            /// clear cart button with action after delete
            ClearCartButton(
              child: const Icon(Icons.delete),
              actionAfterDelete: () {
                log("cart deleted", name: "cart deleted");
              },
            ),

            // ----------------- Total Items in Cart ----------------- //
            /// total items in cart, with option to include quantity or not (default is true)
            TotalItemsCartWidget(totalItemsBuilder: (totalItems) {
              return Text(totalItems.toString());
            })
          ],
        ),
        // ----------------- Cart Widget ----------------- //
        /// cart widget with custom builder for cart list which contains controller to add, remove, clear cart
        body: CartWidget(cartBuilder: (controller, _) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller.cartList.length,
                  itemBuilder: (context, index) {
                    final cartItem = controller.cartList[index];
                    return ListTile(
                      title: Text(cartItem.name),
                      subtitle: Text(controller
                          .getPriceForItem(cartItem, updatePrice: true)
                          .toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              controller.incrementItemQuantity(cartItem);
                            },
                            icon: const Icon(Icons.add),
                          ),
                          Text(cartItem.quantity.toString()),
                          IconButton(
                            onPressed: () {
                              controller.decrementItemQuantity(cartItem);
                            },
                            icon: const Icon(Icons.remove),
                          ),
                        ],
                      ),
                      leading: IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          controller.removeItem(cartItem);
                        },
                      ),
                    );
                  },
                ),
              ),
              // ----------------- Total Price in Cart ----------------- //
              Text("Total Price : ${controller.getTotalPrice()}"),
            ],
          );
        }));
  }
}
