import 'package:flutter/material.dart';
import 'package:ChatApp/screens/home.dart';

class Profile extends StatefulWidget {
  final String phone_no;
  Profile(this.phone_no);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  String phoneNo;

  @override
  void initState() {
    phoneNo = widget.phone_no;
    super.initState();
  }

  Future<void> onPressed(String _input, var _controller) async {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(_input),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _controller,
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
                height: 70,
              ),
              CircleAvatar(
                backgroundColor: Colors.grey[400],
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1459802071246-377c0346da93?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1795&q=80'),
                radius: 80,
              ),
              Positioned(
                child: SizedBox(
                  child: FlatButton(
                    color: Colors.green[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80),
                      side: BorderSide(color: Colors.red),
                    ),
                    child: Text("Image"),
                    /*child: Image(
                      image: AssetImage(null),
                    ),*/
                    onPressed: null,
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Text(
                "Phone Number : " + phoneNo,
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: MediaQuery.of(context).size.width / 13),
                    Text(
                      _nameController.text == ""
                          ? "Full Name"
                          : _nameController.text,
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      iconSize: 27,
                      splashRadius: 27,
                      onPressed: () {
                        onPressed("Name", _nameController);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: MediaQuery.of(context).size.width / 13),
                    Text(
                      _statusController.text == ""
                          ? "Status"
                          : _nameController.text,
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                      color: Colors.amber,
                      child: Text("NEXT",
                          style: TextStyle(color: Colors.black, fontSize: 24)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home(phoneNo)));
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
