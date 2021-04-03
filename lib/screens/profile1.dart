import 'package:flutter/material.dart';
import 'package:ChatApp/screens/home.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _nameController = TextEditingController();

   Future<void> onPressed() async{
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Name"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _nameController,
              )
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Confirm")),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              CircleAvatar(
                radius: 50,
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      _nameController.text == ""
                          ? "Full Name"
                          : _nameController.text,
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    RaisedButton(
                      color: Colors.amber,
                        onPressed: () {
                          onPressed();
                        },
                        child: Text("Edit",
                            style: TextStyle(
                              fontSize: 24,
                            ))),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  
                  RaisedButton(
                      color: Colors.amber,
                      child:
                          Text("NEXT", style: TextStyle(color: Colors.black  ,fontSize: 24)),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
