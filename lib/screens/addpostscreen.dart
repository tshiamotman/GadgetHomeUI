import 'package:flutter/material.dart';

import 'package:gadgethome/component/background.dart';
import 'package:gadgethome/component/bottomappbar.dart';
import 'package:gadgethome/component/gadgetdrawer.dart';
import 'package:gadgethome/constants/constants.dart';
import 'package:gadgethome/controllers/userprovider.dart';
import 'package:provider/provider.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddPost();
}

class _AddPost extends State<AddPost> {
  late final double _width;
  late final double _height;

  String dropdownvalue = 'camera';

  var items = [
    'camera',
    'cellphone',
    'computer',
    'laptop',
    'tablet',
    'television'
  ];

  final modelController = TextEditingController();
  final brandController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  final priceController = TextEditingController();

  Widget dropDown() {
    return DropdownButton(
      value: dropdownvalue,
      hint: const Text("Device"),
      icon: const Icon(Icons.keyboard_arrow_down),
      items: items.map<DropdownMenuItem<String>>((String item) {
        return DropdownMenuItem<String>(value: item, child: Text(item));
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          dropdownvalue = newValue.toString();
        });
      },
    );
  }

  Widget textField(String text, TextEditingController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: _height * 0.03),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 40),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: text),
          ),
        )
      ],
    );
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Colors.grey[300],
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(80.0),
    ),
  );

  final snackBar = SnackBar(
    duration: const Duration(seconds: 4),
    content: Row(
      children: const <Widget>[
        Center(child: CircularProgressIndicator()),
        Text("  Adding Ad...")
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    final controller = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      drawer: GadgetDrawer(
          height: _height,
          username: controller.user.userName,
          email: controller.user.email),
      bottomNavigationBar: const BottomNavAppBar(),
      body: SizedBox(
        height: _height,
        width: _width,
        child: SingleChildScrollView(
          child: Background(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: const Text(
                    "ADD Post",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2661FA),
                        fontSize: 36),
                    textAlign: TextAlign.left,
                  ),
                ),
                dropDown(),
                textField("Model", modelController),
                textField("Brand", brandController),
                textField("Description", descriptionController),
                textField("Location", locationController),
                textField("Price", priceController),
                SizedBox(height: _height * 0.05),
                Container(
                  alignment: Alignment.centerRight,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: ElevatedButton(
                    style: raisedButtonStyle,
                    onPressed: () {
                      Map<String, dynamic> map = {
                        "device": dropdownvalue,
                        "model": modelController.text,
                        "brand": brandController.text,
                        "description": descriptionController.text,
                        "amount": priceController.text
                      };
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      controller.postAd(map).whenComplete(
                          () => Navigator.pushNamed(context, MAIN_UI));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      width: _width * 0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80.0),
                          gradient: const LinearGradient(colors: [
                            Color.fromARGB(255, 255, 136, 34),
                            Color.fromARGB(255, 255, 177, 41)
                          ])),
                      padding: const EdgeInsets.all(0),
                      child: const Text(
                        "ADD POST",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
