import 'dart:html';
import 'dart:io' as drt;

import 'package:flutter/material.dart';
import 'package:ChatApp/screens/home.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  final String phone_no;
  Profile(this.phone_no);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  static String phoneNo, name = '', status = '';
  bool flag = true;
  drt.File _image;

  @override
  void initState() {
    phoneNo = widget.phone_no;
    super.initState();
  }

  Future _getImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
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
                setState(() {
                  if (flag) {
                    name = _controller.text;
                  } else
                    status = _controller.text;
                });
                Navigator.of(context).pop();
              },
              child: Text("Confirm"),
            ),
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 70,
              ),
              SizedBox(
                height: 150,
                width: 150,
                child: Stack(
                  fit: StackFit.expand,
                  overflow: Overflow.visible,
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.grey[400],
                        backgroundImage: _image == null
                            ? NetworkImage(
                                'https://images.unsplash.com/photo-1459802071246-377c0346da93?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1795&q=80')
                            : Image.file(_image)),
                    Positioned(
                      right: -12,
                      bottom: 0,
                      child: SizedBox(
                        height: 46,
                        width: 46,
                        child: FlatButton(
                          onPressed: _getImage,
                          color: Colors.grey[350],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: Colors.white),
                          ),
                          child:
                              SvgPicture.asset("Assets/Icons/Camera Icon.svg"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Text(
                "Phone Number : " + phoneNo,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 45,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      name == "" ? "Full Name" : name,
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      iconSize: 27,
                      splashRadius: 27,
                      onPressed: () {
                        flag = true;
                        onPressed("Name", _nameController);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: ListTile(
                        dense: false,
                        isThreeLine: true,
                        title: Text(
                          "Status",
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                        subtitle: Text(
                          status == "" ? "Hey There" : status,
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
                          onPressed: () {
                            flag = false;
                            onPressed("Status", _statusController);
                          },
                        ),
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
/*SizedBox(
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
              SizedBox(
                width: MediaQuery.of(context).size.width - 74,
                child: Text(
                  "Name",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 70,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _nameController.text == ""
                          ? "Full Name"
                          : _nameController.text,
                      style: TextStyle(
                        fontSize: 24,
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
                width: MediaQuery.of(context).size.width - 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: ListTile(
                        dense: false,
                        isThreeLine: true,
                        title: Text(
                          "Status",
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                        subtitle: Text(
                          _statusController.text == ""
                              ? "Hey There"
                              : _statusController.text,
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
                          onPressed: () {
                            onPressed("Status", _statusController);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),*/
