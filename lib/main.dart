// @dart=2.9

import 'package:flutter/material.dart';
import 'package:vidusskola/constants.dart';
import 'package:vidusskola/models/fetch.dart';
import 'package:vidusskola/screens/home/home_screen.dart';
import 'package:vidusskola/screens/login/login_screen.dart';
import 'package:vidusskola/models/fetch.dart' as fetcher;

//https://my.e-klase.lv/?fake_pass=b*izdota&UserName=322345-76712&Password=b*izdota&cmdLogIn=
//https://my.e-klase.lv/Family/Diary
//cookie: .ASPXAUTH_EKLASE_3
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();
  // const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<SchoolDay> schedule = [];
    schedule.add(SchoolDay(date: "21.11.22", name: "Понидельник", lessons: [
      Lesson(
          name: "lesson1_1", room: "312", homeWork: Details(text: "Homework")),
      Lesson(name: "lesson2_1"),
      Lesson(name: "lesson3_1")
    ]));
    schedule.add(SchoolDay(date: "22.11.22", name: "Вторник", lessons: [
      Lesson(name: "lesson1_2"),
      Lesson(name: "lesson2_2"),
      Lesson(name: "lesson3_2"),
      Lesson(name: "lesson4_2")
    ]));
    schedule.add(SchoolDay(date: "23.11.22", name: "Среда", lessons: [
      Lesson(name: "lesson1_3"),
      Lesson(name: "lesson2_3"),
    ]));
    schedule.add(SchoolDay(date: "24.11.22", name: "Четверг", lessons: []));
    schedule.add(SchoolDay(date: "25.11.22", name: "Пятница", lessons: []));

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: kColorTheme,
        ),
        // home: HomeScreen(schedule: schedule)
        home: LoginScreen());
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
