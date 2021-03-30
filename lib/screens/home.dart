import 'package:flutter/material.dart';

class Home extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            title: Text("KahBoo"),
            bottom: TabBar(
              tabs: [
                Tab(text: "Chats"),
                Tab(text: "Groups"),
                Tab(text: "Calls"),
              ],
            ),
          ),
          body: TabBarView(children: [
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ]),
        ),
      ),
    );
  }
}
