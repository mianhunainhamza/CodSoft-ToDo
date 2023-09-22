import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return  Scaffold(
      backgroundColor: CupertinoColors.white,
      body: Column(
        children: [
           SizedBox(height: height * 0.1,),
           Text("CodeDo",style: GoogleFonts.novaFlat(
          decoration: TextDecoration.none,
            color: Colors.deepPurpleAccent,
            fontSize: 35
          ),),
          SizedBox(height: height * 0.05,),
          SizedBox(
            height: height * 0.3,
            width: width * 1,
            child: Image.asset("assets/images/start.png",fit: BoxFit.fill,),
          ),
          SizedBox(
            height: height * .05,
          ),
          //welcome text

          Text("Welcome to CodeDo",style: GoogleFonts.novaRound(
          decoration: TextDecoration.none,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          letterSpacing: 3,
          fontSize: 24
          )),
          SizedBox(height: height * 0.018,),
          SizedBox(
            width: width * 0.7,
            child: Text("CodeDo is best for saving your daily tasks and to follow a good"
                " time table and to manage your tasks with ease.",style: GoogleFonts.lato(
                decoration: TextDecoration.none,
                height: 1.5,
                letterSpacing: 3,
                color: Colors.black.withOpacity(0.4),
                fontSize: 15
            ),textAlign: TextAlign.center,),
          ),
          SizedBox(
            height: height * .13,
          ),
        ElevatedButton(
          onPressed: (){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
            return const HomePage();
          }), (a){
            return false;
          });
        },style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
            backgroundColor: Colors.deepPurpleAccent), child: Text("GET STARTED",style: GoogleFonts.novaFlat(
                decoration: TextDecoration.none,
                letterSpacing: 1,
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: height * .032,),
              ),),
        ],
      ),
    );
  }
}
