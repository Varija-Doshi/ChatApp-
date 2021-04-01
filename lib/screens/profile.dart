import 'package:flutter/material.dart';
import 'package:ChatApp/screens/home.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _nameController = TextEditingController();

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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(" User logged in ", style: TextStyle(fontSize: 30)),
              SizedBox(height: 40),
              TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      
                      labelText: 'Full Name',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  
                  RaisedButton(
                      color: Colors.black,
                      child:
                          Text("NEXT", style: TextStyle(color: Colors.white)),
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
