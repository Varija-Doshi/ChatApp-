import 'package:flutter/material.dart';
import 'package:ChatApp/screens/home.dart';
import 'package:ChatApp/model/user_model.dart';

class Status extends StatefulWidget {
  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {
  List currentMe = ["Sleeping", "Happy", "Sad", "GOODBYE", "Busy", "Fuck You"];

  Widget listView() {
    return ListView.builder(
      itemCount: currentMe.length,
      itemBuilder: (context, i) {
        return ListTile(title: Text(currentMe[i]));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: Column(
        ///crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 10,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    dense: false,
                    isThreeLine: true,
                    title: Text(
                      "Status",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    subtitle: Text(
                      currentUser.status == ""
                          ? "Hey There"
                          : currentUser.status,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      color: Colors.black,
                      iconSize: 27,
                      splashRadius: 27,
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: listView(),
          ),
        ],
      ),
    );
  }
}
