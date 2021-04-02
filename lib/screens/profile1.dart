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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
