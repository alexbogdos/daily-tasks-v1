import 'package:daily_tasks/components/colors.dart';
import 'package:daily_tasks/components/widgets/themeColorValue_field.dart';
import 'package:daily_tasks/components/widgets/themeNameValue_field.dart';
import 'package:flutter/material.dart';

import 'components/widgets/custom_text.dart';

class ThemeInfoPage extends StatefulWidget {
  late String name;
  final int index;
  final List<String> colors;
  final bool isNew;
  ThemeInfoPage({required this.name, required this.index, required this.colors, this.isNew = false, Key? key}) : super(key: key);

  @override
  _ThemeInfoPageState createState() => _ThemeInfoPageState();
}

class _ThemeInfoPageState extends State<ThemeInfoPage> {

  double separationWidth = 10.0;

  @override
  Widget build(BuildContext context) {
    widget.name = AppColors().getThemeNameOnIndex(widget.index);
    print('is new: ${widget.isNew}');
    print('index: ${widget.index}');
    print('=========================================== ReBuild: Theme Info Page ===========================================');
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors().background,
        appBar: AppBar(
          centerTitle: true,
          title: customText(widget.name),
          backgroundColor: AppColors().appBar,
          iconTheme: IconThemeData(
            color: AppColors().date,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(18),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                ThemeNameValueField(themeIndex: widget.index, notifyParent: _refresh),
                SizedBox(height: 40.0, child: Center(child: Container(margin: EdgeInsets.only(bottom: 4.0),height: 2, color: AppColors().date,)),),

                valueBox(ThemeColorValueField(index: 0, themeIndex: widget.index, themeColors: widget.colors, notifyParent: _refresh, isNew: widget.isNew,),
                  ThemeColorValueField(index: 1, themeIndex: widget.index, themeColors: widget.colors, notifyParent: _refresh, isNew: widget.isNew,),),
                valueBox(ThemeColorValueField(index: 2, themeIndex: widget.index, themeColors: widget.colors, notifyParent: _refresh, isNew: widget.isNew,),
                  ThemeColorValueField(index: 3, themeIndex: widget.index, themeColors: widget.colors, notifyParent: _refresh, isNew: widget.isNew,),),
                valueBox(ThemeColorValueField(index: 4, themeIndex: widget.index, themeColors: widget.colors, notifyParent: _refresh, isNew: widget.isNew,),
                  ThemeColorValueField(index: 5, themeIndex: widget.index, themeColors: widget.colors, notifyParent: _refresh, isNew: widget.isNew,),),
                valueBox(ThemeColorValueField(index: 6, themeIndex: widget.index, themeColors: widget.colors, notifyParent: _refresh, isNew: widget.isNew,),
                  ThemeColorValueField(index: 7, themeIndex: widget.index, themeColors: widget.colors, notifyParent: _refresh, isNew: widget.isNew,),),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget valueBox (Widget child1, Widget child2) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          child1,
          Container(
            width: separationWidth,
          ),
          child2,
        ],
      ),
    );
  }
  _refresh () {
    setState(() { });
  }
}
