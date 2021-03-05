import 'package:flutter/material.dart';
import 'screen/notes_screen.dart';
import 'screen/start_screen.dart';
import 'screen/userhome_screen.dart';

void main() {
  runApp(Creative2App());
}

class Creative2App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red[700],
        textTheme: TextTheme(
          button: TextStyle(
            fontSize: 28.0,
          ),
        ),
      ),
      initialRoute: StartScreen.routeName,
      routes: {
        StartScreen.routeName: (context) => StartScreen(),
        UserHomeScreen.routeName: (context) => UserHomeScreen(),
        NoteScreen.routeName: (context) => NoteScreen(),
      },
    );
  }
}
