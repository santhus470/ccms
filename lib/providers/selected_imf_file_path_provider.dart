import 'package:flutter_riverpod/flutter_riverpod.dart';

class PickedFilesNotofier extends StateNotifier<List<String>> {
  PickedFilesNotofier() : super([]);

  void addListOfPath(List<String> paths) {
    state = [for (final path in paths) path];
    print(state);
  }

  void removeImage(int index) {
    if (index >= 0 && index < state.length) {
      state = List.from(state)..removeAt(index);
    }
  }
}

final pickedFileListProvider =
    StateNotifierProvider<PickedFilesNotofier, List<String>>(
        (ref) => PickedFilesNotofier());
