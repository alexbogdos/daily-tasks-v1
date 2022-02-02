import 'package:daily_tasks/components/colors.dart';
import 'package:daily_tasks/components/tasks_list.dart';
import 'package:daily_tasks/components/widgets/task_editForm.dart';
import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  final int index;
  final String text;
  late String isDone;

  final Function() notifyParent;

  Task(
      {required this.index,
      required this.text,
      required this.isDone,
      required this.notifyParent,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: !TasksList().isLast(this.index) ?
      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0)
      : const EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 40.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(16.0), right: Radius.circular(16.0)),
            color:
                this.isDone == 'true' ? AppColors().boxDone : AppColors().box,
            boxShadow: [
              BoxShadow(
                color: AppColors().boxDone.withOpacity(0.3), //color of shadow
                spreadRadius: 2, //spread radius
                blurRadius: 5, // blur radius
                offset: Offset(0, 2), // changes position of shadow
                //first parameter of offset is left-right
                //second parameter is top to down
              )
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () async {
                TasksList().changeState(this.index);
                this.notifyParent();

                await TasksList().analyze(this.notifyParent, () {
                  this.notifyParent();
                  TasksList().saveData();
                });

                print('Changed Task State');
                TasksList().saveData();
              },
              iconSize: 26.0,
              icon: Icon(
                this.isDone == 'true'
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
                color: this.isDone == 'true'
                    ? AppColors().iconDone
                    : AppColors().text,
              ),
              splashColor: AppColors().clear,
              highlightColor: AppColors().clear,
            ),
            Container(
              width: 2,
              height: 38.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: this.isDone == 'true'
                      ? AppColors().textDone
                      : AppColors().text),
            ),

            // To Do Text
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${this.text}',
                      style: TextStyle(
                          fontFamily: 'Neohellenic',
                          fontSize: 22.0,
                          fontWeight: FontWeight.w300,
                          decorationThickness: 1.2,
                          decoration: this.isDone == 'true'
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: this.isDone == 'true'
                              ? AppColors().textDone
                              : AppColors().text),
                    ))),
            IconButton(
              onPressed: () async {
                EditForm(index: this.index)
                    .showTaskEditDialog(context)
                    .then((value) => this.notifyParent());

                //await showInformationDialog(context);
              },
              iconSize: 20.0,
              icon: Icon(
                Icons.edit,
                color: this.isDone == 'true'
                    ? AppColors().textDone
                    : AppColors().text,
              ),
              splashColor: AppColors().clear,
              highlightColor: AppColors().clear,
            ),
          ],
        ),
      ),
    );
  }
}
