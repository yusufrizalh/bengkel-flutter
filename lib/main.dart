// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_lab/pages/display_page.dart';
import 'package:flutter_lab/pages/gallery_page.dart';
import 'package:flutter_lab/pages/login_page.dart';
import 'package:flutter_lab/screens/home_screen.dart';
import 'package:flutter_lab/screens/login_screen.dart';
import 'package:flutter_lab/screens/register_screen.dart';
import 'package:flutter_lab/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthService())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          useMaterial3: false,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        title: "Flutter Lab",
        home: LoginScreen(),
        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/home': (context) => HomeScreen(),
        },
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Lab'),
        centerTitle: true,
        backgroundColor: Colors.red,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        elevation: 8,
        leading: Icon(Icons.home, size: 32, color: Colors.white),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.search, size: 32)),
          PopupMenuButton(
            tooltip: "Open popup",
            itemBuilder: (context) {
              return {
                "Contact",
                "Messages",
                "Settings",
                "Gallery",
                "Help",
                "Login",
              }.map((String popup) {
                return PopupMenuItem(value: popup, child: Text(popup));
              }).toList();
            },
            onSelected: (String popup) {
              switch (popup) {
                case "Contact":
                  debugPrint("Popup Contact");
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        alignment: Alignment.center,
                        backgroundColor: Colors.grey.shade400,
                        elevation: 8,
                        icon: Icon(Icons.star),
                        iconColor: Colors.red,
                        scrollable: true,
                        title: Text(
                          "Simple Dialog",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Text("This is simple alert dialog"),
                        actions: <Widget>[
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(
                              Icons.cancel,
                              size: 32,
                              color: Colors.grey,
                            ),
                          ),
                          IconButton(
                            onPressed: () =>
                                debugPrint("Alert dialog is clicked"),
                            icon: Icon(
                              Icons.check,
                              size: 32,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                  break;
                case "Messages":
                  debugPrint("Popup Messages");
                  showModalBottomSheet(
                    isScrollControlled: true,
                    isDismissible: true,
                    useSafeArea: true,
                    backgroundColor: Colors.grey.shade300,
                    barrierColor: Colors.grey.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      side: BorderSide(color: Colors.grey, strokeAlign: 2),
                    ),
                    context: context,
                    builder: (context) {
                      return Wrap(
                        alignment: WrapAlignment.center,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.copy, color: Colors.red),
                            title: Text("Copy"),
                            titleTextStyle: TextStyle(color: Colors.red),
                            onTap: () {
                              debugPrint("Copy is clicked");
                              Navigator.of(context).pop();
                              var snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                showCloseIcon: true,
                                closeIconColor: Colors.white,
                                duration: Duration(seconds: 6),
                                dismissDirection: DismissDirection.down,
                                action: SnackBarAction(
                                  label: "OK",
                                  textColor: Colors.white,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                behavior: SnackBarBehavior.floating,
                                content: Text("Copy data to your clipboard"),
                              );
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(snackBar);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.share, color: Colors.red),
                            title: Text("Share"),
                            titleTextStyle: TextStyle(color: Colors.red),
                            onTap: () {
                              debugPrint("Share is clicked");
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.bookmark, color: Colors.red),
                            title: Text("Bookmark"),
                            titleTextStyle: TextStyle(color: Colors.red),
                            onTap: () {
                              debugPrint("Bookmark is clicked");
                            },
                          ),
                        ],
                      );
                    },
                  );
                  break;
                case "Settings":
                  debugPrint("Popup Settings");
                  break;
                case "Gallery":
                  debugPrint("Popup Gallery");
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => GalleryPage()),
                  );
                  break;
                case "Help":
                  debugPrint("Popup Help");
                  break;
                case "Login":
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => LoginPage()));
                  debugPrint("Popup Login");
                  break;
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(4),
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: 12,
                  bottom: 6,
                  left: 12,
                  right: 12,
                ),
                padding: EdgeInsets.zero,
                height: 80,
                color: Colors.grey.shade300,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    label: Text('Search'),
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                  ),
                  textInputAction: TextInputAction.search,
                  onSubmitted: (String value) {
                    debugPrint("Search is submitted with value: $value");
                  },
                  onChanged: (String value) {
                    debugPrint("Search is changed with value: $value");
                  },
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  cursorColor: Colors.red,
                ),
              ),
              Container(
                padding: EdgeInsets.zero,
                height: 210,
                child: ListView.builder(
                  itemCount: pageData.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, position) {
                    return myCardWidget(pageData[position]);
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.zero,
                height: 180,
                child: ListView.builder(
                  itemCount: pageData.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, position) {
                    return myOvalWidget(pageData[position]);
                  },
                ),
              ),
              Divider(color: Colors.grey, thickness: 1, height: 12),
              Container(
                margin: EdgeInsets.all(12),
                width: MediaQuery.of(context).size.width * 0.5,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.grey, strokeAlign: 3),
                    ),
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    // go to other page
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DisplayPage()),
                    );
                  },
                  child: Text('Go to display page'),
                ),
              ),
              TextButton(onPressed: () {}, child: Text('Click Me')),
              OutlinedButton(onPressed: () {}, child: Text('Click Me')),
              IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB is clicked');
        },
        backgroundColor: Colors.red,
        elevation: 8,
        child: Icon(Icons.create, size: 32, color: Colors.white),
      ),
    );
  }

  final List<Map<String, dynamic>> pageData = [
    {
      'image': 'https://picsum.photos/id/0/5000/3333',
      'title': 'Title 1',
      'subtitle': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    },
    {
      'image': 'https://picsum.photos/id/7/4728/3168',
      'title': 'Title 2',
      'subtitle':
          'Consequat aenean non eget urna accumsan justo iaculis augue.',
    },
    {
      'image': 'https://picsum.photos/id/10/2500/1667',
      'title': 'Title 3',
      'subtitle':
          'Mauris mauris suspendisse curae felis dapibus malesuada diam vehicula class.',
    },
    {
      'image': 'https://picsum.photos/id/20/3670/2462',
      'title': 'Title 4',
      'subtitle':
          'Congue varius facilisis in mauris venenatis tempor habitasse enim netus semper.',
    },
    {
      'image': 'https://picsum.photos/id/26/4209/2769',
      'title': 'Title 5',
      'subtitle':
          'Gravida nisi cubilia maximus sed lectus dictum gravida vitae varius hac ligula.',
    },
  ];

  Widget myCardWidget(Map<String, dynamic> data) {
    return Container(
      margin: EdgeInsets.all(4),
      width: 150,
      child: InkWell(
        onTap: () {
          debugPrint("Check");
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadiusGeometry.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image(
                // image: NetworkImage("https://placehold.co/600x400/png"),
                image: NetworkImage(data['image']),
                fit: BoxFit.cover,
              ),
            ),
            ListTile(
              title: Text(
                data['title'],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                data['subtitle'] ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget myOvalWidget(Map<String, dynamic> data) {
    return Container(
      margin: EdgeInsets.all(4),
      width: 150,
      child: InkWell(
        onTap: () {
          debugPrint("Check");
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(0),
              width: 150,
              height: 150,
              child: ClipOval(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: NetworkImage(data['image']),
                      fit: BoxFit.cover,
                    ),
                    ListTile(
                      title: Text(
                        data['title'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
