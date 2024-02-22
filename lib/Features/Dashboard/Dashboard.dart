import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int pos = 0;
  void getRank() async {
    var user = FirebaseAuth.instance.currentUser!.email;
    var inf = await FirebaseFirestore.instance
        .collection('User')
        .orderBy('rank', descending: true)
        .get();
    var data = [];
    for (int i = 0; i < inf.docs.length; i++) {
      data.add(inf.docs[i]['email']);
    }
    //data = inf.docs;
    pos = data.indexOf(user) + 1;
    if (mounted) {
      setState(() {});
    }
    print(pos);
  }

  @override
  void initState() {
    getRank();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        child: Padding(
          padding: const EdgeInsets.all(21.0),
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              SizedBox(
                width: 250,
                height: 200,
                child: AvatarGlow(
                  glowColor: Color(0xffDFCCFB),
                  glowRadiusFactor: 1,
                  child: Material(
                    // Replace this child with your own
                    elevation: 1.0,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "$pos",
                            style: GoogleFonts.poppins(
                                fontSize: 28, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "your rank",
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      radius: 110.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Row(
                children: [
                  Icon(
                    Icons.analytics_outlined,
                    color: Colors.purple,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
