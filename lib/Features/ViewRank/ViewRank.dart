import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewRank extends StatefulWidget {
  ViewRank({super.key});

  @override
  State<ViewRank> createState() => _ViewRankState();
}

class _ViewRankState extends State<ViewRank> {
  int pos = 0;
  String name = "";

  void getRank() async {
    var user = FirebaseAuth.instance.currentUser!.email;
    var inf = await FirebaseFirestore.instance
        .collection('User')
        .orderBy('rank', descending: true)
        .get();
    // var data = [];
    // for (int i = 0; i < inf.docs.length; i++) {
    //   data.add(inf.docs[i]['email']);
    // }
    // //data = inf.docs;
    // pos = data.indexOf(user) + 1;
    name = inf.docs[0]['email'].toString().split("@")[0];
    setState(() {});
    print(pos);
  }

  int index = 0;

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
        child: Column(
          children: [
            const SizedBox(height: 100),
            SizedBox(
              width: 250,
              height: 200,
              child: AvatarGlow(
                glowColor: const Color(0xffDFCCFB),
                glowRadiusFactor: 1,
                child: Material(
                  // Replace this child with your own
                  elevation: 1.0,
                  shape: const CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    radius: 110.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$name",
                          style: GoogleFonts.poppins(
                              fontSize: 28, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "GOAT",
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .5,
              child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('User')
                      .orderBy('rank', descending: true)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * .5,
                      child: ListView(
                        children: snapshot.data!.docs
                            .map((e) => ListTile(
                                  leading: Text(
                                    " ",
                                    //  (snapshot.data!.docs.indexOf(e) + 1)
                                    //      .toString(),
                                    style: GoogleFonts.poppins(fontSize: 13),
                                  ),
                                  title: Text(
                                    e['email'].toString().split('@')[0],
                                    style: GoogleFonts.poppins(fontSize: 16),
                                  ),
                                  subtitle: Text(
                                    e['email'],
                                    style: GoogleFonts.poppins(fontSize: 12),
                                  ),
                                ))
                            .toList(),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
