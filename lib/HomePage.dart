import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gdsc_neom/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, required User? user, required this.title}): _user = user, super(key: key) ;

  final User? _user;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late User _user;

  @override
  void initState() {
    _user = widget._user!;
    super.initState();
  }
  final GoogleSignIn googleSignIn=GoogleSignIn();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Neom',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.teal[800],
          ),
          child: SafeArea(
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: const Alignment(0, -0.8),
                  child: Text(
                    'NEOM',
                    style: GoogleFonts.poiretOne(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),

                Align(
                  alignment: const Alignment(0,0.0),
                  child: FractionallySizedBox(
                    widthFactor: 0.8,
                    heightFactor: 0.38,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: Stack(
                        children: <Widget>[

                          Align(
                            alignment: const Alignment(0,-0.5),
                            child: ClipOval(
                              child: Image.network(_user.photoURL.toString()),
                            ),
                          ),


                          Align(
                            alignment: const Alignment(0,0.3),
                            child: AutoSizeText(
                              'Name: ${_user.displayName}',
                              maxLines: 1,
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),

                          Align(
                            alignment: const Alignment(0,0.5),
                            child: AutoSizeText(
                              'Email: ${_user.email}',
                              maxLines: 1,
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Align(
                  alignment: const Alignment(0, 0.8),
                  child: FractionallySizedBox(
                    widthFactor: 0.8,
                    heightFactor: 0.06,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                      onPressed: () {
                        signOut(context);
                        Navigator.push(
                          context,MaterialPageRoute(builder: (context) => const MyHomePage(title: '')),
                        );
                      },
                      child: const Text(
                        'Sign Out',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signOut(BuildContext context) async{
    await googleSignIn.signOut();
  }
}

