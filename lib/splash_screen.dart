import 'package:flutter/material.dart';
import 'dart:async';
import "home_screen.dart";

class SplashScreen extends StatefulWidget{
  const SplashScreen({required this.titleApp, super.key});

  final String titleApp;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    super.initState();
    Timer(const Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => HomeScreen(title: widget.titleApp,)
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,

            colors: [Color(0xFFFF800B),Color.fromARGB(255, 155, 206, 16),]
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset(
                  "assets/immagini/2023/DUE-CARRARE_calendario_rifiuti.2023.jpg",
                  height:  (MediaQuery.of(context).size.height * 80 / 100),
                  width:  (MediaQuery.of(context).size.height * 80 / 100),
                ),
                const Text("DUE CARRARE - Calendatio Rifiuti 2923",textAlign:TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            const CircularProgressIndicator( 
              valueColor:  AlwaysStoppedAnimation<Color>(Colors.lightGreen),
            ),
          ],
        ),
      ),
    );
  }
}