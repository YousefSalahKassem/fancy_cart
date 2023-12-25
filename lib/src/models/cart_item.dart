import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'cart_item.g.dart';

@HiveType(typeId: 1)
class CartItem extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String id;
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
    this.quantity = 1,
    this.additionalData = const {},
  });

  @override
  List<Object?> get props => [id, name, image, additionalData];
}
