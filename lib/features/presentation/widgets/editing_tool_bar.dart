import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditingTools extends ConsumerStatefulWidget {
  const EditingTools({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditingToolsState();
}

class _EditingToolsState extends ConsumerState<EditingTools> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton.icon(
            onPressed: () {}, icon: Icon(Icons.crop), label: Text('crop'))
      ],
    );
  }
}
