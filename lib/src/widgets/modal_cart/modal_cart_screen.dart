import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../fancy_cart.dart';
import 'modal_cart.dart';
import 'modal_checkout_buttons.dart';
import 'modal_header.dart';
import 'modal_sub_total.dart';

class ModalCartScreen extends ConsumerStatefulWidget {
  final Function(List<CartItem> cartList) checkOutButton;
  final Function(List<CartItem> cartList) checkOutPaypalButton;
  const ModalCartScreen({
    Key? key,
    required this.checkOutButton,
    required this.checkOutPaypalButton,
  }) : super(key: key);

  @override
  ConsumerState<ModalCartScreen> createState() => _ModalCartScreenState();
}

class _ModalCartScreenState extends ConsumerState<ModalCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ModalHeader(),
              const ModalCart(),
              const ModalSubTotal(),
              ModalCheckOutButtons(
                checkOutButton: (cartList) {
                  return GestureDetector(
                    onTap: () {
                      widget.checkOutButton(cartList);
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                      child: const Center(
                        child: Text(
                          "Check out",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
                checkOutPaypalButton: (cartList) {
                  return GestureDetector(
                    onTap: () {
                      widget.checkOutPaypalButton(cartList);
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Center(
                            child: Text(
                              "Check out with",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ),
                          Image.asset(
                            "assets/images/paypal.png",
                            width: 100,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
