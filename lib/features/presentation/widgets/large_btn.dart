import 'package:flutter/material.dart';

class MainBtn extends StatelessWidget {
  final String title;
  final Function()? ontap;
  final IconData? leading;
  final Color? fontcolor;
  const MainBtn(
      {Key? key,
      required this.title,
      this.ontap,
      this.leading,
      this.fontcolor = const Color.fromARGB(255, 243, 232, 83)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  spreadRadius: 0,
                  offset: Offset(0, 10))
            ],
            // color: const Color.fromARGB(153, 95, 89, 4),
            color: Colors.white12,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Icon(
              leading,
              color: fontcolor,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, color: fontcolor),
            ),
          ],
        ),
      ),
    );
  }
}
