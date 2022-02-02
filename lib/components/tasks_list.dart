import 'package:shared_preferences/shared_preferences.dart';

class TasksList {
  // Task Lists
  static List<String> _texts = List.empty(growable: true);
  static List<String> _bools = List.empty(growable: true);

  static List<List<int>> _listGroupsIDs = List.empty(growable: true);

  List<String> get texts => _texts;

  List<String> get bools => _bools;

  // Date Map
  Map months = {
    '1': "ΙΑΝ",
    '2': "ΦΕΒ",
    '3': "ΜΑΡ",
    '4': "ΑΠΡ",
    '5': "ΜΑΪ",
    '6': "ΙΟΥΝ",
    '7': "ΙΟΥΛ",
    '8': "ΑΥΓ",
    '9': "ΣΕΠ",
    '10': "ΟΚΤ",
    '11': "ΝΟΕ",
    '12': "ΔΕΚ",
  };

  // Functions

  void createTask(String text) {
    _texts.add(text);
    _bools.add('false');
  }

  void createDate(String text) {
    _texts.add('DATE:$text');
    _bools.add('false');
  }

  void changeState(int index) {
    if (_bools[index] == 'false') {
      _bools[index] = 'true';
    } else {
      _bools[index] = 'false';
    }
  }

  void changeText(int index, String newText) {
    texts[index] = '$newText';
  }

  void delete(int index) {
    _texts.removeAt(index);
    _bools.removeAt(index);
  }

  // Data formatting

  void generateGroups() async {
    List<String> groupsIDs = [];
    int index = 0;
    for (var item in _texts) {
      if (item.contains('DATE:')) {
        groupsIDs.add('|');
      }
      groupsIDs.add(index.toString());
      index++;
    }

    int j = -1;
    _listGroupsIDs = List.empty(growable: true);

    for (var char in groupsIDs) {
      if (char == '|') {
        _listGroupsIDs.add([]);
        j++;
      } else {
        List<int> list = _listGroupsIDs[j];
        list.add(int.parse(char));
      }
    }
    print(_listGroupsIDs);
    print(1);
  }

  Future<void> analyze(Function() refresh, Function() afterFinished) async {
    generateGroups();
    print('2');

    bool completed = true;
    for (var idGroup in _listGroupsIDs) {
      bool first = true;
      completed = true;
      for (var id in idGroup) {
        if (first) {
          first = false;
          continue;
        } else {
          if (bools[id] == 'false') {
            completed = false;
            break;
          }
        }
      }

      print(' ------- COMPLETED: $completed -------');
      if (completed) {
        Future.delayed(Duration(milliseconds: 0), () {
          print('Deleting Items..');
          idGroup.forEach((element) {
            int id = idGroup[0];
            delete(id);
          });
        }).then((value) => afterFinished());
      }
    }
    print("DONE");
    refresh();
  }

  bool isLast (int index) {
    if (index == _texts.length - 1) {
      return true;
    }
    return false;
  }

  // ?: Retrieving _texts, _bools and setting from save
  Future<void> retrieveTexts() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('texts')) {
      print("ERROR: There isn't a <<texts>> list saved");
      return;
    }

    _texts = prefs.getStringList('texts')!;
  }

  Future<void> retrieveBools() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('bools')) {
      print("ERROR: There isn't a <<bools>> list saved");
      return;
    }

    _bools = prefs.getStringList('bools')!;
  }

  // ?: Saving the '_texts' and '_bools' lists
  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    print('Saving Data..');

    prefs.setStringList("texts", _texts);
    prefs.setStringList("bools", _bools);
  }
}
