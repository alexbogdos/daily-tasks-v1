import 'package:daily_tasks/components/colors.dart';
import 'package:daily_tasks/components/widgets/custom_text.dart';
import 'package:daily_tasks/components/tasks_list.dart';
import 'package:daily_tasks/components/widgets/task_editForm.dart';
import 'package:daily_tasks/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActionButton extends StatelessWidget {
  final Function notifyParent;

  const ActionButton({required this.notifyParent, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Settings()),
        ).then((value) => this.notifyParent());
        // .then((value) => setState(() {saveIndex(); saveColorValues();}));
      },
      backgroundColor: AppColors().appBar,
      child: Icon(
        Icons.settings,
        color: AppColors().date,
        size: 30,
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  final Function() notifyParent;

  const BottomBar({required this.notifyParent, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      notchMargin: 5,
      color: AppColors().appBar,
      shape: CircularNotchedRectangle(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: TextButton(
                onPressed: () {
                  _createDate();
                  this.notifyParent();
                  TasksList().saveData();
                },
                style: TextButton.styleFrom(primary: Colors.white30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_box,
                      color: AppColors().background,
                    ),
                    customText('Date')
                  ],
                )),
          ),
          Container(
            width: 2.0,
            height: 40.0,
            color: AppColors().background,
          ),
          Expanded(
            child: TextButton(
                onPressed: () {
                  if (TasksList().texts.isEmpty) {
                    _createDate();
                  }

                  TasksList().createTask('New Task');

                  EditForm(index: TasksList().texts.length - 1, isNewTask: true)
                      .showTaskEditDialog(context)
                      .then((value) => this.notifyParent())
                      .then((value) => TasksList().saveData());
                },
                style: TextButton.styleFrom(primary: Colors.white30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_box,
                      color: AppColors().background,
                    ),
                    customText('Task')
                  ],
                )),
          ),
        ],
      ),
    );
  }

  void _createDate() {
    String day = DateFormat.d().format(DateTime.now());
    String month = DateFormat.M().format(DateTime.now());
    String year = DateFormat.y().format(DateTime.now());

    String currentDate;
    if (int.parse(day) <= 9) {
      currentDate = '0$day/${TasksList().months[month]}./$year';
    } else {
      currentDate = '$day/${TasksList().months[month]}./$year';
    }

    TasksList().createDate(currentDate);
  }
}
