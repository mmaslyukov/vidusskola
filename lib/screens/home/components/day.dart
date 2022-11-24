import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vidusskola/models/fetch.dart';

// class DayWidget extends StatefulWidget {
class DayWidget extends StatelessWidget {
  final int id;
  final SchoolDay day;
  void Function(int, bool) onChanged;
  bool selected = false;
  Color colorBackgroud = Colors.blue;
  Color colorSeleceted = Colors.blue.shade100;

  // set selected(bool selected) {
  //   _selected = selected;
  // }

  // void toggle() {
  //   _selected ^= true;
  // }

  // @override
  // State<DayWidget> createState() => _DayWidgetState();
  DayWidget(this.id, this.day, this.selected, this.onChanged, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(
            0), //only(top: 5, bottom: 5, left: 30, right: 30),
        child: InkWell(
          onTap: () {
            onChanged(id, true);
          },
          child: Container(
              constraints: BoxConstraints(
                minHeight: 50,
                minWidth: MediaQuery.of(context).size.width / 3.5,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.blueAccent),
                color: colorBackgroud,
                // borderRadius: BorderRadius.circular(2),
                border: Border(
                    bottom: BorderSide(
                        width: 5.0,
                        color: selected ? colorSeleceted : colorBackgroud)),
              ),
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(day.name,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.white))),
                  Text(day.date,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.blue.shade200))
                ],
              )),
        ));
  }
}
