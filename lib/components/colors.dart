import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppColors {

  static List<String> _defaultThemes = [
    'Default', //theme name               [0]  [0]
    '#765D69', // Background              [1]  [1]
    '#FCD0BA', // Date Text               [2]  [2]
    '#8FB9A8', // App Bar                 [3]  [3]
    '#F1828D', // Item Box                [4]  [4]
    '#4f3134', // Item Box Done           [5]  [5]
    '#FEFAD4', // Item Box Text           [6]  [6]
    '#898667', // Item Box Text Done      [7]  [7]
    '#c1bea2', // Item Icon Ticked Color  [8]  [8]

    'Earth',   //theme name               [0]  [9]
    '#EEDDCE', // Background              [1]  [10]
    '#DCC6AE', // Date Text               [2]  [11]
    '#B19D99', // App Bar                 [3]  [12]
    '#F0EDEA', // Item Box                [4]  [13]
    '#DCC6AE', // Item Box Done           [5]  [14]
    '#B19D99', // Item Box Text           [6]  [15]
    '#F0EDEA', // Item Box Text Done      [7]  [16]
    '#F0EDEA', // Item Icon Ticked Color  [8]  [17]

    'Vintage', //theme name            [0]  [18]
    '#f7efd8', // Background              [1]  [19]
    '#f4a24f', // Date Text               [2]  [20]
    '#c63434', // App Bar                 [3]  [21]
    '#f4a24f', // Item Box                [4]  [22]
    '#bb2b2a', // Item Box Done           [5]  [23]
    '#580f0c', // Item Box Text           [6]  [24]
    '#2cd2ee', // Item Box Text Done      [7]  [25]
    '#2cd2ee', // Item Icon Ticked Color  [8]  [26]
  ];

  void resetDefaultThemes (Function() refresh) {
    _themes.clear();
    _defaultThemes.forEach((element) {
      _themes.add(element);
    });
    int index = 0;
    var values =  getValues(index);
    setNewColorList(values);
    setThemeUsed(index);
    refresh();
    saveColors();
  }

  // Used theme
  static int _themeUsed = 0;

  int get themeUsed => _themeUsed;

  // Color Values
  static String _background = '#765D69';
  static String _date = '#FCD0BA';
  static String _appBar = '#8FB9A8';
  static String _box = '#F1828D';
  static String _boxDone = '#4f3134';
  static String _text = '#FEFAD4';
  static String _textDone = '#898667';
  static String _iconDone = '#c1bea2';

  // Hex Colors
  HexColor background = HexColor(_background);
  HexColor date = HexColor(_date);
  HexColor appBar = HexColor(_appBar);
  HexColor box = HexColor(_box);
  HexColor boxDone = HexColor(_boxDone);
  HexColor text = HexColor(_text);
  HexColor textDone = HexColor(_textDone);
  HexColor iconDone = HexColor(_iconDone);
  HexColor clear = HexColor('#00000000');

  // Themes
  static List<String> _themes = [
    'Default', //theme name               [0]  [0]
    '#765D69', // Background              [1]  [1]
    '#FCD0BA', // Date Text               [2]  [2]
    '#8FB9A8', // App Bar                 [3]  [3]
    '#F1828D', // Item Box                [4]  [4]
    '#4f3134', // Item Box Done           [5]  [5]
    '#FEFAD4', // Item Box Text           [6]  [6]
    '#898667', // Item Box Text Done      [7]  [7]
    '#c1bea2', // Item Icon Ticked Color  [8]  [8]

    'Earth',   //theme name               [0]  [9]
    '#EEDDCE', // Background              [1]  [10]
    '#DCC6AE', // Date Text               [2]  [11]
    '#B19D99', // App Bar                 [3]  [12]
    '#F0EDEA', // Item Box                [4]  [13]
    '#DCC6AE', // Item Box Done           [5]  [14]
    '#B19D99', // Item Box Text           [6]  [15]
    '#F0EDEA', // Item Box Text Done      [7]  [16]
    '#F0EDEA', // Item Icon Ticked Color  [8]  [17]

    'Vintage', //theme name            [0]  [18]
    '#f7efd8', // Background              [1]  [19]
    '#f4a24f', // Date Text               [2]  [20]
    '#c63434', // App Bar                 [3]  [21]
    '#f4a24f', // Item Box                [4]  [22]
    '#bb2b2a', // Item Box Done           [5]  [23]
    '#580f0c', // Item Box Text           [6]  [24]
    '#2cd2ee', // Item Box Text Done      [7]  [25]
    '#2cd2ee', // Item Icon Ticked Color  [8]  [26]
  ];
  List<String> get themes => _themes;

  // Functions:
  // ?: Set a specific color variable using a hex string
  void setNewColor(String oldColor, String newColor) {
    switch (oldColor) {
      case 'background':
        {
          _background = newColor;
        }
    }
  }

  Future<void> addTheme (String name) async {
    _themes.add(name);
    print(_themes);
    for (int i = 0; i < 8; i++) {
      _themes.add('#000000');
    }
  }

  // ?: Setting the app color values from a color (theme) list
  void setNewColorList(List<String> list) {
    _background = list[0];
    _date = list[1];
    _appBar = list[2];
    _box = list[3];
    _boxDone = list[4];
    _text = list[5];
    _textDone = list[6];
    _iconDone = list[7];
  }

  // ?: Get the HexColor from a hex string
  HexColor stringToColor(String value) {
    try {
      HexColor(value);
    } catch (e, s) {
      print('--------------- ERROR: $s');
      return appBar;
    }
    return HexColor(value);
  }

  // get length of 'themes' list
  int getLength() {
    return _themes.length ~/ 9;
  }

  void setThemeUsed(int themeIndex) {
    _themeUsed = themeIndex;
  }

  // ?: Get the theme names from 'themes' list
  List<String> getNames() {
    int count = getLength();
    List<String> names = [];
    int index = 0;
    for (int i = 0; i < count; i++) {
      names.add(_themes[index]);
      index += 9;
    }
    return names;
  }

  void changeThemeValuesOnIndex(int themeIndex, int colorIndex, String color) {

    int _themeIndex = themeIndex * 9;
    int _colorIndex = _themeIndex + 1 + colorIndex;
    _themes[_colorIndex] = color;
  }

  bool isHexColor (String color) {
    try {
      HexColor(color);
    } catch (e, s) {
      print('--------------- ERROR: Not a HexColor');
      print(s);
      return false;
    }
    return true;
  }

  Future<void> deleteTheme(int index) async {

    print(themes);
    if (_themeUsed == index) {
      setThemeUsed(0);
      List<String> values = getValues(_themeUsed);
      setNewColorList(values);
    }

    int _index = index * 9;
    for (int i = _index; i < _index + 9; i++) {
      print('$_index: ${_themes[_index]}');
      _themes.removeAt(_index);
    }
    print(themes);
  }

  Future<void> setEditedColor(
      String themeName, int _index, String color) async {
    int themeIndex = getThemeIndex(themeName);
    int index = themeIndex + _index + 1;
    print('$index: ${_themes[index]}');
    _themes[index] = color;
  }

  void refreshTheme(int themeNameOrIndex) {
      var values = getValues(themeNameOrIndex);
      setNewColorList(values);
  }

  void changeThemeName (int index, String name) {
    int _index = index * 9;
    _themes[_index] = name;
  }

  int getThemeIndex(String name) {
    int index = 0;
    for (int _index = 0; _index < _themes.length; _index++) {
      if (_themes[_index] == name) {
        index = _index;
        break;
      }
    }
    return index;
  }

  // ?: Using the used theme name to get its values from 'themes' list
  List<String> getValues(int index) {
    List<String> values = List.empty(growable: true);

    int _index = index * 9;
    for (int i = _index + 1; i < _index + 9; i++) {
      values.add(_themes[i]);
    }

    return values;
  }

  // ?: Retrieving Colors and setting from save
  Future<void> retrieveThemes() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('themes')) {
      print("ERROR: There isn't a <<themes>> list saved");
      return;
    }

    _themes = prefs.getStringList('themes')!;
  }

  String getThemeNameOnIndex (int index) {
    var names = getNames();
    if (index == -1) {
      index = names.length - 1;
    }
    return names[index];
  }

  // ?: Retrieving the used theme from save
  Future<void> retrieveThemeUsed() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('themeUsed')) {
      print("ERROR: There isn't a <<themeUsed>> saved");
      return;
    }

    try {
      _themeUsed = prefs.getInt('themeUsed')!;
    } catch (e, s) {
      print(s);
      await prefs.remove('themeUsed');
      await prefs.setInt('themeUsed', 0);
      _themeUsed = 0;
    }

    List<String> values = getValues(_themeUsed);
    setNewColorList(values);
  }

  // ?: Saving the 'themes' list and the name of the theme used
  Future<void> saveColors() async {
    final prefs = await SharedPreferences.getInstance();
    print('Saving Colors..');

    prefs.setStringList("themes", _themes);
    prefs.setInt("themeUsed", _themeUsed);
  }
}
