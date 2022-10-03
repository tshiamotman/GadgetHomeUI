import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gadgethome/component/adlist.dart';
import 'package:gadgethome/component/customshape.dart';
import 'package:gadgethome/component/bottomappbar.dart';
import 'package:gadgethome/component/gadgetdrawer.dart';
import 'package:gadgethome/constants/constants.dart';
import 'package:gadgethome/controllers/userprovider.dart';
import 'package:gadgethome/models/ad.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  final searchKey;
  const SearchScreen({Key? key, required this.searchKey}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late double _height;
  late double _width;

  late String searchKey;

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
    searchKey = widget.searchKey;
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
            elevation: 4,
            child: TextFormField(
              cursorColor: Colors.orange[200],
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search, color: Colors.orange[200], size: 30),
                  onPressed: () {
                    setState(() {
                      searchKey = searchController.text;
                    });
                  },
                ),
                hintText: searchKey,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none),
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
      drawer: GadgetDrawer(
          height: _height,
          username: controller.user.userName,
          email: controller.user.email),
      bottomNavigationBar: const BottomNavAppBar(),
      floatingActionButton: fab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: <Widget>[
          clipShape(),
          const Divider(),
          Expanded(
            child: buildList(
              controller.getAdsByKey(searchKey),
            ),
          )
        ],
      ),
    );
  }

  Widget buildList(Future<List<Ad>> provider) {
    return FutureBuilder(
      future: provider,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.error != null) {
            return const Center(
              child: Text("Failed to load"),
            );
          } else {
            return Consumer<UserProvider>(
              builder: (context, controller, child) => ListView.builder(
                padding: const EdgeInsets.all(5),
                itemCount: controller.ads[searchKey] == null
                    ? 0
                    : controller.ads[searchKey]!.length,
                itemBuilder: (BuildContext context, index) {
                  Ad ad = controller.ads[searchKey]![index];
                  return SizedBox(
                      height: _height / 4, child: ad.build(context));
                },
              ),
            );
          }
        }
      },
    );
  }
}
