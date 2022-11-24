import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter
// import 'package:f
import 'package:vidusskola/models/fetch.dart';
import 'package:vidusskola/constants.dart';

class LessonPanel {
  Lesson lesson;
  bool isExpanded = false;
  final Icon iconpic = const Icon(Icons.image);
  LessonPanel(this.lesson);
}

class LessonsWidget extends StatefulWidget {
  List<LessonPanel> lessonPanel = [];
  @override
  State<LessonsWidget> createState() => _LessonsWidgetState();
  LessonsWidget(List<Lesson> lessons, {super.key}) {
    for (var l in lessons) {
      lessonPanel.add(LessonPanel(l));
    }
  }
}

class _LessonsWidgetState extends State<LessonsWidget> {
  List<ExpansionPanel> makePanels() {
    List<ExpansionPanel> panels = [];
    for (var lp in widget.lessonPanel) {
      panels.add(ExpansionPanel(
        canTapOnHeader: true,
        isExpanded: lp.lesson.homeWork == null ? false : lp.isExpanded,
        headerBuilder: (BuildContext context, bool isExpanded) {
          return ListTile(
            leading: const Icon(
              kIconAssignment,
              color: kColorTheme,
            ),
            trailing: lp.lesson.homeWork == null
                ? SizedBox.shrink()
                : Icon(kIconHome, color: Color.fromARGB(255, 255, 64, 0)),
            title: Text(
              lp.lesson.name,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: Text(lp.lesson.room == null ? "" : lp.lesson.room!),
          );
        },
        body: lp.lesson.homeWork == null
            ? SizedBox.shrink()
            : Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(10),
                child: SelectableLinkify(
                    text: lp.lesson.homeWork!.text,
                    onOpen: (link) {
                      canLaunch(link.url).then((value) {
                        if (value) {
                          launch(link.url);
                        }
                      });
                    },
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ))),
      ));
    }
    return panels;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            bool isCurrentExpanded = widget.lessonPanel[index].isExpanded;
            for (var i = 0; i < widget.lessonPanel.length; i++) {
              widget.lessonPanel[i].isExpanded = false;
            }
            widget.lessonPanel[index].isExpanded = !isCurrentExpanded;
          });
        },
        children: makePanels());
  }
}
