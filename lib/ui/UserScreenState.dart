import 'dart:convert';

import 'package:LoginUI/network/Github.dart';
import 'package:LoginUI/ui/UserScreen.dart';
import 'package:flutter/material.dart';

class UserScreenState extends State<UserScreen> with TickerProviderStateMixin {
  double USER_IMAGE_SIZE = 200.0;

  dynamic getUserResponse;
  List<dynamic> users;
  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text("Search Github Users...");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
        body: new Column(
      children: <Widget>[toolbarAndroid(), listVIew()],
    ));
  }


  listVIew() {
    return new Expanded(
        child: new ListView.builder(
            padding: new EdgeInsets.all(8.0),
            itemCount: users == null ? 0 : users.length,
            itemBuilder: (BuildContext context, int index) {
              return new Column(children: <Widget>[new ListTile(
                title: Text('title ${users[index]['login']}'),
              ),new Image.network(users[index]['avatar_url'],width: 200.0,height: 200.0)]);
            }));
  }

  toolbarAndroid() {
    return new AppBar(
      centerTitle: false,
      title: appBarTitle,
      actions: <Widget>[
        new IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(Icons.close);
                  this.appBarTitle = new TextField(
                    onChanged: (string) {
                      searchUser(widget, string);
                    },
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                    decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search, color: Colors.white),
                        hintText: "Search...",
                        hintStyle: new TextStyle(color: Colors.white)),
                  );
                } else {
                  this.actionIcon = new Icon(Icons.search);
                  this.appBarTitle = new Text("Search Github Users...");
                }
              });
            })
      ],
    );
  }

  searchUser(UserScreen widget, String string) {
    Github.getUsersBySearch(widget.data, string).then((response) {
      this.setState(() {
        print("Response ");
        getUserResponse = json.decode(response.body);
        users = getUserResponse['items'] as List;
        print(users);
        //print(getUserResponse);
      });
    });
  }
}
