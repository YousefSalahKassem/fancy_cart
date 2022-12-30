import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../bloc/providers/cart_notifier.dart';

class ClearCartButton extends ConsumerWidget {
  final Widget child;
  final Function? actionAfterDelete;
  const ClearCartButton({Key? key, required this.child, this.actionAfterDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return GestureDetector(
      onTap: (){
        ref.read(CartNotifier.provider.notifier).clearCart();
        if(actionAfterDelete != null){
          actionAfterDelete!();
        }
      },
      child: child,
    );
  }
}
