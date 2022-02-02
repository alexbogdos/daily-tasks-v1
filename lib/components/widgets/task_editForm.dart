import 'package:daily_tasks/components/colors.dart';
import 'package:daily_tasks/components/tasks_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditForm {
  late String text;
  final int index;
  final bool isDate;
  final bool isNewTask;

  EditForm({required this.index, this.isDate = false, this.isNewTask = false});

  Future<void> showTaskEditDialog(BuildContext context) async {
    double buttonOpacity = 0.8;

    this.text = TasksList().texts[this.index];
    if (this.isDate) {
      this.text = this.text.substring(5);
    }
    String edited = this.text;

    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors().background,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Επεξεργασία:",
                  style: TextStyle(
                      color: AppColors().date,
                      fontFamily: 'Neohellenic',
                      fontWeight: FontWeight.w700,
                      fontSize: 28.0),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Form(
                    child: TextFormField(
                  validator: (value) {
                    return value!.isNotEmpty ? null : "Invalid Field";
                  },
                  initialValue: this.text == 'New Task' ? '' : '${this.text}',
                  onChanged: (value) {
                    edited = value;
                  },
                  maxLines: 4,
                  minLines: 1,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Neohellenic',
                      color: AppColors().text // 1 / 5
                      ),
                  decoration: InputDecoration(
                    enabledBorder: myinputborder(),
                    focusedBorder: myfocusedborder(),
                  ),
                ))
              ],
            ),
            actions: [
              TextButton(
                  child: Text('Ακύρωση'),
                  style: TextButton.styleFrom(
                    backgroundColor:
                        AppColors().date.withOpacity(buttonOpacity),
                    primary: AppColors().text,
                  ),
                  onPressed: () {
                    if (this.isNewTask) {
                      TasksList().delete(this.index);
                    }
                    Navigator.of(context).pop();
                  }),
              Visibility(
                visible: !this.isNewTask,
                child: TextButton(
                    child: Text('Διαγραφή'),
                    style: TextButton.styleFrom(
                      backgroundColor:
                          AppColors().date.withOpacity(buttonOpacity),
                      primary: AppColors().text,
                    ),
                    onPressed: () {
                      TasksList().delete(this.index);

                      TasksList()
                          .saveData()
                          .then((value) => Navigator.of(context).pop());
                    }),
              ),
              TextButton(
                  child: Text('Τέλος'),
                  style: TextButton.styleFrom(
                    backgroundColor:
                        AppColors().date.withOpacity(buttonOpacity),
                    primary: AppColors().text,
                  ),
                  onPressed: () {
                    if (this.isDate) {
                      edited = 'DATE:$edited';
                    }
                    TasksList().changeText(this.index, '$edited');
                    TasksList()
                        .saveData()
                        .then((value) => Navigator.of(context).pop());
                  })
            ],
          );
        });
  }

  OutlineInputBorder myinputborder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
        //Outline border type for Text Field
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: AppColors().appBar,
          width: 3,
        ));
  }

  OutlineInputBorder myfocusedborder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
        //Outline border type for Text Field
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: AppColors().box,
          width: 3,
        ));
  }

  bool isFirst(int index) {
    bool aboveIsDate = TasksList().texts[index - 1].contains('DATE:');
    bool noneBelow = index == TasksList().texts.length - 1;
    if (aboveIsDate && noneBelow && index == 1) {
      return true;
    }

    return false;
  }
}
