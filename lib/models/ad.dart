import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gadgethome/models/user.dart';

class Ad {
  int? id;
  DateTime datePosted;
  String model;
  String brand;
  String device;
  String description;
  String location;
  double price;
  User seller;
  List<Uint8List> images = [];

  Ad(this.id, this.datePosted, this.model, this.brand, this.device,
      this.description, this.location, this.price, this.seller);

  void addImage(Uint8List image) {
    images.add(image);
  }

  factory Ad.fromJson(Map<String, dynamic> json) {
    return Ad(
        json['id'],
        DateTime.parse(json['datePosted']),
        json['model'],
        json['brand'],
        json['device'],
        json['description'] ?? "",
        json['location'] ?? "",
        json['amount'],
        User.fromJson(json['owner']));
  }

  Map<String, dynamic> toJson() => {
        'datePosted': datePosted,
        'model': model,
        'brand': brand,
        'device': device,
        'description': description,
        'location': location,
        'amount': price,
        'owner': seller.toJson()
      };

  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.only(left: 10, top: 10, right: 5, bottom: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: _height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${brand.toUpperCase()} $model",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: _height / 40),
                  ),
                  Container(
                    width: _width / 2.75,
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            price.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            color: Colors.grey[200],
                            child: Text(
                              device,
                              // softWrap: true,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Flexible(
                    child: Container(
                        width: _width / 2.5,
                        child: Text(
                          description,
                          style: TextStyle(
                            fontSize: _height / 70,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          // softWrap: true,
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: Container(
                      width: _width / 2.75,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  size: _height / 65,
                                ),
                                Text(
                                  location,
                                  style: TextStyle(fontSize: _height / 65),
                                )
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "${datePosted.day}-${[
                                  'Jan',
                                  'Feb',
                                  'Mar',
                                  'Apr',
                                  'May',
                                  'Jun',
                                  'Jul',
                                  'Aug',
                                  'Sept',
                                  'Oct',
                                  'Nov',
                                  'Dec'
                                ][datePosted.month]}-${datePosted.year}",
                                style: TextStyle(fontSize: _height / 65),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
                width: _width / 2.5,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Image.memory(
                  images[0],
                  fit: BoxFit.cover,
                  height: _height / 4,
                  width: _width / 4,
                )),
          ],
        ),
      ),
    );
  }
}
