import 'dart:io' as drt;

import 'package:ChatApp/widgets/Day_Night_Switch.dart';
import 'package:flutter/material.dart';
import 'package:ChatApp/screens/home.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ChatApp/widgets/Day_Night_Switch.dart';

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
  static ImageProvider _pic;
  static drt.File _image;
  static var image;
  bool imagetype;

  @override
  void initState() {
    phoneNo = widget.phone_no;
    super.initState();
  }

  Future<void> openDialog() async {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Choose",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      iconSize: 40,
                      icon: Icon(Icons.camera_alt),
                      onPressed: () {
                        setState(() {
                          imagetype = true;
                        });
                        Navigator.of(context).pop();
                        _getImage();
                      },
                      tooltip: "Camera",
                    ),
                    Text("Camera",
                        style: GoogleFonts.roboto(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      iconSize: 40,
                      icon: Icon(Icons.photo),
                      onPressed: () {
                        setState(() {
                          imagetype = false;
                        });
                        Navigator.of(context).pop();
                        _getImage();
                      },
                      tooltip: "Gallery",
                    ),
                    Text("Gallery",
                        style: GoogleFonts.roboto(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ],
                ),
              ]),
        );
      },
    );
  }

  Future _getImage() async {
    if (imagetype)
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    else
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        _image = image;
        _pic = Image.file(_image).image;
      }
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
                          ? AssetImage('Assets/Images/30916342.jpg')
                          : _pic,
                    ),
                    Positioned(
                      right: -12,
                      bottom: 0,
                      child: SizedBox(
                        height: 46,
                        width: 46,
                        child: FlatButton(
                          padding: EdgeInsets.zero,
                          onPressed: openDialog,
                          color: Colors.grey[350],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: Colors.white),
                          ),
                          child: SvgPicture.asset(
                            "Assets/Icons/Camera Icon.svg",
                            fit: BoxFit.fill,
                          ),
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
                width: MediaQuery.of(context).size.width - 14,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: ListTile(
                        dense: false,
                        isThreeLine: false,
                        title: Text(
                          "Name",
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                        subtitle: Text(
                          name == "" ? "Full Name" : name,
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
                            flag = true;
                            onPressed("Name", _nameController);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 14,
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
                    },
                  ),
                ],
              ),
              SizedBox(height: 40, width: 40, child: Day_Night_Switch()),
            ],
          ),
        ),
      ),
    );
  }
}
