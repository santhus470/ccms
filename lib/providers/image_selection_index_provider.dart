import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageSelectedIndexNotifier extends StateNotifier<int> {
  ImageSelectedIndexNotifier() : super(0);

  void setIndex(int index) {
    state = index;
  }

  int getIndex() {
    return state;
  }

  void increment() {
    state++;
  }

  void decrement() {
    state--;
  }
}

final selectedImageIndexProvider =
    StateNotifierProvider<ImageSelectedIndexNotifier, int>(
        (ref) => ImageSelectedIndexNotifier());
