import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_project_create_vocalink/screens/login_screen.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen>{


  @override
  void initState(){
    super.initState();

    Timer(const Duration(seconds:2),(){
      if(!mounted) return;

      Navigator.pushReplacement(context,
       MaterialPageRoute(
        builder: (context) => const LoginScreen(),
       ),
       );
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFF3155E7),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height:95,
              width:95,
              decoration: BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              child:const Icon(
                Icons.phone_in_talk_rounded,
                size:52,
                color: const Color(0xFF3155E7),
              )
            ),
            const SizedBox(height: 25),

            const Text(
              'ConnectCall',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Connect with anyone, anywhere.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 45),

            const SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white,
                ),
              ),
            )

          ],) ,)
    );
  }
}

