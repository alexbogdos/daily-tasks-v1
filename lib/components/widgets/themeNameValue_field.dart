import 'package:daily_tasks/components/colors.dart';
import 'package:flutter/material.dart';

class ThemeNameValueField extends StatefulWidget {
  final int themeIndex;
  final bool isNew;
  final Function() notifyParent;
  const ThemeNameValueField({required this.themeIndex,this.isNew = false,required this.notifyParent,Key? key}) : super(key: key);

  @override
  _ThemeNameValueFieldState createState() => _ThemeNameValueFieldState();
}

class _ThemeNameValueFieldState extends State<ThemeNameValueField> {

  @override
  Widget build(BuildContext context) {

    TextEditingController textValue = TextEditingController();
    print('=========================================== ReBuild: name value field ===========================================');
    return Form(
        child: TextFormField(
            validator: (value) {
              return value!.isNotEmpty ? null : "Invalid Field";
            },
            initialValue: AppColors().getThemeNameOnIndex(widget.themeIndex),

            onChanged: (value) {
              textValue.text = value;
            },
            onTap: () {
              textValue.text =  AppColors().getThemeNameOnIndex(widget.themeIndex);
            },
            onEditingComplete: () {
              print(textValue.text);

              if (!widget.isNew) {
                AppColors().changeThemeName(widget.themeIndex, textValue.text);
                var names = AppColors().getNames();
                if (names[widget.themeIndex] == AppColors().themeUsed) {
                  print('used theme');
                  AppColors().refreshTheme(widget.themeIndex);
                }
              }

              setState(() {  });
              widget.notifyParent();
            },
            style: TextStyle(fontWeight: FontWeight.w500),
            decoration: InputDecoration(
                labelText: "Name",
                enabledBorder: themeBorder(),
                focusedBorder: themeBorder(),
                labelStyle: TextStyle(
                    fontFamily: 'Neohellenic',
                    fontSize: 22.0,
                    fontWeight: FontWeight.normal),
                counterStyle: TextStyle(color: AppColors().background),
            )));
  }

  OutlineInputBorder themeBorder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
      //Outline border type for Text Field
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: AppColors().appBar,
          width: 3,
        ));
  }


}
