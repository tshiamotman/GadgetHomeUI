import 'package:flutter/material.dart';
import 'package:gadgethome/constants/constants.dart';
import 'package:gadgethome/controllers/messageprovider.dart';
import 'package:provider/provider.dart';

class BottomNavAppBar extends StatelessWidget {
  const BottomNavAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageController = Provider.of<MessageProvider>(context);
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
              onPressed: () {
                messageController.getToken();
                Navigator.pushNamed(context, MESSAGES_SCREEN);
              },
            )
          ],
        ),
      ),
    );
  }
}
