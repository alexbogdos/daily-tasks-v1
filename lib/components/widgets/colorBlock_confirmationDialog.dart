import 'package:daily_tasks/components/colors.dart';
import 'package:flutter/material.dart';

class ConfirmDialog {
  final String name;
  final int index;
  final Function notifyParent;

  ConfirmDialog(
      {required this.index, required this.name, required this.notifyParent});

  Future<void> showConfirmationDialog(BuildContext context) async {
    double buttonOpacity = 0.8;

    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors().background,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Are you sure you want to delete ${this.name}?",
                  style: TextStyle(
                      color: AppColors().date,
                      fontFamily: 'Neohellenic',
                      fontWeight: FontWeight.w700,
                      fontSize: 24.0),
                ),
                SizedBox(
                  height: 12.0,
                ),
              ],
            ),
            actions: [
              TextButton(
                  child: Text('No'),
                  style: TextButton.styleFrom(
                    backgroundColor:
                        AppColors().date.withOpacity(buttonOpacity),
                    primary: AppColors().text,
                  ),
                  onPressed: () {
                    print(this.index);
                    Navigator.of(context).pop();
                  }),
              TextButton(
                  child: Text('Yes'),
                  style: TextButton.styleFrom(
                    backgroundColor:
                        AppColors().date.withOpacity(buttonOpacity),
                    primary: AppColors().text,
                  ),
                  onPressed: () {
                    AppColors()
                        .deleteTheme(this.index)
                        .then((value) => afterDelete(context))
                        .then((value) => AppColors().saveColors());
                    print('deleted');
                  })
            ],
          );
        });
  }

  void afterDelete(var context) {
    this.notifyParent();
    Navigator.of(context).pop();
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
}
