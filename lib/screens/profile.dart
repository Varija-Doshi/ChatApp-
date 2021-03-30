import 'package:flutter/material.dart';
import 'package:ChatApp/screens/home.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(" User logged in ", style: TextStyle(fontSize: 30)),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                RaisedButton(
                  color: Colors.black,
                  child: Text("NEXT" , style:TextStyle(color: Colors.white)),
                  onPressed: (){
                Navigator.push(context, MaterialPageRoute(
              builder: (context) => Home()) );
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
