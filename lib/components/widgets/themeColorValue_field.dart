import 'package:daily_tasks/components/colors.dart';
import 'package:flutter/material.dart';

class ThemeColorValueField extends StatefulWidget {
  final int index;
  final int themeIndex;
  final List<String> themeColors;
  final bool isNew;
  final Function() notifyParent;
  const ThemeColorValueField({required this.index, required this.themeIndex,required this.themeColors, this.isNew = false,required this.notifyParent,Key? key}) : super(key: key);

  @override
  _ThemeColorValueFieldState createState() => _ThemeColorValueFieldState();
}

class _ThemeColorValueFieldState extends State<ThemeColorValueField> {

  List<String> colorNames = [
    'Background',
    'Date Text',
    'App Bar',
    'Item Box',
    'Item Box Done',
    'Item Box Text',
    'Item Box Text Done',
    'Item Icons Ticked Color'
  ];

  @override
  Widget build(BuildContext context) {

    TextEditingController textValue = TextEditingController();
    print('=========================================== ReBuild: color value field ===========================================');
    return Expanded(
      child: Form(
          child: TextFormField(
              validator: (value) {
                return value!.isNotEmpty ? null : "Invalid Field";
              },
              initialValue: '${widget.themeColors[widget.index].toString().substring(1)}',

              onChanged: (value) {
                textValue.text = value;
              },
              onTap: () {
                textValue.text = '${widget.themeColors[widget.index].toString().substring(1)}';
              },
              onEditingComplete: () {
                print('#${textValue.text}');

                String _color = '#${textValue.text}';
                if (!AppColors().isHexColor(_color)) {
                  return;
                }

                AppColors().changeThemeValuesOnIndex(widget.themeIndex, widget.index, '#${textValue.text}');
                if (!widget.isNew) {
                  var names = AppColors().getNames();
                  if (widget.themeIndex == AppColors().themeUsed) {
                    print('used theme');
                    AppColors().refreshTheme(widget.themeIndex);
                  }else {
                    print(widget.themeIndex);
                    print(names);
                    print ('did not refresh theme ${names[widget.themeIndex]}  ${AppColors().themeUsed}');
                  }
                  var values = AppColors().getValues(widget.themeIndex);
                  widget.themeColors[widget.index] = values[widget.index];
                }

                setState(() {  });
                widget.notifyParent();
              },
              style: TextStyle(fontWeight: FontWeight.w500),
              maxLength: 6,
              decoration: InputDecoration(
                  labelText: "${colorNames[widget.index]}",
                  enabledBorder: !widget.isNew ? existingThemeBorder() : newThemeBorder(),
                  focusedBorder: !widget.isNew ? existingThemeBorder() : newThemeBorder(),
                  labelStyle: TextStyle(
                      fontFamily: 'Neohellenic',
                      fontSize: 22.0,
                      fontWeight: FontWeight.normal),
                  counterStyle: TextStyle(color: AppColors().background),
                  prefixText: '#'))),
    );
  }

  OutlineInputBorder existingThemeBorder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
      //Outline border type for Text Field
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: AppColors().stringToColor(widget.themeColors[widget.index]),
          width: 3,
        ));
  }

  OutlineInputBorder newThemeBorder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
      //Outline border type for Text Field
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: AppColors().date,
          width: 3,
        ));
  }
}
