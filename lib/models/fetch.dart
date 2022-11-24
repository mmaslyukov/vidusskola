import 'dart:io' as io;

// import 'package:flutter/foundation.dart';
import 'package:html/parser.dart' as parser;

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// Future<Album> fetchAlbum() async {
//   final response = await http
//       .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Album.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

class Details {
  String text;
  String? theme;
  List<String>? links;
  Details({required this.text, this.theme, this.links});
  @override
  String toString() {
    return "{text:\"${this.text}\"";
  }
}

class Lesson {
  // String? order;
  String name;
  String? room;
  Details? homeWork;

  Lesson({required this.name, this.room, this.homeWork});

  @override
  String toString() {
    return "{name:\"${this.name}\", room: \"${this.room}\", homework: ${this.homeWork}";
  }
}

class SchoolDay {
  String date;
  String name;
  List<Lesson> lessons = [];
  SchoolDay({required this.date, required this.name, List<Lesson>? lessons}) {
    if (lessons != null) {
      this.lessons = lessons;
    }
  }
  @override
  String toString() {
    var lessons = "";
    this.lessons.forEach((element) {
      lessons += element.toString() + ',';
    });

    return "{name:\"${this.name}\", date:\"${this.date}\", lessons: [${lessons}]";
  }
}

class Profile {
  String name = "";
  String school = "";
  List<SchoolDay> schedule = [];
}

Future<String?> login(String username, String password) async {
  var url =
      "https://my.e-klase.lv/?fake_pass=${password}&UserName=${username}&Password=${password}&cmdLogIn=";
  final response = await http.post(Uri.parse(url));
  // print(url);
  // print(response.headers.toString());
  // print(response.body.toString());
  final auth = response.headers["set-cookie"]?.split(';').first;
  // print(auth);
  return auth;
}

Future<Profile?> schedule(String auth) async {
  DateTime today = DateTime.now();
  final DateFormat formatter = DateFormat('dd.MM.yyyy');
  switch (today.weekday) {
    case DateTime.saturday:
      {
        today.add(const Duration(days: 2));
      }
      break;
    case DateTime.sunday:
      {
        today.add(const Duration(days: 1));
      }
      break;
    default:
      {}
      break;
  }

  final date = formatter.format(today);
  final url = "https://my.e-klase.lv/Family/Diary?Date=${date}";

  var headers = {"Cookie": auth};
  final response = await http.get(Uri.parse(url), headers: headers);
  final profile = parse(response.body);
  return profile;
}

Profile parse(String content) {
  var p = parser.parse(content);
  final table = p.body?.getElementsByClassName("lessons-table");

  List<SchoolDay> days = [];
  table?.forEach((day) {
    SchoolDay sd = SchoolDay(date: "Unknown", name: "Unknown");
    final dayname = day.previousElementSibling?.text.trim().split(". ");
    if (dayname != null) {
      sd.date = dayname[0];
      sd.name = dayname[1].trim().split(' ')[0];
    }
    var dayIt = day.nodes.iterator;
    while (dayIt.moveNext()) {
      if (dayIt.current.children.length < 2) {
        continue;
      }
      // print("day-----`");
      var lit = dayIt.current.nodes.iterator;
      while (lit.moveNext()) {
        if (lit.current.children.isEmpty) {
          continue;
        }
        Lesson lesson = Lesson(name: "Unknown");

        var title = lit.current.children[0].getElementsByClassName("title");
        if (title.isNotEmpty) {
          lesson.name = title.first.text.split('\n')[1].trim();
          // print("lesson: ${lesson.name}");
        }
        var room = lit.current.children[0].getElementsByClassName("room");
        if (room.isNotEmpty) {
          lesson.room = room.first.text.trim();
          // print("room: ${lesson.room}");
        }

        lit.current.children[2].children.forEach((element) {
          if (lesson.homeWork == null) {
            lesson.homeWork =
                Details(text: element.text.trim().replaceAll("http", "\nhttp"));
            return;
          }
          lesson.homeWork!.text +=
              "\n" + element.text.trim().replaceAll("http", "\nhttp");
          // print("##HM (${lesson.name}): ${lesson.homeWork}");
        });
        sd.lessons.add(lesson);
        // days.add(SchoolDay(name: name));
      }
    }
    days.add(sd);
  });
  Profile profile = Profile();
  profile.schedule = days;
  final student =
      p.body?.getElementsByClassName("mobile-student-profile-switcher");
  if (student != null) {
    profile.name = student.first.children[0].text;
    profile.school = student.first.children[1].text;
  }
  return profile;
}

//name /html/body/div[1]/div/div[6]/section/div[1]/div[1]/table[1]/tbody/tr[2]/td[1]/div/span[2]
//room /html/body/div[1]/div/div[6]/section/div[1]/div[1]/table[1]/tbody/tr[2]/td[1]/div/span[2]/span
//theme /html/body/div[1]/div/div[6]/section/div[1]/div[1]/table[1]/tbody/tr[2]/td[2]/div
//table /html/body/div[1]/div/div[6]/section/div[1]/div[1]/table[1]
//homework /html/body/div[1]/div/div[6]/section/div[1]/div[1]/table[1]/tbody/tr[2]/td[3]/span/p

void main(List<String> args) {
  // login("322345-76712", "b*izdota").then((value) => schedule(value!));
  io.File("dairy.html").readAsString().then((value) {
    print('File Contents\n---------------');
    final days = parse(value);
    // days.forEach((element) {
    //   print("---");
    //   print(element);
    // });
  });
}
