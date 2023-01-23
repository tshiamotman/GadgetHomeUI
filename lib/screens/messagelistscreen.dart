import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gadgethome/component/bottomappbar.dart';
import 'package:gadgethome/component/gadgetdrawer.dart';
import 'package:gadgethome/controllers/messageprovider.dart';
import 'package:gadgethome/controllers/userprovider.dart';
import 'package:gadgethome/models/chat.dart';
import 'package:provider/provider.dart';

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MessageListScreen();
}

class _MessageListScreen extends State<MessageListScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late double _height;
  late double _width;

  final searchController = TextEditingController();

  late String searchKey;

  @override
  void initState() {
    super.initState();
    searchKey = "";
  }

  Widget conversationTile(
      BuildContext context, String username, Chat chat, Uint8List image) {
    double tileWidth = MediaQuery.of(context).size.width;
    double tileHeight = MediaQuery.of(context).size.height;

    String postName = "${chat.post!.brand.toUpperCase()} ${chat.post!.model}";
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
              height: tileHeight,
              width: tileWidth / 5,
              child: Center(
                child: CircleAvatar(backgroundImage: MemoryImage(image)),
              ),
            ),
            SizedBox(
              height: tileHeight,
              width: tileWidth * (4 / 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Title(color: Colors.black, child: Text(username)),
                      Text(chat.createdDate.toString())
                    ],
                  ),
                  Title(color: Colors.grey, child: Text(postName)),
                  Text(chat.message)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget header(BuildContext context, Uint8List image) {
    double headerHeight = MediaQuery.of(context).size.height;
    double headerWidth = MediaQuery.of(context).size.width;
    _width = MediaQuery.of(context).size.width;
    return AppBar(
      title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
            child: Row(
          children: [
            SizedBox(
              height: headerHeight,
              width: headerWidth / 5,
              child: Center(
                child: CircleAvatar(backgroundImage: MemoryImage(image)),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      searchKey = searchController.text;
                    });
                  },
                ),
                hintText: 'Search...',
                border: InputBorder.none,
              ),
            ),
          ],
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;

    final userController = Provider.of<UserProvider>(context, listen: false);
    final provider = Provider.of<MessageProvider>(context, listen: false);

    return Scaffold(
      key: scaffoldKey,
      appBar: header(context, userController.userProfilePicture),
      drawer: GadgetDrawer(
          height: _height,
          username: userController.user.userName,
          email: userController.user.email),
      bottomNavigationBar: const BottomNavAppBar(),
      body: SizedBox(
          height: _height,
          width: _width,
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: provider.getUserConversations(),
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
                      child: Consumer<MessageProvider>(
                        builder: (context, controller, child) =>
                            ListView.builder(
                          padding: const EdgeInsets.all(5),
                          shrinkWrap: true,
                          itemCount: controller.conversations.length,
                          itemBuilder: (BuildContext context, index) {
                            Chat chat = snapshot.data![index][0];
                            String username = userController.user.userName ==
                                    chat.senderUsername
                                ? chat.recipientUsername
                                : chat.senderUsername;

                            Uint8List? image =
                                controller.profilePictures[username];

                            return GestureDetector(
                              onTap: () {
                                //Navigator.of(context).pushNamed(DETAIL_UI);
                                print("Routing to detail page");
                              },
                              child: conversationTile(
                                  context, username, chat, image!),
                            );
                          },
                        ),
                      ),
                    );
                  }
                }
              },
            ),
          )),
    );
  }
}
