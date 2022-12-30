import 'package:hive_flutter/adapters.dart';
import '../bloc/models/cart_item.dart';

class CartService {

  Future<void> add(CartItem cart)async{
    var box = Hive.box<CartItem>('cart');
    box.add(cart);
  }

  Future<void> remove(CartItem cart)async{
    var box = Hive.box<CartItem>('cart');
    box.delete(cart.key);
  }

  Future<List<CartItem>> fetch()async{
    var box = Hive.box<CartItem>('cart');
    return box.values.toList();
  }

  Future<void> updateQuantity(CartItem cart, int quantity)async{
    var box = Hive.box<CartItem>('cart');
    cart.quantity = quantity;
    box.put(cart.key, cart);
  }

  Future<void> updatePrice(CartItem cart, double price)async{
    var box = Hive.box<CartItem>('cart');
    cart.price = price;
    box.put(cart.key, cart);
  }

  Future<void> clear()async{
    var box = Hive.box<CartItem>('cart');
    box.clear();
  }

  Future<void> dispose()async{
    await Hive.close();
  }

}