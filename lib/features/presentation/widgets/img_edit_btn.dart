// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// this widget used in the iage edit window to
// act as image edit button
// the key of eac button used to check the state of the button
// that whether  it is clcked or not
// the key is he string that given as symatic labl
class EditBtnContainer extends ConsumerStatefulWidget {
  final IconData icon;
  final String lable;
  final VoidCallback? ontap;
  const EditBtnContainer({
    super.key,
    required this.icon,
    required this.lable,
    this.ontap,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditBtnContainerState();
}

class _EditBtnContainerState extends ConsumerState<EditBtnContainer> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: widget.ontap,
      child: Tooltip(
        message: widget.lable,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.white10),
          margin: const EdgeInsets.all(2),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Icon(
            widget.icon,
            textDirection: TextDirection.ltr,
          ),
        ),
      ),
    ));
  }
}
