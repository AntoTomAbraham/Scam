import 'package:animate_do/animate_do.dart';
import 'package:boltapp/Features/Home/Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Color(0xffDFCCFB),
          Color(0xffDFCCFB),
          Color(0xffDFCCFB),
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      child: Text(
                        "Signup",
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 40),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  FadeInUp(
                      duration: const Duration(milliseconds: 1300),
                      child: Text(
                        "Welcome!!!",
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 18),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 60,
                      ),
                      FadeInUp(
                          duration: const Duration(milliseconds: 1400),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  const BoxShadow(
                                      color: Color(0xffDFCCFB),
                                      blurRadius: 20,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: TextField(
                                    controller: email,
                                    decoration: const InputDecoration(
                                        hintText: "Email or Phone number",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: TextField(
                                    obscureText: true,
                                    controller: pass,
                                    decoration: const InputDecoration(
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 40,
                      ),
                      FadeInUp(
                          duration: const Duration(milliseconds: 1500),
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.grey),
                          )),
                      const SizedBox(
                        height: 40,
                      ),
                      FadeInUp(
                          duration: const Duration(milliseconds: 1600),
                          child: MaterialButton(
                            onPressed: () async {
                              try {
                                final credential = await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: email.text, password: pass.text);
                                final User user = credential.user!;
                                print(user);
                                if (user.uid.isNotEmpty) {
                                  FirebaseFirestore.instance
                                      .collection('User')
                                      .doc(user.email)
                                      .set({
                                        'name':user.email!.split('@')[0],
                                        'email':user.email,
                                        'uid':user.uid,
                                        'rank':0,
                                        'password':pass.text
                                      });
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) => Home(),
                                  ));
                                }
                                //if(user)
                              } on FirebaseAuthException catch (e) {
                                print(e);
                                if (e.code == 'user-not-found') {
                                  print('No user found for that email.');
                                } else if (e.code == 'wrong-password') {
                                  print(
                                      'Wrong password provided for that user.');
                                }
                              }
                              // Navigator.of(context)
                              //     .pushReplacement(MaterialPageRoute(
                              //   builder: (context) => Home(),
                              // ));
                            },
                            height: 50,
                            // margin: EdgeInsets.symmetric(horizontal: 50),
                            color: const Color(0xffDFCCFB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            // decoration: BoxDecoration(
                            // ),
                            child: const Center(
                              child: Text(
                                "Signup",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 50,
                      ),
                      // FadeInUp(
                      //     duration: const Duration(milliseconds: 1700),
                      //     child: const Text(
                      //       "Continue with social media",
                      //       style: TextStyle(color: Colors.grey),
                      //     )),
                      // const SizedBox(
                      //   height: 30,
                      // ),
                      // Row(
                      //   children: <Widget>[
                      //     Expanded(
                      //       child: FadeInUp(
                      //           duration: const Duration(milliseconds: 1800),
                      //           child: MaterialButton(
                      //             onPressed: () {},
                      //             height: 50,
                      //             color: Colors.blue,
                      //             shape: RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(50),
                      //             ),
                      //             child: const Center(
                      //               child: Text(
                      //                 "Facebook",
                      //                 style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontWeight: FontWeight.bold),
                      //               ),
                      //             ),
                      //           )),
                      //     ),
                      //     const SizedBox(
                      //       width: 30,
                      //     ),
                      //     Expanded(
                      //       child: FadeInUp(
                      //           duration: const Duration(milliseconds: 1900),
                      //           child: MaterialButton(
                      //             onPressed: () {},
                      //             height: 50,
                      //             shape: RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(50),
                      //             ),
                      //             color: Colors.black,
                      //             child: const Center(
                      //               child: Text(
                      //                 "Github",
                      //                 style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontWeight: FontWeight.bold),
                      //               ),
                      //             ),
                      //           )),
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
