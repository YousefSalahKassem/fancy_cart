#Fancy Cart Package

### Welcome to the Fancy Cart package this package depend on:

1: Hive Local Storage<br />
2: Riverpod State Management

### so before we start , if you dont know more about Hive and Riverpod , recommend you to visit  this website [Hive](https://docs.hivedb.dev/#/) and [riverpod](https://riverpod.dev)
------------
# Table of content

1: Features<br />
2: How it works<br />
3: Explain each method inside notifier<br />
4: Example how to implement it
5: Types of Cart
------------
# Features
1: add items inside cart<br />
2: remove item from cart<br />
3: clear cart list<br />
4: increment and decrement numer of quantities<br />
5: get total price for cart<br />
6: get total items inside cart
7: types of fancy cart pages

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

------------

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

  }
``` 
------------
## Remove Item from Cart
```dart 
Future<void> removeItem(CartItem cart) async {

}
```
------------
## Fetch items
```dart 
  Future<void> fetchCart() async {

  }
```
------------
## Clear Cart
```dart 
  Future<void> clearCart() async {

  }
```
------------
## Increment qunantity
have an option to update price for item when increment
```dart 
  Future<void> incrementItemQuantity(CartItem cart) async {

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
    
  }
```
------------
## get total price in cart
```dart 
  double getTotalPrice() {

  }
```
------------
## get price for each item
you have an option [updatePrice] to update item price in cart,<br />
if you set it to true then it will update item price in cart by multiplying item price by item quantity<br />
else it will return item price without updating it<br />
```dart
  double getPriceForItem(CartItem cart, {bool updatePrice = false}) {

  }
```
------------
## get total items in cart
if [needToIncludeQuantity] is true then it will return total number of items in cart including quantity<br />
else it will return number of items in cart<br />
```dart
  int getNumberOfItemsInCart({bool needToIncludeQuantity = true}) {

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
  
  /// initialize fancy cart
  initializeFancyCart(
    child: const MyApp(),
  );
}
```
------------
## Example

```dart
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,

        /// Example of using Fancy Cart
        home: Scaffold(
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
          body: CartWidget(
            cartBuilder: (controller) {
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

                  // ----------------- add to cart button ----------------- //
                  /// add to cart button with action after add and model to add
                  AddToCartButton(
                    actionAfterAdding: () {
                      log("item added", name: "item added");
                    },
                    cartModel: CartModel(
                        id: DateTime.now().millisecondsSinceEpoch,
                        name: 'Test',
                        price: 100,
                        image: ""),
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

                  // ----------------- Total price ----------------- //
                  /// total price of cart
                  Text("Total Price : ${controller.getTotalPrice()}"),
                ],
              );
            },
          ),
        ));
  }
}
```

## Types Of Cart

### Trolley Cart
![trolley](https://user-images.githubusercontent.com/91211054/210039423-1a500c3c-8097-4a64-9257-38cb324e71f9.png)
```dart 
class TrolleyCartScreen extends StatelessWidget {
  const TrolleyCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            const TrolleyHeader(),
            const SizedBox(
              height: 10,
            ),
            const ShoppingCartTrolley(quantityCardDirection: Direction.vertical),
            const SizedBox(
              height: 10,
            ),
            TrolleyCheckOut(
              shippingFee: 10,
              onCheckout: () {},
            ),
          ],
        ),
      )),
    );
  }
}

```

