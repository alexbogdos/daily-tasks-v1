import 'package:daily_tasks/components/widgets/colorBlock_confirmationDialog.dart';
import 'package:daily_tasks/themeInfo_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class ColorBlock extends StatelessWidget {
  final String name;
  final int index;
  final Function() notifyParent;

  const ColorBlock(
      {required this.name,
      required this.index,
      required this.notifyParent,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> colors = AppColors().getValues(this.index);

    return TextButton(
      onPressed: () {
        AppColors().setNewColorList(colors);
        AppColors().setThemeUsed(this.index);
        this.notifyParent();
        AppColors().saveColors();
      },
      style: TextButton.styleFrom(
        primary: Colors.white,
      ),
      child: Container(
        margin: EdgeInsets.fromLTRB(6.0, 4.0, 6.0, 0.0),
        padding: EdgeInsets.fromLTRB(18, 2, 18, 2),
        decoration: BoxDecoration(
            color: AppColors().box.withOpacity(0.8),
            borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 2.4, color: this.index == AppColors().themeUsed ? AppColors().appBar : AppColors().background)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${this.name}',
                  style: TextStyle(
                    color: AppColors().boxDone,
                    fontFamily: 'Neohellenic',
                    fontSize: 24.0,
                  ),
                ),
                !(this.name == 'Default' && this.index == 0)
                    ? Row(
                        children: [
                          // ____ Action Buttons ____________________________________________
                          IconButton(
                            onPressed: () {
                              print('edit ${this.name}?');
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ThemeInfoPage(name: this.name, index: this.index, colors: colors,)),
                              ).then((value) => this.notifyParent()).then((value) => AppColors().saveColors());
                            },
                            icon: Icon(
                              Icons.edit,
                              size: 22,
                              color: AppColors().boxDone,
                            ),
                            constraints: BoxConstraints(maxHeight: 34),
                          ),
                          IconButton(
                            onPressed: () {
                              print('delete ${this.index}');
                              ConfirmDialog(
                                      index: this.index,
                                      name: this.name,
                                      notifyParent: this.notifyParent)
                                  .showConfirmationDialog(context);
                            },
                            icon: Icon(
                              Icons.delete,
                              size: 22,
                              color: AppColors().boxDone,
                            ),
                            constraints: BoxConstraints(maxHeight: 34),
                          )
                        ],
                      )
                    : Text('')
              ],
            ),
            Container(
              margin: !(this.name == 'Default' && this.index == 0)
                  ? EdgeInsets.only(bottom: 6)
                  : EdgeInsets.only(bottom: 6, top: 6),
              height: 2.0,
              color: AppColors().background,
              child: Text(''),
            ),
            Row(
              children: [
                _block(colors, 0),
                _block(colors, 1),
                _block(colors, 2),
                _block(colors, 3),
                _block(colors, 4),
                _block(colors, 5),
                _block(colors, 6),
                _block(colors, 7),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _block(List<String> colors, int index) {
    return Expanded(
      flex: 1,
      child: Container(
        child: Text(''),
        decoration: BoxDecoration(
            color: AppColors().stringToColor(colors[index]),
            border: Border(
              right: BorderSide(color: AppColors().background.withOpacity(0.4)),
              left: BorderSide(color: AppColors().background.withOpacity(0.4)),
              top: BorderSide(color: AppColors().background.withOpacity(0.4)),
              bottom:
                  BorderSide(color: AppColors().background.withOpacity(0.4)),
            )),
      ),
    );
  }
}
