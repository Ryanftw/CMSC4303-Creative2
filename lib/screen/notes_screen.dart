import 'package:Creative2/model/notes_list.dart';
import 'package:flutter/material.dart';

class NoteScreen extends StatefulWidget {
  static const routeName = '/noteScreen';
  @override
  State<StatefulWidget> createState() {
    return _NoteScreen();
  }
}

class _NoteScreen extends State<NoteScreen> {
  _Controller con;
  TextEditingController myController = TextEditingController();
  TextEditingController myController2 = TextEditingController();

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
        title: Text("Quick Notes"),
        actions: con.selected != null
            ? [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: con.delete,
                ),
                IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: con.cancel,
                ),
              ]
            : [
                IconButton(icon: Icon(Icons.add), onPressed: con.add),
              ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(20.0)),
            TextFormField(
              validator: con.validateNote,
              controller: myController,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: "Enter Note",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              validator: con.validateTitle,
              controller: myController2,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: "Enter title",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: noteList.length,
              itemBuilder: con.getTile,
            ),
          ],
        ),
      ),
    );
  }
}

class _Controller {
  _NoteScreen state;
  _Controller(this.state);
  List<int> selected;
  final Color selectedColor = Colors.red[800];
  final Color unselectedColor = Colors.red[400];

  String validateNote(String value) {
    if (value.length < 1) return "Cannot save empty note. ";
    return null;
  }

  String validateTitle(String value) {
    if (value.length < 1) return "Title must exist.";
    return null;
  }

  Widget getTile(BuildContext context, int index) {
    return Container(
      color: (selected != null && selected.indexOf(index) >= 0)
          ? selectedColor
          : unselectedColor,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      child: ListTile(
        title: Text(noteList[index].title),
        onTap: () {
          _onTap(context, index);
        },
        onLongPress: () {
          _longPress(context, index);
        },
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    if (selected == null) {
      showDetails(context, noteList[index]);
    } else {
      state.render(() {
        if (selected.indexOf(index) < 0) {
          selected.add(index);
        } else {
          selected.removeWhere((value) => value == index);
          if (selected.length == 0) selected = null;
        }
      });
    }
  }

  void _longPress(BuildContext context, int index) {
    if (selected == null) {
      state.render(() {
        selected = [];
        selected.add(index);
      });
    } else {
      state.render(() {
        if (selected.indexOf(index) < 0) {
          selected.add(index);
        } else {
          selected.removeWhere((value) => value == index);
          if (selected.length == 0) selected = null;
        }
      });
    }
  }

  void delete() {
    selected.sort();
    state.render(() {
      for (int i = selected.length - 1; i >= 0; i--) {
        noteList.removeAt(selected[i]);
      }
      selected = null;
    });
  }

  void cancel() {
    state.render(() => selected = null);
  }

  void add() {
    if (state.myController.text.length < 1 || state.myController2.text.length < 1) return;
    state.render(() {
      noteList.add(Notes(note: state.myController.text, title: state.myController2.text));
    });
  }

  void showDetails(BuildContext context, Notes note) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(note.title),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Close',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ],
        content: Card(
          color: Colors.red[600],
          elevation: 15.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(note.note),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
