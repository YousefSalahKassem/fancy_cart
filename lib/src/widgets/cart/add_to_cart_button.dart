import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../bloc/models/cart_item.dart';
import '../../bloc/providers/cart_notifier.dart';


class AddToCartButton extends ConsumerWidget {
  final Widget child;
  final Function? actionAfterAdding;
  final CartItem cartModel;
  const AddToCartButton({Key? key, required this.child, this.actionAfterAdding,required this.cartModel})
      : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return GestureDetector(
      onTap: (){
        ref.read(CartNotifier.provider.notifier).addItem(cartModel);
        if(actionAfterAdding != null){
          actionAfterAdding!();
        }
      },
      child: child,
    );
  }
}
