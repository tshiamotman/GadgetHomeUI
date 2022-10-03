import 'package:flutter/material.dart';
import 'package:gadgethome/component/adlist.dart';
import 'package:gadgethome/component/bottomappbar.dart';
import 'package:gadgethome/component/customshape.dart';
import 'package:gadgethome/component/gadgetdrawer.dart';
import 'package:gadgethome/constants/constants.dart';
import 'package:gadgethome/controllers/userprovider.dart';
import 'package:gadgethome/models/ad.dart';
import 'package:gadgethome/screens/searchscreen.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late double _height;
  late double _width;

  bool isExpanded = false;

  final searchController = TextEditingController();

  Widget fab() {
    return FloatingActionButton.extended(
      elevation: 3,
      onPressed: () {
        Navigator.pushNamed(context, ADD_POST);
      },
      backgroundColor: Colors.orange[200],
      icon: const Icon(Icons.camera_alt),
      label: const Text(
        "Post AD",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void emptyFunction(String topic) {
    Navigator.pushNamed(context, SEARCH_SCREEN, arguments: topic);
  }

  Widget labelsGrid() {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 4,
      children: <Widget>[
        electronicsLabel("assets/icons/apple_icon.png", "Apple", () {
          emptyFunction("apple");
        }),
        electronicsLabel("assets/icons/camera_icon.png", "Cameras", () {
          emptyFunction("camera");
        }),
        electronicsLabel("assets/icons/cell_phone_icon.png", "Cell Phones", () {
          emptyFunction("cellphone");
        }),
        electronicsLabel("assets/icons/computer_icon.png", "Computers", () {
          emptyFunction("computer");
        }),
        electronicsLabel("assets/icons/laptop_icon.png", "Laptops", () {
          emptyFunction("laptop");
        }),
        electronicsLabel("assets/icons/samsung_icon.png", "Samsung", () {
          emptyFunction("samsung");
        }),
        electronicsLabel("assets/icons/tablet_icon.png", "Tablets", () {
          emptyFunction("tablet");
        }),
        electronicsLabel("assets/icons/tv_icon.png", "Televisions", () {
          emptyFunction("television");
        })
      ],
    );
  }

  Widget electronicsLabel(String path, String label, void Function() ontap) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: ontap,
          child: Image.asset(
            path,
            height: _height / 12,
            width: _width / 12,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Flexible(
          child: Text(
            label,
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }

  Widget topicContainer(String topic, void Function() onTap) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(topic, style: const TextStyle(fontSize: 16)),
          GestureDetector(
            onTap: onTap,
            child: Text(
              'Show all',
              style: TextStyle(
                color: Colors.orange[300],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget clipShape() {
    return Stack(
      children: <Widget>[
        Clip(
            height: _height,
            opacity: 0.75,
            denominator: 3,
            clipper: CustomShapeClipper()),
        Clip(
            height: _height,
            opacity: 0.5,
            denominator: 3.5,
            clipper: CustomShapeClipper2()),
        Clip(
            height: _height,
            opacity: 0.25,
            denominator: 3,
            clipper: CustomShapeClipper3()),
        Container(
          margin: EdgeInsets.only(left: 40, right: 40, top: _height / 3.75),
          child: Material(
            borderRadius: BorderRadius.circular(30.0),
            elevation: 8,
            child: Container(
              child: TextFormField(
                controller: searchController,
                cursorColor: Colors.orange[200],
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.orange[200],
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, SEARCH_SCREEN,
                          arguments: searchController.text);
                    },
                  ),
                  hintText: "What're you looking for?",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: _height / 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Opacity(
                opacity: 0.5,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: GestureDetector(
                    onTap: () {
                      scaffoldKey.currentState!.openDrawer();
                    },
                    child: Image.asset(
                      'assets/images/menubutton.png',
                      height: _height / 40,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  height: _height / 20,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          print('Editing location');
                        },
                        child: Icon(
                          Icons.edit_location,
                          color: Colors.white,
                          size: _height / 40,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text('Johannesburg',
                            style: TextStyle(
                                color: Colors.white, fontSize: _height / 50),
                            softWrap: false),
                      ),
                    ],
                  ),
                ),
              ),
              Opacity(
                opacity: 0.5,
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.notifications,
                    color: Colors.black,
                    size: _height / 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    final controller = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      key: scaffoldKey,
      drawer: GadgetDrawer(
          height: _height,
          username: controller.user.userName,
          email: controller.user.email),
      bottomNavigationBar: const BottomNavAppBar(),
      floatingActionButton: fab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SizedBox(
        height: _height,
        width: _width,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              clipShape(),
              labelsGrid(),
              const Divider(),
              topicContainer("Cell-Phones", () {
                Navigator.pushNamed(context, SEARCH_SCREEN,
                    arguments: "cellphone");
              }),
              AdList(
                  height: _height / 4,
                  keyword: "cellphone",
                  provider: controller.getAdsByKey("cellphone"),
                  direction: Axis.horizontal),
              const Divider(),
              topicContainer("Computers", () {
                Navigator.pushNamed(context, SEARCH_SCREEN,
                    arguments: "computer");
              }),
              AdList(
                  height: _height / 4,
                  keyword: "Computer",
                  provider: controller.getAdsByKey("Computer"),
                  direction: Axis.horizontal),
              const Divider(),
              topicContainer("Apple", () {
                Navigator.pushNamed(context, SEARCH_SCREEN, arguments: "apple");
              }),
              AdList(
                  height: _height / 4,
                  keyword: "Apple",
                  provider: controller.getAdsByKey("Apple"),
                  direction: Axis.horizontal),
            ],
          ),
        ),
      ),
    );
  }
}
