// Karma Database Class using hive

import 'package:hive/hive.dart';

class KarmaDatabase {
  // constructor for our database
  final _myBox = Hive.box('karma');
  List toDoList = [];

  KarmaDatabase() {
    if (_myBox.get('Karmas') == null) {
      initialData();
    } else {
      loadData();
    }
  }
  // reference our box

  // create initial data

  // run this method if this is the 1st time ever opening this app
  void initialData() {
    print("Intial Data Called");
    toDoList = [
      ['Pratham Karya', false],
    ];
    _myBox.put('Karmas', toDoList);
  }

  // load the data from the database
  void loadData() {
    toDoList = _myBox.get('Karmas');
    print("Load Data Called" + toDoList.toString());
  }

  // update the database
  void updateDataBase() {
    _myBox.put('Karmas', toDoList);
    print("Update Data Called" + toDoList.toString());
  }
}
