import 'package:daily_tasks/components/colors.dart';
import 'package:daily_tasks/components/widgets/task_editForm.dart';
import 'package:flutter/material.dart';

class Date extends StatelessWidget {
  final int index;
  late String text;

  final Function() notifyParent;

  Date(
      {required this.index,
      required this.text,
      required this.notifyParent,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: this.index == 0
          ? EdgeInsets.only(top: 14.0)
          : EdgeInsets.only(top: 6.0),
      child: TextButton(
        onPressed: () async {
          EditForm(index: this.index, isDate: true)
              .showTaskEditDialog(context)
              .then((value) => this.notifyParent());
        },
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            '---- ${this.text.substring(5)} ----------------',
            style: TextStyle(
              fontFamily: 'Neohellenic',
              fontSize: 32.0,
              fontWeight: FontWeight.w800,
              color: AppColors().date,
            ),
          ),
        ),
      ),
    );
  }
}
