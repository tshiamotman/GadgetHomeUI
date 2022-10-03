import 'package:flutter/material.dart';
import 'package:gadgethome/constants/constants.dart';

class BottomNavAppBar extends StatelessWidget {
  const BottomNavAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: 4,
      shape: AutomaticNotchedShape(const RoundedRectangleBorder(),
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child: Container(
        margin: const EdgeInsets.only(left: 50, right: 50),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.pushNamed(context, MAIN_UI);
              },
            ),
            IconButton(
              icon: const Icon(Icons.message),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
