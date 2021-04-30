import 'package:flutter/material.dart';
import 'package:ChatApp/screens/home.dart';


class Status extends StatefulWidget {
  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 14,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    dense: false,
                    isThreeLine: false,
                    title: Text(
                      "Current Status",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    subtitle: Text(
                      currentUser.status
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
