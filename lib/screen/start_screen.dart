import 'package:Creative2/model/user_record.dart';
import 'package:flutter/material.dart';
import 'userhome_screen.dart';

class StartScreen extends StatefulWidget {
  static const routeName = '/startScreen';
  @override
  State<StatefulWidget> createState() {
    return _StartScreen();
  }
}

class _StartScreen extends State<StartScreen> {
  _Controller con;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String error;

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  void render(fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Quick Notes LogIn"),
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Sign In, Please!",
                  style: Theme.of(context).textTheme.headline5,
                ),
                error == null
                    ? SizedBox(
                        height: 1.0,
                      )
                    : Text(
                        error,
                        style: TextStyle(fontSize: 16.0, color: Colors.red),
                      ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: 'Enter Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  validator: con.validateEmail,
                  onSaved: con.saveEmail,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.security),
                    hintText: "Enter Password",
                  ),
                  obscureText: true,
                  autocorrect: false,
                  validator: con.validatePassword,
                  onSaved: con.savePassword,
                ),
                RaisedButton(
                  onPressed: con.signIn,
                  child: Text(
                    "Sign In",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class _Controller {
  _StartScreen state;
  _Controller(this.state);
  UserRecord userRecord = UserRecord();

  void signIn() {
    if (!state.formKey.currentState.validate()) return;

    state.formKey.currentState.save();

    var user = UserRecord.fakeDB.firstWhere(
        (element) =>
            element.email == userRecord.email && element.password == userRecord.password,
        orElse: () => null);

    if (user == null) {
      state.render(() => state.error = "Not valid user credential");
    } else {
      state.render(() => state.error = null);
      Navigator.pushNamed(state.context, UserHomeScreen.routeName, arguments: user);
    }
  }

  String validateEmail(String value) {
    if (value.contains('.') && value.contains('@')) return null;
    return 'Not a valid email';
  }

  String validatePassword(String value) {
    if (value.length < 6) return "Too short";
    return null;
  }

  void saveEmail(String value) {
    userRecord.email = value;
  }

  void savePassword(String value) {
    userRecord.password = value;
  }
}
