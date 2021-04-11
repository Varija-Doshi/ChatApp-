import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:google_fonts/google_fonts.dart';

// the list tiles are not having a rounded shape
class ContactsPage extends StatefulWidget {
  final String title;
  ContactsPage({this.title});
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  Iterable<Contact> _contacts;
  List<Contact> _selectedContacts = [];
  List<bool> isSelected = [];
  int length;
  List<Color> tileColor = <Color>[];

  @override
  void initState() {
    getContacts();
    super.initState();
  }

  Future<void> getContacts() async {
    //Make sure we already have permissions for contacts when we get to this
    //page, so we can just retrieve it
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
      length = _contacts.length;
      for (int i = 0; i < length; i++) {
        isSelected.add(false);
        tileColor.add(Colors.white);
      }
    });
  }

  Widget _buildbuttons() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 5),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            color: Theme.of(context).buttonColor,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ContactsPage(title: "New Group")));
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(Icons.group_add,
                    size: 30, color: Theme.of(context).primaryIconTheme.color),
                Text(
                  "New group",
                  style: GoogleFonts.lato(fontSize: 24, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _listview() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.title == "New Group" ? length : (length + 1),
      itemBuilder: (BuildContext context, int index) {
        if (widget.title == "New Group") {
          Contact contact = _contacts?.elementAt(index);
          return Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 16.0, color: Colors.lightBlue.shade50),
                    borderRadius: BorderRadius.circular(20)),
                selected: isSelected[index],
                selectedTileColor: tileColor[index],
                onTap: () {
                  setState(() {
                    isSelected[index] = !isSelected[index];

                    if (tileColor[index] == Colors.white) {
                      tileColor[index] = Colors.blue[100];
                      _selectedContacts.add(contact);
                    } else {
                      tileColor[index] = Colors.white;
                      _selectedContacts.remove(contact);
                    }
                  });
                },

                leading: isSelected[index]
                    ? Icon(Icons.done, color: Colors.blue, size: 35)
                    : (contact.avatar != null && contact.avatar.isNotEmpty)
                        ? CircleAvatar(
                            backgroundImage: MemoryImage(contact.avatar),
                          )
                        : CircleAvatar(
                            child: Text(contact.initials()),
                            backgroundColor: Theme.of(context).accentColor,
                          ),
                title: Text(contact.displayName ?? '',
                    style: GoogleFonts.lato(fontSize: 24, color: Colors.black)),
                subtitle: Text(" Hey There! I'm using KahBoo ",
                    style: GoogleFonts.lato(fontSize: 20, color: Colors.grey)),
                //This can be further expanded to showing contacts detail
                // onPressed().
              ));
        } else {
          if (index == 0)
            return _buildbuttons();
          else {
            Contact contact = _contacts?.elementAt(index - 1);
            return ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
              leading: (contact.avatar != null && contact.avatar.isNotEmpty)
                  ? CircleAvatar(
                      backgroundImage: MemoryImage(contact.avatar),
                    )
                  : CircleAvatar(
                      child: Text(contact.initials()),
                      backgroundColor: Theme.of(context).accentColor,
                    ),
              title: Text(contact.displayName ?? '',
                  style: GoogleFonts.lato(fontSize: 24, color: Colors.black)),
              subtitle: Text(" Hey There! I'm using KahBoo ",
                  style: GoogleFonts.lato(fontSize: 20, color: Colors.grey)),
              //This can be further expanded to showing contacts detail
              // onPressed().
            );
          }
        }
      },
    );
  }

  Widget selectedDisplay() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: _selectedContacts.length,
        itemBuilder: (BuildContext context, int i) {
          return _selectedContacts[i].avatar != null &&
                  _selectedContacts[i].avatar.isNotEmpty
              ? Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage:
                              MemoryImage(_selectedContacts[i].avatar),
                        ),
                        Text(_selectedContacts[i].displayName),
                      ],
                    ),
                    SizedBox(width: 10),
                  ],
                )
              : Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        CircleAvatar(
                          child: Text(_selectedContacts[i].initials(),
                              style: TextStyle(color: Colors.white)),
                          backgroundColor: Theme.of(context).accentColor,
                        ),
                        Text(_selectedContacts[i].displayName),
                      ],
                    ),
                    SizedBox(width: 10),
                  ],
                );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.navigate_next, size: 30, color: Colors.white),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: ListTile(
          title: Text(widget.title,
              style: GoogleFonts.lato(fontSize: 20, color: Colors.black)),
          subtitle: Text(
              widget.title == "New Group"
                  ? "Add participants"
                  : "${_contacts?.length} Contact(s)",
              style: GoogleFonts.lato(fontSize: 16, color: Colors.black)),
        ),
      ),
      body: Column(
        children: <Widget>[
          if (_selectedContacts != null && _selectedContacts.isNotEmpty)
            Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              height: 90,
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 0.75, color: Colors.black)),
              ),
              child: selectedDisplay(),
            ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: _contacts != null
                  ? _listview()
                  : Center(child: const CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
