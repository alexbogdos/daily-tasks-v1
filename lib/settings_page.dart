import 'package:daily_tasks/components/colors.dart';
import 'package:daily_tasks/components/widgets/color_block.dart';
import 'package:daily_tasks/themeInfo_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'components/widgets/custom_text.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    List<String> names = AppColors().getNames();
    print(names);
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors().background,
            appBar: AppBar(
              centerTitle: true,
              title: customText('Settings'),
              backgroundColor: AppColors().appBar,
              iconTheme: IconThemeData(
                color: AppColors().date,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(18),
                ),
              ),
              actions: [
                IconButton(onPressed: () {
                  AppColors().resetDefaultThemes(_refresh);
                }, icon: Icon(Icons.refresh, color: AppColors().date,))
              ],
            ),
            body: Stack(
              // mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 560,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (int index = 0; index <= names.length; index++)
                        index != names.length ?

                        ColorBlock(
                            name: names[index],
                            index: index,
                            notifyParent: _refresh)

                : Container(height: 22,),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 100,
                        decoration: BoxDecoration(
                            color: AppColors().appBar,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(23),
                                topRight: Radius.circular(23))),
                        child: Text(
                          'Create New',
                          style: TextStyle(
                              color: AppColors().background,
                              fontFamily: 'Neohellenic',
                              fontSize: 34,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          print('create new');
                          AppColors().addTheme('New Theme');
                          names = AppColors().getNames();
                          int index = names.length - 1;
                          String newName = names[index];

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ThemeInfoPage(name: newName, index: index, colors: AppColors().getValues(index), isNew: true,)),
                          ).then((value) => _refresh()).then((value) => AppColors().saveColors());
                          },
                        child: Container(
                          height: 84,
                          color: AppColors().clear,
                        ),
                        style:
                            TextButton.styleFrom(primary: AppColors().background),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }

  _refresh() {
    setState(() {});
  }
}
