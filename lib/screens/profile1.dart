import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

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
                height: 80,
              ),
              CircleAvatar(
                radius: 80,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
