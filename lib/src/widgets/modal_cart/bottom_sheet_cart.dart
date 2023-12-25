// animated cart bottom sheet
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fancy_cart/fancy_cart.dart';

class BottomSheetCart extends ConsumerStatefulWidget {
  final Function(List<CartItem> cartList) checkOutButton;
  final Function(List<CartItem> cartList) checkOutPaypalButton;

  const BottomSheetCart({
    Key? key,
    required this.checkOutButton,
    required this.checkOutPaypalButton,
  }) : super(key: key);

  // show bottom sheet
  static void show(
      {required BuildContext context,
      required Function(List<CartItem> cartList) checkOutButton,
      required Function(List<CartItem> cartList) checkOutPaypalButton}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[100],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => BottomSheetCart(
          checkOutButton: checkOutButton,
          checkOutPaypalButton: checkOutPaypalButton),
    );
  }

  @override
  ConsumerState<BottomSheetCart> createState() => _BottomSheetCartState();
}

class _BottomSheetCartState extends ConsumerState<BottomSheetCart> {
  @override
  Widget build(BuildContext context) {
    ref.listen(CartNotifier.provider, (previous, next) {
      // listen to cart changes
      if (next.cartList.isEmpty) {
        Navigator.pop(context);
      }
    });
    final height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
          margin: const EdgeInsets.all(30),
          height: height * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "My Cart",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 2,
                color: Colors.grey.withOpacity(0.15),
              ),
              CartWidget(cartBuilder: (controller, _) {
                return Expanded(
                    child: ListView.separated(
                  itemCount: controller.cartList.take(2).length,
                  itemBuilder: (context, index) {
                    final item = controller.cartList[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            margin: const EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(item.image),
                                  fit: BoxFit.cover),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Color: ${item.additionalData["color"]} | item #${item.id.toString().substring(item.id.toString().length - 4)}",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "\$${item.price}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.removeItem(item);
                                      },
                                      child: const Text(
                                        "Remove",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 2,
                      color: Colors.grey.withOpacity(0.15),
                    );
                  },
                ));
              }),
              Container(
                height: 2,
                color: Colors.grey.withOpacity(0.15),
              ),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ModalCartScreen(
                                  checkOutButton: widget.checkOutButton,
                                  checkOutPaypalButton:
                                      widget.checkOutPaypalButton,
                                )));
                  },
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    width: double.infinity,
                    child: const Center(
                      child: Text(
                        "Continue",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 16),
                      ),
                    ),
                  ))
            ],
          )),
    );
  }
}
