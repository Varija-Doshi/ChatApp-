import 'package:flutter/material.dart';
import 'package:ChatApp/screens/profile1.dart';
import 'package:ChatApp/screens/contacts_page.dart';
import 'package:ChatApp/widgets/theme.dart';
import 'package:ChatApp/model/message_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  final String phone_no;
  Home(this.phone_no);
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  String phoneNo;
  bool _theme = false; // true => light , false  => dark

  TabController _tabController;

  final List grpchats = [
    "grp chat 1",
    "grp chat 2",
    "grp chat 3",
    "grp chat 4",
  ];
  final List calls = [
    "call 1",
    "call 2",
    "call 3",
    "call 4",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabIndex);
    phoneNo = widget.phone_no;
  }

  void _handleTabIndex() {
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  bool toggleValue = false;
  toggleButton() {
    setState(() {
      _theme = !_theme;
    });
    buildTheme(_theme);
  }

  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.undetermined;
    } else {
      return permission;
    }
  }

  Widget buildChats() {
    return ListView.builder(
      itemCount: chats == null ? 4 : chats.length,
      itemBuilder: (context, int i) {
        final Message chat = chats[i];
        return Column(children: <Widget>[
          if (i == 0)
            SizedBox(height: 15, width: MediaQuery.of(context).size.width),
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, .0),
            decoration: BoxDecoration(
              color: chat.unread
                  ? Theme.of(context).cardColor
                  : _theme
                      ? Colors.black12
                      : Colors.white, //Colors.orange[100],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0),
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
            ),
            child: ListTile(
                isThreeLine: true,
                trailing: Column(
                  children: <Widget>[
                    Text(
                      chat.time,
                      style: TextStyle(
                        color: Color(0xFF403527),
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    chat.unread
                        ? Container(
                            width: 40.0,
                            height: 20.0,
                            decoration: BoxDecoration(
                              color: _theme ? Colors.blue[900] : Colors.red,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'NEW',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : Text(''),
                  ],
                ),
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundImage: AssetImage(
                      'Assets/Images/30916342.jpg'), // this is dummy profile image
                ),
                shape: RoundedRectangleBorder(
                  side:
                      BorderSide(width: 16.0, color: Colors.lightBlue.shade50),
                  borderRadius: BorderRadius.circular(30),
                ),
                title: Text(chat.sender.name,
                    style: TextStyle(color: Colors.black, fontSize: 24)),
                subtitle: Text(chat.text,
                    style: TextStyle(color: Colors.black87, fontSize: 22))),
          ),
        ]);
      },
    );
  }

  Widget buildGrpChats() {
    return ListView.builder(
      itemCount: grpchats.length,
      itemBuilder: (context, int i) {
        return Column(children: <Widget>[
          if (i == 0)
            SizedBox(height: 15, width: MediaQuery.of(context).size.width),
          Container(
            margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 5.0),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor, //Colors.orange[100],
              shape: BoxShape.rectangle,
              //border:Border.all(width: 2.0, color: Colors.black),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 20.0, color: Colors.lightBlue.shade50),
                borderRadius: BorderRadius.circular(30),
              ),
              title: Text(grpchats[i], style: TextStyle(fontSize: 24)),
            ),
          ),
        ]);
      },
    );
  }

  Widget buildCalls() {
    return ListView.builder(
      itemCount: calls.length,
      itemBuilder: (context, int i) {
        return Column(children: <Widget>[
          if (i == 0)
            SizedBox(height: 15, width: MediaQuery.of(context).size.width),
          Container(
            margin: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 5.0),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor, //Colors.orange[100],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              trailing: Icon(Icons.phone),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 16.0, color: Colors.lightBlue.shade50),
                borderRadius: BorderRadius.circular(30),
              ),
              title: Text(calls[i], style: TextStyle(fontSize: 24)),
            ),
          ),
        ]);
      },
    );
  }

  Widget _bottomButtons() {
    return _tabController.index == 0
        ? FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ContactsPage(title: "Select Contacts")));
            },
            child: Icon(Icons.message, color: Colors.white, size: 30),
            backgroundColor:
                Theme.of(context).floatingActionButtonTheme.foregroundColor)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: buildTheme(_theme),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          endDrawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: 100,
                  color: _theme ? Colors.amber : Colors.red[200],
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: InkWell(
                          onTap: toggleButton,
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 500),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return RotationTransition(
                                turns: animation,
                                child: child,
                              );
                            },
                            child: _theme
                                ? Icon(
                                    Icons.wb_sunny_rounded,
                                    color: Colors.yellow,
                                    size: 40,
                                    key: UniqueKey(),
                                  )
                                : Icon(
                                    Icons.nights_stay_sharp,
                                    color: Colors.blue[900],
                                    size: 40,
                                    key: UniqueKey(),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.account_circle, size: 35),
                  title: Text('Profile', style: GoogleFonts.lato(fontSize: 24)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profile(phoneNo)));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.group_add, size: 35),
                  title:
                      Text('New group', style: GoogleFonts.lato(fontSize: 24)),
                  onTap: () async {
                    final PermissionStatus permissionStatus =
                        await _getPermission();
                    if (permissionStatus == PermissionStatus.granted) {
                      //We can now access our contacts here
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ContactsPage(title: "New Group")));
                    } else {
                      return showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: Text('Permissions error'),
                                content: Text('Please enable contacts access '
                                    'permission in system settings'),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text(
                                      'OK',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    textColor: Colors.black,
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  )
                                ],
                              ));
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings, size: 35),
                  title:
                      Text('Settings', style: GoogleFonts.lato(fontSize: 24)),
                ),
                ListTile(
                  leading: Icon(Icons.logout, size: 35),
                  title: Text('Log out', style: GoogleFonts.lato(fontSize: 24)),
                ),
              ],
            ),
          ),
          floatingActionButton: _bottomButtons(),
          appBar: AppBar(
            title: Text("KahBoo"),
            bottom: TabBar(
              labelColor: Theme.of(context).tabBarTheme.labelColor,
              unselectedLabelColor:
                  Theme.of(context).tabBarTheme.unselectedLabelColor,
              controller: _tabController,
              tabs: [
                Tab(
                    child: Text("Chats",
                        style: TextStyle(color: Colors.black, fontSize: 22))),
                Tab(
                    child: Text("Groups",
                        style: TextStyle(color: Colors.black, fontSize: 22))),
                Tab(
                  child: Text("Calls",
                      style: TextStyle(color: Colors.black, fontSize: 22)),
                  icon: Icon(Icons.phone, color: Colors.black),
                ),
              ],
            ),
          ),
          body: TabBarView(controller: _tabController, children: [
            buildChats(),
            buildGrpChats(),
            buildCalls(),
          ]),
        ),
      ),
    );
  }
}
