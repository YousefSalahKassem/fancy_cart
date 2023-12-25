import 'package:fancy_cart/fancy_cart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() => CartNotifier.initialize());
  group("testing cart system package", () {
    final provider = ProviderContainer(
      overrides: [
        CartNotifier.provider.overrideWithProvider(
          ChangeNotifierProvider((ref) => CartNotifier()),
        ),
      ],
    );
    final cartNotifier = provider.read(CartNotifier.provider.notifier);
    final cartList = provider.read(CartNotifier.provider).cartList;

    test('add item to cart ', () {
      cartNotifier.addItem(
        CartItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: 'Item ${cartList.length + 1}',
          price: 100,
          image: '',
          quantity: 1,
          additionalData: {},
        ),
      );
      expect(cartNotifier.getNumberOfItemsInCart(), 1);
    });

    test('increment item quantity', () {
      cartNotifier.incrementItemQuantity(cartList[0]);
      expect(cartList[0].quantity, 2);
      expect(cartNotifier.getNumberOfItemsInCart(), 2);
    });

    test('decrement item quantity', () {
      cartNotifier.decrementItemQuantity(cartList[0]);
      expect(cartList[0].quantity, 1);
      expect(cartNotifier.getNumberOfItemsInCart(), 1);
    });

    test('remove item from cart', () {
      cartNotifier.removeItem(cartList[0]);
      expect(cartNotifier.getNumberOfItemsInCart(), 0);
    });

    test('clear cart', () {
      cartNotifier.clearCart();
      expect(cartNotifier.getNumberOfItemsInCart(), 0);
    });
  });
}
