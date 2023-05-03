import 'package:chat_bot/Chat_screen.dart';
import 'package:chat_bot/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:chat_bot/chatbot.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 200,
              // width: 200,
              child: Image.asset("assets/images/music.png"),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        height: 60,
        decoration: BoxDecoration(
          //  color: Color(0xff4169E1).withOpacity(0.8),
          color: Color(0xffF778A1),
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [
              // Color(0xffF778A1),
              Color(0xff4169E1),
              Color(0xffF778A1),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: [0.4, 0.7],
            tileMode: TileMode.repeated,
          ),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyHomePage()));
          },
          child: const Center(
              child: Text(
            "Let's Started ",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          )),
        ),
      ),
    );
  }
}
