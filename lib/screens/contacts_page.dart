import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactsPage extends StatefulWidget {
  String title;
  ContactsPage({this.title});
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  Iterable<Contact> _contacts;
  int length;

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
                              builder: (context) => ContactsPage(title:"New Group")));
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
      itemCount: widget.title == "New Group" ? length : (length + 1),
      itemBuilder: (BuildContext context, int index) {
        if (widget.title == "New Group") {
          Contact contact = _contacts?.elementAt(index);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: _contacts != null
          //Build a list view of all contacts, displaying their avatar and
          // display name
          ? _listview()
          : Center(child: const CircularProgressIndicator()),
    );
  }
}
