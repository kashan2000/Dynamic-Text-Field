import 'package:flutter/material.dart';
import 'package:test_app/textfeild.dart';
import 'dart:math';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int acceptedData = 0;
  List controllerslist = [];
  List<Map<String, double>> positions = [];
  List<Widget> allwidget = [];

  void addwidget() {
    setState(() {
      positions.add({"x": 100.0, "y": 100.0});
    });
    int index = positions.length - 1;
    setState(() {
      allwidget.add(Fields(positions[index], callback));
    });
    setState(() {
      positions;
      positions1 = positions;
      allwidget;
    });
  }

  bool isEnd = false;
  callback(bool isend) {
    if (isend) {
      isEnd = true;
      print("Is end");
      allwidget.remove(w);
    } else {
      isEnd = false;
    }
    setState(() {});
  }

  bool data1 = false;
  List positions1 = [];
  @override
  void initState() {
    positions1 = positions;
    // TODO: implement initState
    super.initState();
  }

  Widget? w;
  @override
  Widget build(BuildContext context) {
    int c = 0;

    if (!isEnd) {
      for (var element in positions) {
        // positions1.removeWhere((element1) => element == element1);
        // positions1.remove(element);
        for (var data in positions1) {
          allwidget.remove(w);
          print("Here");
          if ((data["x"] - element["x"]).abs() == 0 &&
              (element["y"]! - data["y"]).abs() == 0) {
          } else {
            if ((data["x"] - element["x"]).abs() < 10) {
              c = c + 1;

              w = Positioned(
                child: CustomPaint(
                  //                       <-- CustomPaint widget
                  size: Size(double.infinity, double.infinity),
                  painter: MyPainter(Offset(data["x"], data["y"]),
                      Offset(data["x"]!, element["y"]!), 1),
                ),
              );

              print("I am here");
              data1 = true;
            }
            if ((data["y"] - element["y"]).abs() < 10) {
              c = c + 1;

              w = Positioned(
                child: CustomPaint(
                  //                       <-- CustomPaint widget
                  size: Size(double.infinity, double.infinity),
                  painter: MyPainter(Offset(data["x"], data["y"]),
                      Offset(element["x"]!, data["y"]!), 0),
                ),
              );

              print("I am here");
              data1 = true;
            }
            if ((data["x"] + 150 - element["x"]).abs() < 10) {
              c = c + 1;

              w = Positioned(
                child: CustomPaint(
                  //                       <-- CustomPaint widget
                  size: Size(double.infinity, double.infinity),
                  painter: MyPainter(Offset(data["x"] + 150, data["y"]),
                      Offset(data["x"]! + 150, element["y"]!), 1),
                ),
              );

              print("I am here");
              data1 = true;
            }
          }
        }
        c == 0 ? data1 = false : data1 = true;
        if (c != 0) {
          allwidget.add(w ?? Container());
        }
      }
    }
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          addwidget();
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: Stack(
        children: allwidget,
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  Offset off1;
  Offset off2;
  int dist;
  MyPainter(this.off1, this.off2, this.dist);

  @override
  void paint(Canvas canvas, Size size) {
    final p1 = off1;
    final p2 = off2;
    TextSpan span = new TextSpan(
        style: new TextStyle(
            color: Colors.blue[800], fontSize: 15.0, fontFamily: 'Roboto'),
        text: (dist == 0 ? (off1.dx - off2.dx) : (off1.dy - off2.dy))
            .toInt()
            .abs()
            .toString());
    TextPainter tp =
        new TextPainter(text: span, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(
        canvas, new Offset((off1.dx + off2.dx) / 2, (off1.dy + off2.dy) / 2));
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
