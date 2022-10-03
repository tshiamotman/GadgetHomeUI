import 'package:flutter/material.dart';
import 'package:gadgethome/controllers/userprovider.dart';
import 'package:gadgethome/models/ad.dart';
import 'package:provider/provider.dart';

class AdList extends StatelessWidget {
  const AdList({
    Key? key,
    required double height,
    required this.keyword,
    required this.provider,
    required this.direction,
  })  : _height = height,
        super(key: key);

  final double _height;
  final String keyword;
  final Future<List<Ad>> provider;
  final Axis direction;

  @override
  Widget build(BuildContext context) {
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
            return SizedBox(
              height: _height,
              child: Consumer<UserProvider>(
                builder: (context, controller, child) => ListView.builder(
                  padding: const EdgeInsets.all(5),
                  shrinkWrap: true,
                  itemCount: controller.ads[keyword] == null
                      ? 0
                      : controller.ads[keyword]!.length,
                  scrollDirection: direction,
                  itemBuilder: (BuildContext context, index) {
                    Ad ad = controller.ads[keyword]![index];
                    return GestureDetector(
                      onTap: () {
                        //Navigator.of(context).pushNamed(DETAIL_UI);
                        print("Routing to detail page");
                      },
                      child: ad.build(context),
                    );
                  },
                ),
              ),
            );
          }
        }
      },
    );
  }
}
