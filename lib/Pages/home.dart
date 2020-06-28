import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:bunkx2/main.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatefulWidget {
  final Map user;
  HomePage({this.user});
  @override
  _HomePageState createState() => _HomePageState(
        user: user,
      );
}

int sub = 0;

class _HomePageState extends State<HomePage> {
  final Map user;

  _HomePageState({this.user});

  int sem;
  @override
  void initState() {
    super.initState();

    sem = int.parse(user['sem']);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Bunk-X ',
            style: GoogleFonts.orbitron(
                textStyle:
                    TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return MyApp();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    gradient: LinearGradient(
                      colors: [
                        Colors.lightBlue,
                        Colors.purple,
                      ],
                    )),
                child: Center(
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Name: ${user['name']}',
                        style: GoogleFonts.righteous(
                          textStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Programme: ${user['programme']}',
                        style: GoogleFonts.righteous(
                          textStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Roll no: ${user['rollno']}',
                        style: GoogleFonts.righteous(
                          textStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'sem no: ${user['sem']}',
                        style: GoogleFonts.righteous(
                          textStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Click for more info',
                style: GoogleFonts.bungee(
                    textStyle: TextStyle(
                  fontSize: 20,
                )),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.label,
                      color: Colors.red,
                    ),
                    Text(
                      'Absent',
                      style: GoogleFonts.carterOne(
                          textStyle: TextStyle(
                        fontSize: 20,
                      )),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.label,
                      color: Colors.blue,
                    ),
                    Text(
                      'Present',
                      style: GoogleFonts.carterOne(
                          textStyle: TextStyle(
                        fontSize: 20,
                      )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Updated from:${user['attendance'][18]} till ${user['attendance'][19]}',
                style: GoogleFonts.spectral(
                    textStyle: TextStyle(
                  fontSize: 15,
                )),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      sub = 1;
                      _onButtonPressed();
                    });
                  },
                  child: Column(children: <Widget>[
                    chart(
                      attendance: user['attendance'][15],
                    ),
                    Text(
                      '${user['attendance'][10]}',
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontSize: 20,
                      )),
                    ),
                    Text(
                      '${user['subjects'][0]}',
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                    ),
                  ])),
              InkWell(
                onTap: () {
                  setState(() {
                    sub = 2;
                    _onButtonPressed();
                  });
                },
                child: Column(
                  children: <Widget>[
                    chart(
                      attendance: user['attendance'][25],
                    ),
                    Text(
                      '${user['attendance'][20]}',
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontSize: 20,
                      )),
                    ),
                    Text(
                      '${user['subjects'][1]}',
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                    ),
                  ],
                ),
              ),
              InkWell(
                // When the user taps the button, show a snackbar.
                onTap: () {
                  setState(() {
                    sub = 3;
                    _onButtonPressed();
                  });
                },
                child: Column(
                  children: <Widget>[
                    chart(
                      attendance: user['attendance'][35],
                    ),
                    Text(
                      '${user['attendance'][30]}',
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontSize: 20,
                      )),
                    ),
                    Text(
                      '${user['subjects'][2]}',
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                    ),
                  ],
                ),
              ),
              InkWell(
                // When the user taps the button, show a snackbar.
                onTap: () {
                  setState(() {
                    sub = 4;
                    _onButtonPressed();
                  });
                },
                child: Column(
                  children: <Widget>[
                    chart(
                      attendance: user['attendance'][45],
                    ),
                    Text(
                      '${user['attendance'][40]}',
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontSize: 20,
                      )),
                    ),
                    Text(
                      '${user['subjects'][3]}',
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                    ),
                  ],
                ),
              ),
              InkWell(
                // When the user taps the button, show a snackbar.
                onTap: () {
                  setState(() {
                    sub = 5;
                    _onButtonPressed();
                  });
                },
                child: Column(
                  children: <Widget>[
                    chart(
                      attendance: user['attendance'][55],
                    ),
                    Text(
                      '${user['attendance'][50]}',
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontSize: 20,
                      )),
                    ),
                    Text(
                      '${user['subjects'][4]}',
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                    ),
                  ],
                ),
              ),
              InkWell(
                // When the user taps the button, show a snackbar.
                onTap: () {
                  setState(() {
                    sub = 6;
                    _onButtonPressed();
                  });
                },
                child: Column(
                  children: <Widget>[
                    chart(
                      attendance: user['attendance'][65],
                    ),
                    Text(
                      '${user['attendance'][60]}',
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontSize: 20,
                      )),
                    ),
                    Text(
                      '${user['subjects'][5]}',
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                    ),
                  ],
                ),
              ),
              InkWell(
                // When the user taps the button, show a snackbar.
                onTap: () {
                  setState(() {
                    sub = 7;
                    _onButtonPressed();
                  });
                },
                child: Column(
                  children: <Widget>[
                    chart(
                      attendance: user['attendance'][75],
                    ),
                    Text(
                      '${user['attendance'][70]}',
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontSize: 20,
                      )),
                    ),
                    Text(
                      '${user['subjects'][6]}',
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                    ),
                  ],
                ),
              ),
              InkWell(
                // When the user taps the button, show a snackbar.
                onTap: () {
                  setState(() {
                    sub = 8;
                    _onButtonPressed();
                  });
                },
                child: Column(
                  children: <Widget>[
                    chart(
                      attendance: user['attendance'][85],
                    ),
                    Text(
                      '${user['attendance'][80]}',
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontSize: 20,
                      )),
                    ),
                    Text(
                      '${user['subjects'][7]}',
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onButtonPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 350.0,
            color: Colors.transparent,
            child: Container(
              child: _buildBottomNavigationMenu(),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                ),
              ),
            ),
          );
        });
  }

  Column _buildBottomNavigationMenu() {
    return Column(
      children: <Widget>[
        ListTile(
          title: Icon(Icons.drag_handle),
        ),
        ListTile(
          title: Text(
            'Total hours present :${user['attendance'][(sub * 10) + 4]}/${user['attendance'][(sub * 10) + 1]}',
            style: GoogleFonts.kanit(),
          ),
        ),
        ListTile(
          title: Text(
            'Total hours absent:${user['attendance'][(sub * 10) + 3]}/${user['attendance'][(sub * 10) + 1]}',
            style: GoogleFonts.kanit(),
          ),
        ),
        ListTile(
          title: Text(
            'Percentage with exemption:${user['attendance'][(sub * 10) + 6]}%',
            style: GoogleFonts.kanit(),
          ),
        ),
        ListTile(
          title: Text(
            'Percentage with medical exemption:${user['attendance'][(sub * 10) + 7]}%',
            style: GoogleFonts.kanit(),
          ),
        ),
        ListTile(
          title: Text(
            'Can Bunk:${_canBunk()}',
            style: GoogleFonts.kanit(),
          ),
        ),
      ],
    );
  }

  double _canBunk() {
    int totalhours = int.parse(user['attendance'][(sub * 10) + 1]);
    int bunked = int.parse(user['attendance'][(sub * 10) + 3]);
    double canbunk = (0.25 * totalhours) - bunked;
    return canbunk;
  }
}

class chart extends StatefulWidget {
  final String attendance;
  chart({this.attendance});
  @override
  _chartState createState() => _chartState(
        attendance: attendance,
      );
}

class _chartState extends State<chart> {
  final String attendance;
  _chartState({this.attendance});
  List<PieChartSectionData> _sections = List<PieChartSectionData>();
  @override
  void initState() {
    super.initState();
    PieChartSectionData item1 = PieChartSectionData(
      color: Colors.blue,
      value: double.parse(attendance),
      title: '$attendance',
      radius: 50,
      titleStyle: TextStyle(color: Colors.white, fontSize: 24),
    );
    PieChartSectionData item2 = PieChartSectionData(
      color: Colors.red,
      value: 100 - double.parse(attendance),
      title: '${100 - int.parse(attendance)}',
      radius: 50,
      titleStyle: TextStyle(color: Colors.white, fontSize: 24),
    );
    _sections = [item1, item2];
  }

  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 170,
      child: AspectRatio(
        aspectRatio: 1,
        child: PieChart(PieChartData(
            sections: _sections,
            borderData: FlBorderData(show: false),
            centerSpaceRadius: 30)),
      ),
    );
  }
}
