import 'package:flutter/material.dart';
import 'package:ChatApp/screens/profile1.dart';
import 'package:ChatApp/widgets/theme.dart';

class Home extends StatefulWidget {
  final String phone_no;
  Home(this.phone_no);
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  String phoneNo;
  bool _theme = true; // true => light , false  => dark

  TabController _tabController;
  final List chats = [
    "chat 1",
    "chat 2",
    "chat 3",
    "chat 4",
    "chat 5",
    "chat 6",
    "chat 7",
    "chat 8",
    "chat 9"
  ];
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

  Widget buildChats() {
    return ListView.builder(
      itemCount: chats.length,
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
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 16.0, color: Colors.lightBlue.shade50),
                borderRadius: BorderRadius.circular(30),
              ),
              title: Text(chats[i],
                  style: TextStyle(color: Colors.black, fontSize: 24)),
            ),
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
            margin: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 5.0),
            decoration: BoxDecoration(
              color: Colors.amber, //Colors.orange[100],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 16.0, color: Colors.lightBlue.shade50),
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
              color: Colors.amber, //Colors.orange[100],
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
            onPressed: () {},
            child: Icon(Icons.message, color: Colors.white),
            backgroundColor: Colors.red)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: buildTheme(_theme),   /*ThemeData(
        appBarTheme: AppBarTheme(
            color: Color(0xFFE5AE86),
            textTheme: TextTheme(
                bodyText1: TextStyle(color: Colors.black, fontSize: 24),
                headline6: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold))),
        brightness: Brightness.dark,
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),*/
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          endDrawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.amber,
                  ),
                  child: Text(
                    'Customise',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text('Profile'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profile(phoneNo)));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Log out'),
                ),
                SwitchListTile(
                  secondary: Icon(Icons.brightness_4_rounded) ,
                    title: _theme? Text("Dark mode" , style :TextStyle(color:Colors.white)):Text("Light mode" ,style :TextStyle(color:Colors.black)),
                    value: _theme,
                    onChanged: (bool value) {
                      setState(() {
                        _theme = value;
                      }); },

                    )
              ],
            ),
          ),
          floatingActionButton: _bottomButtons(),
          appBar: AppBar(
            backgroundColor: Colors.amber[660],
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            title: Text("KahBoo"),
            bottom: TabBar(
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
