import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../fancy_cart.dart';

class ModalCart extends ConsumerWidget {
  const ModalCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(EditModalCartNotifier.provider);
    return Expanded(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CartWidget(cartBuilder: (controller) {
          return Expanded(
              child: ListView.separated(
                itemCount: controller.cartList.length,
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
                                height: 30,
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
                                  ref.watch(EditModalCartNotifier.provider.notifier).state
                                      ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 2),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(20),
                                      color: Colors.grey.shade200,
                                    ),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            controller
                                                .decrementItemQuantity(
                                                item);
                                          },
                                          child: const Icon(
                                            Icons.remove,
                                            color: Colors.black,
                                            size: 18,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets
                                              .symmetric(
                                              horizontal: 16),
                                          child: Center(
                                            child: Text(
                                              item.quantity.toString(),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller
                                                .incrementItemQuantity(
                                                item);
                                          },
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.black,
                                            size: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                      : GestureDetector(
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
          height: 20,
        ),
      ],
    ));
  }
}
