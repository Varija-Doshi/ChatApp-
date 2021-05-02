import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as drt;

class NewGroup extends StatefulWidget {
  final List<Contact> selectedContacts;
  NewGroup(this.selectedContacts);
  @override
  State<StatefulWidget> createState() => _NewGroupState();
}

class _NewGroupState extends State<NewGroup> {
  final TextEditingController _grpNameController = TextEditingController();
  static drt.File _image;
  static var image;
  bool imagetype;

  Future _getImage() async {
    if (imagetype)
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    else
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        _image = image;
      }
    });
  }

  Future<void> openPhotoDialog() async {
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

  Widget listView() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: widget.selectedContacts.length,
      itemBuilder: (context, i) {
        return widget.selectedContacts[i].avatar != null &&
                widget.selectedContacts[i].avatar.isNotEmpty
            ? Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            MemoryImage(widget.selectedContacts[i].avatar),
                      ),
                      Text(
                        widget.selectedContacts[i].displayName,
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          
                          color: Colors.black,
                        ),
                      ),
                      /*SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      )*/
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width* 0.04),
                ],
              )
            : Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 25,
                        child: Text(widget.selectedContacts[i].initials(),
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Theme.of(context).accentColor,
                      ),
                      Text(
                        widget.selectedContacts[i].displayName,
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                         
                          color: Colors.black,
                        ),
                      ),
                      /*SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      )*/
                    ],
                  ),
                  SizedBox(width:  MediaQuery.of(context).size.width* 0.04),
                ],
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Group"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          GestureDetector(
            onTap: () {
              openPhotoDialog();
            },
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[400],
              backgroundImage: _image == null
                  ? AssetImage('Assets/Images/30916342.jpg')
                  : image,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 50,
            child: TextField(
              style: GoogleFonts.roboto(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              controller: _grpNameController,
              decoration: InputDecoration(
                labelStyle: GoogleFonts.montserrat(
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                border: UnderlineInputBorder(borderSide: BorderSide.none),
                labelText: "Group Name",
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                filled: true,
                enabled: true,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0)),
                fillColor: Colors.grey.withOpacity(0.7),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0)),
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Divider(
            color: Colors.grey[350],
            thickness: 1.0,
          ),
          Text(
            "Participants: ${widget.selectedContacts.length} ",
            style: GoogleFonts.montserrat(
             
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Expanded(
            child: Padding(
              padding:EdgeInsets.all(15),
              child: listView(),
            ),
          ),
        ],
      ),
    );
  }
}
