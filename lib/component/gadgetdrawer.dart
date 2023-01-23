import 'package:flutter/material.dart';

class GadgetDrawer extends StatelessWidget {
  const GadgetDrawer({
    Key? key,
    required double height,
    required this.username,
    required this.email,
  })  : _height = height,
        super(key: key);

  final double _height;
  final String username;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Opacity(
            opacity: 0.75,
            child: Container(
              height: _height / 6,
              padding: EdgeInsets.only(top: _height / 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.pinkAccent],
                ),
              ),
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.black,
                  ),
                  radius: 30,
                  backgroundColor: Colors.white,
                ),
                title: Text(username),
                subtitle: Text(
                  email,
                  style: const TextStyle(fontSize: 13),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.payment),
            title: Text("Orders & Payments"),
          ),
        ],
      ),
    );
  }
}
