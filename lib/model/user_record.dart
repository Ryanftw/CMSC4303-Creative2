// import 'notes_list.dart';2

class UserRecord {
  var notes;
  String email;
  String password;
  String name;
  String phone;
  int age;

  UserRecord({
    this.notes = "",
    this.email = "",
    this.password = "",
    this.name = "",
    this.phone = "",
    this.age = -1,
  });

  UserRecord.clone(UserRecord user) {
    this.notes = user.notes;
    this.email = user.email;
    this.password = user.password;
    this.name = user.name;
    this.phone = user.phone;
    this.age = user.age;
  }

  void assign(UserRecord user) {
    this.notes = user.notes;
    this.email = user.email;
    this.password = user.password;
    this.name = user.name;
    this.phone = user.phone;
    this.age = user.age;
  }

  @override
  String toString() {
    return "UserRecord[email=$email password=$password]";
  }

  static List<UserRecord> fakeDB = [
    UserRecord(email: '1@test.com', password: '111111', name: 'One', phone: '111222333'),
    UserRecord(email: '2@test.com', password: '222222', name: 'Two', phone: '222333444'),
  ];
}
