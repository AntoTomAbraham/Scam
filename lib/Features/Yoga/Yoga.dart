import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Yoga extends StatelessWidget {
  Yoga({super.key});

  List ex = [
    "Bakasana","Bhujangasana","Dhanurasana","Halasana","Mayurasana","Padhastasana","Sarvangasana","Sirsasana","Sukhasana","Tadasana","Trikonasana","Ustrasana","Virbhadrasana","Vrikshasana"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height: MediaQuery.of(context).size.height*.6,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: ex.map((e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                width: MediaQuery.of(context).size.width*1-40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/Images/${e}.png"),
                    SizedBox(height: 10),
                    Text(e.toString(),style: GoogleFonts.poppins(fontSize: 22,color: Colors.purple),)
                  ],
                ),
                          ),
              )).toList(),),
            )
          ],
        ),
      ),
    );
  }
}
