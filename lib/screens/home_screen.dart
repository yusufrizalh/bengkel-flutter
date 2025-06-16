import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    void logoutProcess() async {
      await authService.logout();
      Navigator.pushReplacementNamed(context, '/login');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 100, 0, 1),
        leading: Icon(Icons.home),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.logout),
          //   onPressed: () async {
          //     await authService.logout();
          //     Navigator.pushReplacementNamed(context, '/login');
          //   },
          // ),
          PopupMenuButton(
            tooltip: "Open popup",
            itemBuilder: (context) {
              return {"Profile", "Documents", "Logout"}.map((String popup) {
                return PopupMenuItem(value: popup, child: Text(popup));
              }).toList();
            },
            onSelected: (String popup) {
              switch (popup) {
                case "Profile":
                  debugPrint("Popup Profile");
                  break;
                case "Documents":
                  debugPrint("Popup Documents");
                  Navigator.of(context).pushNamed('/documents');
                  break;
                case "Logout":
                  debugPrint("Popup Logout");
                  logoutProcess();
                  break;
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 12,
                        title: Text('Profile'),
                        icon: Icon(Icons.info, size: 32),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey,
                              child: Icon(
                                Icons.person,
                                size: 60,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 16),
                            if (authService.user != null) ...[
                              Text(
                                'Name: ${authService.user!.user_name}',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                'Email: ${authService.user!.user_email}',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Card(
                  color: Colors.green,
                  elevation: 12,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey, width: 2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          if (authService.user != null) ...[
                            Text(
                              'Welcome, ${authService.user!.user_name}!',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Email: ${authService.user!.user_email}',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
