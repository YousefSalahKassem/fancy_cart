import 'package:fancy_cart/src/bloc/models/cart_item.dart';
import 'package:fancy_cart/src/bloc/providers/cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() => CartNotifier.initialize());
  testWidgets("test cart system package", (tester) async {
    await tester.pumpWidget(ProviderScope(child: Consumer(builder: (_, ref, __) {
      final cartNotifier = ref.watch(CartNotifier.provider.notifier);
      final cartList = ref.watch(CartNotifier.provider).cartList;
      return MaterialApp(
          home: Scaffold(
        appBar: AppBar(
          title: Text("Cart ${cartNotifier.getNumberOfItemsInCart().toString()}"),
          leading: IconButton(
            icon: const Icon(Icons.plus_one),
            onPressed: () {
              cartNotifier.addItem(
                CartItem(
                  id: DateTime.now().millisecondsSinceEpoch,
                  name: 'Item ${cartList.length + 1}',
                  price: 100,
                  image: '',
                  quantity: 1,
                  additionalData: {},
                ),
              );
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.abc),
              onPressed: () {
                cartNotifier.addItem(
                  CartItem(
                    id: DateTime.now().millisecondsSinceEpoch,
                    name: 'Item ${cartList.length + 1}',
                    price: 100,
                    image: '',
                    quantity: 1,
                    additionalData: {},
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                cartNotifier.clearCart();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 500,
              child:  ListView.builder(
                shrinkWrap: true,
                itemCount: cartList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text(cartList[index].name),
                      subtitle: Text(cartNotifier
                          .getPriceForItem(cartList[index])
                          .toString()),
                      leading: IconButton(
                        icon: const Icon(Icons.shopping_bag),
                        onPressed: () {
                          cartNotifier.removeItem(cartList[index]);
                        },
                      ),
                      trailing: Row(
                        // add and remove quantity
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.dangerous),
                            onPressed: () {
                              cartNotifier.incrementItemQuantity(cartList[index]);
                            },
                          ),
                          // text showing quantity
                          Text('ok ${cartList[index].quantity}'),
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              cartNotifier.decrementItemQuantity(cartList[index]);
                            },
                          ),
                        ],
                      ));
                },
              ),
            ),
            Text('Total: ${cartNotifier.getTotalPrice()}'),
          ],
        ),
      ));
    }))
    );

    // clear cart
    await tester.tap(find.byIcon(Icons.clear));
    await tester.pumpAndSettle();
    expect(find.text('Cart 0'), findsOneWidget);

    // add item
    await tester.tap(find.byIcon(Icons.plus_one));
    await tester.pumpAndSettle();
    expect(find.text('Cart 1'), findsOneWidget);

    // total price
    expect(find.text('Total: 100.0'), findsOneWidget);

    // increment item quantity
    await tester.tap(find.byIcon(Icons.dangerous));
    await tester.pump();
    expect(find.text('ok 2'), findsOneWidget);

    // total price
    expect(find.text('Total: 200.0'), findsOneWidget);

    // total items in cart
    expect(find.text('Cart 2'), findsOneWidget);

    // decrement item quantity
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(find.text('ok 1'), findsOneWidget);

    // total price
    expect(find.text('Total: 100.0'), findsOneWidget);

    // remove item
    await tester.tap(find.byIcon(Icons.shopping_bag));
    await tester.pumpAndSettle();
    expect(find.text('Cart 0'), findsOneWidget);
  });
}
