import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:vidusskola/constants.dart';
import 'package:vidusskola/models/fetch.dart';
import 'package:vidusskola/screens/home/components/day.dart';
import 'package:vidusskola/screens/home/components/lessons.dart';
import 'package:vidusskola/screens/login/login_screen.dart';

class HomeScreen extends StatefulWidget {
  final Profile profile;
  List<bool> daySelected = []; //[false, false, false, false, false];
  List<GlobalKey> keys = []; //[false, false, false, false, false];
  int dayIndex = 0;

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  HomeScreen({required this.profile}) {
    for (var s in profile.schedule) {
      daySelected.add(false);
      keys.add(GlobalKey());
    }
    var weekday = DateTime.now().weekday;
    dayIndex = (weekday <= DateTime.friday ? weekday : DateTime.monday) - 1;
    daySelected[dayIndex] = true;
    // print("day ${dayIndex}");
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  void _onDayClick(int id, bool selected) {
    setState(() {
      for (var i = 0; i < widget.daySelected.length; i++) {
        widget.daySelected[i] = false;
      }
      widget.daySelected[id] = selected;
      widget.dayIndex = id;
      Scrollable.ensureVisible(
        widget.keys[id].currentContext!,
        duration: const Duration(milliseconds: 400),
      );
    });
  }

  @override
  void initState() {
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<DayWidget> days = [];
    for (int id = 0; id < 5; id++) {
      days.add(DayWidget(
        id,
        widget.profile.schedule[id],
        widget.daySelected[id],
        _onDayClick,
        key: widget.keys[id],
      ));
    }

    var built_widget = Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => LoginScreen()));
              },
            )
          ],
          centerTitle: true,
          title: Column(
            children: [
              Text(widget.profile.name),
              Text(widget.profile.school,
                  style: const TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w400,
                  )),
            ],
          ),
          backgroundColor: kColorTheme,
          foregroundColor: kTextLightColor,
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 10),
                    scrollDirection: Axis.horizontal,
                    child: Row(children: days)),
                Expanded(
                    child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: LessonsWidget(
                      widget.profile.schedule[widget.dayIndex].lessons),
                ))
              ],
            )));

    return built_widget;
  }
}
