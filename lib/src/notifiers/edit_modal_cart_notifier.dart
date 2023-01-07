import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditModalCartNotifier extends StateNotifier<bool> {
  static final provider =
      StateNotifierProvider((ref) => EditModalCartNotifier());

  EditModalCartNotifier() : super(false);

  void editClicked() {
    state = !state;
  }
}
