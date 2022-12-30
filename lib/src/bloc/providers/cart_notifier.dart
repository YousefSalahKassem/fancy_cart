import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import '../../data/cart_service.dart';
import '../models/cart_item.dart';

class CartNotifier extends ChangeNotifier {
  static final provider = ChangeNotifierProvider.autoDispose((ref) => CartNotifier());

  final CartService _cartService = CartService();

  List<CartItem> _cartList = [];
  List<CartItem> get cartList => _cartList;

  CartNotifier() {
    fetchCart();
  }


  /// init hive and register cart item adapter then open cart box to store cart items,
  /// as its depend on hive so we need to initialize it in main.dart
  static initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CartItemAdapter());
    await Hive.openBox<CartItem>('cart');
  }


  /// add item to cart,
  ///
  /// if item already exist in cart then update its quantity
  /// else add it to cart
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


  /// remove item from cart
  Future<void> removeItem(CartItem cart) async {
    await _cartService.remove(cart);
    _cartList.remove(cart);
    notifyListeners();
  }


  /// get total items in cart
  Future<void> fetchCart() async {
    _cartList = await _cartService.fetch();
    notifyListeners();
  }


  /// clear cart
  Future<void> clearCart() async {
    await _cartService.clear();
    _cartList = [];
    notifyListeners();
  }


  /// increment item quantity and update its price
  Future<void> incrementItemQuantity(CartItem cart) async {
    cart.quantity++;
    await _cartService.updateQuantity(cart, cart.quantity);
    getPriceForItem(cart);
    await _cartService.updatePrice(cart, cart.price);
    notifyListeners();

  }


  /// decrement item quantity,
  ///
  /// there is 2 behaviors here:
  /// 1: if [deleteOption] is true then delete item from cart if quantity is less than 1
  /// 2: else if [deleteOption] is false then it doesn't delete item from cart if quantity is less than 1
  /// 3: else decrement item quantity and update its price
  ///
  /// there is an option [actionAfterDelete] to make action after delete item like showing snackBar, etc.
  /// there is an option [notDecrementedAction] to make action if item quantity is less than 1 and [deleteOption] is false like showing snackBar, etc.
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


  /// get total price of all items in cart
  double getTotalPrice() {
    double totalPrice = 0;
    for (final CartItem cart in _cartList) {
      totalPrice += cart.price * cart.quantity;
    }
    return totalPrice;
  }


  /// get price for each item in cart
  /// you have an option [updatePrice] to update item price in cart
  /// if you set it to true then it will update item price in cart by multiplying item price by item quantity
  /// else it will return item price without updating it
  double getPriceForItem(CartItem cart, {bool updatePrice = false}) {
    if(updatePrice){
      final double total = cart.quantity * cart.price;
      return total;
    }
    return cart.price;
  }


  /// get number of items in cart
  ///
  /// if [needToIncludeQuantity] is true then it will return total number of items in cart including quantity
  /// else it will return number of items in cart
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


  /// dispose hive
  @override
  void dispose() {
    _cartService.dispose();
    super.dispose();
  }
}
