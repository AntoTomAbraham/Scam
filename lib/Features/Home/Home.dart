import 'package:boltapp/Features/AddFood/AddFood.dart';
import 'package:boltapp/Features/Dashboard/Dashboard.dart';
import 'package:boltapp/Features/ViewRank/ViewRank.dart';
import 'package:boltapp/Features/Yoga/Yoga.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List pages = [
    Dashboard(),
    AddFood(),
    ViewRank(),
    Yoga(),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white, // Background color of the bottom app bar
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home_max,
                color: Color(0xffBEADFA),
              ),
              onPressed: () {
                setState(() {
                  index = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.food_bank_rounded,
                color: Color(0xffBEADFA),
              ),
              onPressed: () {
                setState(() {
                  index = 1;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.leaderboard_outlined,
                color: Color(0xffBEADFA),
              ),
              onPressed: () {
                setState(() {
                  index = 2;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.sports_score,
                color: Color(0xffBEADFA),
              ),
              onPressed: () async {
                setState(() {
                  index = 3;
                });
                var userData =
                    await FirebaseFirestore.instance.collection('User').get();
                for (var i = 0; i < userData.docs.length; i++) {
                  var uid = userData.docs[i].id;
                  var data = await FirebaseFirestore.instance
                      .collection('consumed')
                      .where('time',
                          isGreaterThan:
                              DateTime.now().subtract(Duration(days: 7)))
                      .where('email', isEqualTo: uid)
                      .get();
                  int prtn = 0;
                  int fat = 0;
                  int fbr = 0;
                  int crbs = 0;
                  for (var j = 0; j < data.docs.length; j++) {
                    prtn = prtn + int.parse(data.docs[j]['Protein'].toString());
                    fat = fat + int.parse(data.docs[j]['Fat'].toString());
                    fbr = fbr + int.parse(data.docs[j]['Fiber'].toString());
                    crbs = crbs + int.parse(data.docs[j]['Carbs'].toString());
                  }
                  int us = 0;
                  //int us = userData.docs[i]['rank'];
                  double prtnWeek = prtn / 60;
                  double fatweek = fat / 30;
                  double fbrweek = fbr / 60;
                  double crbsweek = crbs / 60;
                  // print(prtnWeek);
                  // print(fatweek);
                  // print(fbrweek);
                  // print(crbsweek);
                  us += cal(prtnWeek) +
                      cal(fatweek) +
                      cal(fbrweek) +
                      cal(crbsweek);
                  print(uid);
                  print(us);
                  FirebaseFirestore.instance
                      .collection('User')
                      .doc(uid)
                      .update({'rank': us});
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  int cal(val) {
    int sum = 0;
    if (val > 0.9 && val < 1.1) {
      sum = 5;
    } else if (val > 0.8 && val < 0.9) {
      sum = 4;
    } else if (val > 0.7 && val < 0.8) {
      sum = 3;
    } else if (val > 0.6 && val < 0.7) {
      sum = 2;
    } else {
      sum = 1;
    }
    return sum;
  }
}
