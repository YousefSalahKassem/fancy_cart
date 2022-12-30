# Cart System Package

### Welcome to the cart system package this package depend on:

1: Hive Local Storage<br />
2: Riverpod State Management

### so before we start , if you dont know more about Hive and Riverpod , recommend you to visit  this website [Hive](https://docs.hivedb.dev/#/) and [riverpod](https://riverpod.dev)
------------
# Table of content

1: Features<br />
2: How it works<br />
3: Explain each method inside notifier<br />
4: Example how to implement it

------------
# Features
1: add items inside cart<br />
2: remove item from cart<br />
3: clear cart list<br />
4: increment and decrement numer of quantities<br />
5: get total price for cart<br />
6: get total items inside cart

------------  
# How it Works

### First thing we need what data can cart item need to hold

```dart  
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String image;
  @HiveField(3)
  double price;
  @HiveField(4)
  int quantity;
  @HiveField(5)
  final Map<String, dynamic> additionalData;
```

in the class model:

```dart 
@HiveType(typeId: 1)
class CartItem extends HiveObject with EquatableMixin {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String image;
  @HiveField(3)
  double price;
  @HiveField(4)
  int quantity;
  @HiveField(5)
  final Map<String, dynamic> additionalData;


  CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    required this.additionalData,
  });

  @override
  List<Object?> get props => [id, name, image, additionalData];
}
```
------------
### Second thing go inside card notifier class and let's explain each method how it works for cart system

## Initialize
init hive and register cart item adapter then open cart box to store cart items,<br />as its depend on hive so we need to initialize it in main.dart
```dart 
  static initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CartItemAdapter());
    await Hive.openBox<CartItem>('cart');
  }
``` 
------------
## Cart List
init cart list inside notifier
```dart 
  List<CartItem> _cartList = [];
  List<CartItem> get cartList => _cartList;

  CartNotifier() {
    fetchCart();
  }
```
------------
## Add Item to Cart
if item already exist in cart then update its quantity<br />
else add it to cart.
```dart 
  Future<void> addItem(CartItem cart) async {
    if (_cartList.contains(cart)) {
      final int index = _cartList.indexOf(cart);
      incrementItemQuantity(_cartList[index]);
      getPriceForItem(cart);
    } else {
      await _cartService.add(cart);
      _cartList.add(cart);
    }
    notifyListeners();

  }
``` 
------------
## Remove Item from Cart
```dart 
Future<void> removeItem(CartItem cart) async {
    await _cartService.remove(cart);
    _cartList.remove(cart);
    notifyListeners();
}
```
------------
## Fetch items
```dart 
  Future<void> fetchCart() async {
    _cartList = await _cartService.fetch();
    notifyListeners();
  }
```
------------
## Clear Cart
```dart 
  Future<void> clearCart() async {
    await _cartService.clear();
    _cartList = [];
    notifyListeners();
  }
```
------------
## Increment qunantity
have an option to update price for item when increment
```dart 
  Future<void> incrementItemQuantity(CartItem cart) async {
    cart.quantity++;
    await _cartService.updateQuantity(cart, cart.quantity);
    getPriceForItem(cart);
    await _cartService.updatePrice(cart, cart.price);
    notifyListeners();

  }
```
------------
## Decrement quantity

there is 2 behaviors here:<br />
1: if [deleteOption] is true then delete item from cart if quantity is less than 1<br />
2: else if [deleteOption] is false then it doesn't delete item from cart if quantity is less than 1<br />
3: else decrement item quantity and update its price<br />

there is an option [actionAfterDelete] to make action after delete item like showing snackBar, etc.<br />
there is an option [notDecrementedAction] to make action if item quantity is less than 1 and [deleteOption] is false like showing snackBar, etc.
```dart 
  Future<void> decrementItemQuantity(CartItem cart, {bool deleteOption = false,Function? actionAfterDelete, Function? notDecrementedAction}) async {
    if (cart.quantity > 1) {
      cart.quantity--;
      await _cartService.updateQuantity(cart, cart.quantity);
      getPriceForItem(cart);
      await _cartService.updatePrice(cart, cart.price);
      notifyListeners();
    } else {
      if (deleteOption) {
        await removeItem(cart);
        if(actionAfterDelete!=null){
          actionAfterDelete();
        }
      } else {
        if(notDecrementedAction!=null){
          notDecrementedAction();
        }
      }
    }
  }
```
------------
## get total price in cart
```dart 
  double getTotalPrice() {
    double totalPrice = 0;
    for (final CartItem cart in _cartList) {
      totalPrice += cart.price * cart.quantity;
    }
    return totalPrice;
  }
```
------------
## get price for each item
you have an option [updatePrice] to update item price in cart,<br />
if you set it to true then it will update item price in cart by multiplying item price by item quantity<br />
else it will return item price without updating it<br />
```dart
  double getPriceForItem(CartItem cart, {bool updatePrice = false}) {
    if(updatePrice){
      final double total = cart.quantity * cart.price;
      return total;
    }
    return cart.price;
  }
```
------------
## get total items in cart
if [needToIncludeQuantity] is true then it will return total number of items in cart including quantity<br />
else it will return number of items in cart<br />
```dart
  int getNumberOfItemsInCart({bool needToIncludeQuantity = true}) {
    if (needToIncludeQuantity){
      int totalQuantity = 0;
      for (final CartItem cart in _cartList) {
        totalQuantity += cart.quantity;
      }
      return totalQuantity;
    } else {
      return _cartList.length;
    }
  }
```
------------
# Example
### how to implement it inside your project

## init
init cart notifier inside main
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /// Initialize cart notifier
  await CartNotifier.initialize();
  runApp(const ProviderScope(child: MyApp()));
}
```
------------
## cart screen

get cart items
```dart
final cartList = ref.watch(CartNotifier.provider).cartList;
```
notify cart notifier to do some actions
```dart
final cartNotifier = ref.watch(CartNotifier.provider.notifier);
```
------------
## add item
```dart
IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            cartNotifier.addItem(
                CartItem(
                    id: 1,
                    name: "item 1",
                    image: "image",
                    price: 10,
                    quantity: 1,
                    additionalData: {})
            );
          },
        ),
```
------------
## clear cart
```dart
IconButton(
            onPressed: () {
              ref.read(CartNotifier.provider.notifier).clearCart();
            },
            icon: const Icon(Icons.delete),
          ),
```
------------
## get total items in cart
```dart
Text('Cart Items: ${cartNotifier.getNumberOfItemsInCart()}'),
```
------------
## get total price in cart
```dart
Text('Total Price: ${cartNotifier.getTotalPrice()}'),
```
------------
## fetch cart items
```dart
          /// show cart items
          Expanded(
            child: ListView.builder(
              itemCount: cartList.length,
              itemBuilder: (context, index) {
                /// access cart item
                final cartItem = cartList[index];
                return ListTile(
                  title: Text(cartItem.name),

                  /// get price for item
                  subtitle: Text(cartNotifier.getPriceForItem(cartItem).toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          /// decrement item quantity
                          cartNotifier.decrementItemQuantity(cartItem);
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Text(cartItem.quantity.toString()),
                      IconButton(
                        onPressed: () {
                          /// increment item quantity
                          cartNotifier.incrementItemQuantity(cartItem);
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  leading: IconButton(
                    onPressed: () {
                      /// remove item from cart
                      cartNotifier.removeItem(cartItem);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                );
              },
            ),
          ),
```
