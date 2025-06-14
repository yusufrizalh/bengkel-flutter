import 'package:flutter/material.dart';
import 'package:flutter_lab/main.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard Page"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(100, 0, 0, 1),
        // leading: Icon(Icons.dashboard_customize),
        actions: <Widget>[
          IconButton(
            onPressed: () => debugPrint("Settings"),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
          side: BorderSide(color: Colors.white, width: 1),
        ),
        backgroundColor: Color.fromRGBO(100, 0, 0, 1),
        child: ListView(
          children: <Widget>[
            buildDrawerHeader(context),
            ListTile(
              leading: Icon(Icons.home, size: 26, color: Colors.white),
              title: Text(
                "Home",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.file_present, size: 26, color: Colors.white),
              title: Text(
                "Files",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.data_exploration,
                size: 26,
                color: Colors.white,
              ),
              title: Text(
                "Statistics",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.production_quantity_limits,
                size: 26,
                color: Colors.white,
              ),
              title: Text(
                "Products",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.help, size: 26, color: Colors.white),
              title: Text(
                "Help",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onTap: () {},
            ),
            Divider(color: Colors.white),
            ExpansionTile(
              title: Text(
                "User",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              leading: Icon(Icons.person, size: 26, color: Colors.white),
              trailing: Icon(Icons.arrow_drop_down, color: Colors.white),
              textColor: Colors.white,
              iconColor: Colors.white,
              collapsedTextColor: Colors.white,
              collapsedIconColor: Colors.white,
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.person_pin,
                    size: 26,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Profile",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.logout, size: 26, color: Colors.white),
                  title: Text(
                    "Logout",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        // children: <Widget>[
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> drawerData = [
  {"title": "Dashboard", "icon": Icons.dashboard, "route": "/dashboard"},
  {"title": "Profile", "icon": Icons.person, "route": "/profile"},
  {"title": "Settings", "icon": Icons.settings, "route": "/settings"},
  {"title": "Notifications", "icon": Icons.notifications, "route": "/notif"},
  {"title": "Messages", "icon": Icons.message, "route": "/messages"},
  {"title": "About", "icon": Icons.info, "route": "/about"},
  {"title": "Help", "icon": Icons.help, "route": "/help"},
];

Widget buildDrawerItem(Map<String, dynamic> item) {
  return ListTile(
    leading: Icon(item['icon']),
    title: Text(item['title']),
    onTap: () {
      //Navigator.pushNamed(context, item['route']);
    },
  );
}

Widget buildDrawerHeader(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(2),
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.4,
    child: DrawerHeader(
      decoration: BoxDecoration(
        color: Color.fromRGBO(100, 0, 0, 1),
        shape: BoxShape.rectangle,
        image: DecorationImage(
          image: AssetImage("assets/images/sliver_header_bg.jpg"),
          fit: BoxFit.cover,
        ),
        border: BoxBorder.fromLTRB(
          bottom: BorderSide(color: Colors.white, width: 1),
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/general_profile.png'),
          ),
          SizedBox(height: 10),
          Text(
            'User Name',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 6),
          Text(
            'Email Address',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    ),
  );
}
