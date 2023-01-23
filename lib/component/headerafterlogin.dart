import 'package:flutter/material.dart';
import 'package:gadgethome/component/customshape.dart';

class HeaderAfterLogin extends StatelessWidget {
  final Widget child;
  final GlobalKey<ScaffoldState> scaffoldKey;

  HeaderAfterLogin({
    Key? key,
    required this.scaffoldKey,
    required this.child,
  }) : super(key: key);

  final locationController = TextEditingController(text: "Johannesburg");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                Clip(
                    height: size.height,
                    opacity: 0.75,
                    denominator: 3,
                    clipper: CustomShapeClipper()),
                Clip(
                    height: size.height,
                    opacity: 0.5,
                    denominator: 3.5,
                    clipper: CustomShapeClipper2()),
                Clip(
                    height: size.height,
                    opacity: 0.25,
                    denominator: 3,
                    clipper: CustomShapeClipper3()),
                Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: size.height / 20),
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
                              child: TextField(
                                controller: locationController,
                                decoration: const InputDecoration(labelText: "Location"),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            height: size.height / 20,
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
                                    size: size.height / 40,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text('Johannesburg',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: size.height / 50),
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
                              size: size.height / 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            child
          ],
        ),
      ),
    );
  }
}
