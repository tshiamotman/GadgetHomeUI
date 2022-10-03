import 'package:flutter/material.dart';
import 'package:gadgethome/component/customshape.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
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
            ],
          ),
          child
        ],
      ),
    );
  }
}
