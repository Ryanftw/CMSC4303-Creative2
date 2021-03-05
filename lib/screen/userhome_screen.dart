// import 'package:Creative2/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:Creative2/model/user_record.dart';
import 'notes_screen.dart';

class UserHomeScreen extends StatefulWidget {
  static const routeName = '/userHomeScreen';
  @override
  State<StatefulWidget> createState() {
    return _UserHomeState();
  }
}

class _UserHomeState extends State<UserHomeScreen> {
  UserRecord userRecord;
  _Controller con;

  @override
  initState() {
    super.initState();
    con = _Controller(this);
  }

  @override
  Widget build(BuildContext context) {
    userRecord = ModalRoute.of(context).settings.arguments;
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home for ${userRecord.name}"),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Text(userRecord.email),
              ),
              // ListTile(
              //   leading: Icon(Icons.person),
              //   title: Text("profile"),
              //   onTap: con.profile,
              // ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("sign out"),
                onTap: con.signOut,
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Text(
              "Hi, ${userRecord.name}",
              style: Theme.of(context).textTheme.headline5,
            ),
            // RaisedButton(
            //   onPressed: () => Navigator.pushNamed(context, ToDoListScreen.routeName),
            //   child: Text("To-Do Lists"),
            // ),
            SizedBox(
              height: 15.0,
              width: MediaQuery.of(context).size.width,
            ),
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, NoteScreen.routeName),
              child: Text("Notes"),
            ),
          ],
        ),
      ),
    );
  }
}

class _Controller {
  _UserHomeState state;
  _Controller(this.state);

  // void profile() async {
  //   await Navigator.pushNamed(state.context, ProfileScreen.routeName,
  //       arguments: state.userRecord);
  //   Navigator.of(state.context).pop();
  // }

  void signOut() {
    Navigator.of(state.context).pop(); // close the drawer
    Navigator.of(state.context).pop(); // pop the user back home
  }
}
