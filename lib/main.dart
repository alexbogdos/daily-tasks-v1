import 'package:daily_tasks/components/colors.dart';
import 'package:daily_tasks/components/tasks_list.dart';
import 'package:daily_tasks/components/widgets/bottom_appbar.dart';
import 'package:daily_tasks/components/widgets/date.dart';
import 'package:daily_tasks/components/widgets/task.dart';
import 'package:daily_tasks/loading_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: LoadingScreen(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    print(
        "=========================================== ReBuild ===========================================");

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors().background,
        floatingActionButton: ActionButton(
          notifyParent: _refresh,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomBar(
          notifyParent: _refresh,
        ),
        body: ReorderableListView(
          onReorder: (int oldIndex, int newIndex) {
            _reorder(oldIndex, newIndex);
            _refresh();

            TasksList().analyze(_refresh, _afterAnalyze);
          },
          children: [
            for (int index = 0; index < TasksList().texts.length; index++)
              TasksList().texts[index].contains('DATE:')
                  ? Date(
                      key: Key('$index'),
                      index: index,
                      text: TasksList().texts[index],
                      notifyParent: _refresh,
                    )
                  : Task(
                      key: Key('$index'),
                      text: TasksList().texts[index],
                      index: index,
                      isDone: TasksList().bools[index],
                      notifyParent: _refresh,
                    )
          ],
        ),
      ),
    );
  }

  void _reorder(int oldIndex, int newIndex) {
    if (!(oldIndex == 0) && !(newIndex == 0)) {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      String task = TasksList().texts[oldIndex];
      String taskBool = TasksList().bools[oldIndex];

      TasksList().delete(oldIndex);

      TasksList().texts.insert(newIndex, task);
      TasksList().bools.insert(newIndex, '$taskBool');

      TasksList().saveData();
    }
  }

  void _afterAnalyze() {
    _refresh();
    TasksList().saveData();
  }

  void _refresh() {
    setState(() {
      print('setState');
    });
  }
}
