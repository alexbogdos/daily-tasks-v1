import 'dart:async';

import 'package:daily_tasks/main.dart';
import 'package:flutter/material.dart';

import 'components/colors.dart';
import 'components/tasks_list.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double value = 0;

  void initState() {
    super.initState();
    indicateProgress();
    retrieveThemes();
    retrieveData().then((value) => _goToHomePage());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors().background,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Loading..',
              style: TextStyle(
                  fontFamily: 'Neohellenic',
                  fontSize: 24.0,
                  fontWeight: FontWeight.normal,
                  color: AppColors().date),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
              child: LinearProgressIndicator(
                backgroundColor: AppColors().appBar,
                color: AppColors().date,
                minHeight: 5,
              ),
            ),
          ],
        ),
      ),
    ));
  }
  Future<void> retrieveThemes() async {
    AppColors().retrieveThemes().then((value) => AppColors().retrieveThemeUsed());
    setState(() { });
  }

  Future<void> retrieveData() async {
    await TasksList().retrieveTexts();
    await TasksList().retrieveBools();

    print("Data Retrieved");
  }

  void indicateProgress() {
    new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (timer.isActive) {
        print('DISPOSE');
        timer.cancel();
        return;
      } else {
        setState(() {
          if (value >= 0.9) {
            timer.cancel();
          } else {
            value = value + 0.1;
          }
        });
      }
    });
  }

  _goToHomePage() {
    Future.delayed(Duration(milliseconds: 1)).then((value) =>
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home())));
  }
}
