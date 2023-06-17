import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:okstitch/home/home.dart';
import 'package:okstitch/login/login.dart';
import 'package:okstitch/onboarding/onboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
            (_) => Future.delayed(const Duration(seconds: 1), () async {
              if (_controller.isCompleted) {
                try {
                  if (FirebaseAuth.instance.currentUser != null) {
                    if (Platform.isAndroid) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Home(),
                          ),
                              (route) => false);
                    }
                    if (Platform.isIOS) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const Home(),
                          ),
                              (route) => false);
                    }
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                      const SnackBar(content: Text("Network error")));
                }
              }
        }));

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0XFFee9ca7),
            Color(0XFFffdde1),
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DelayedDisplay(
                  child: Column(
                    children: [
                      Text(
                        "Ok Stitch",
                        style: TextStyle(
                            fontFamily: "Mukta",
                            fontSize: MediaQuery.of(context).size.width / 12,
                            fontWeight: FontWeight.bold),
                      ),
                      AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText(
                            "Get it Stitched on Time🪡",
                            textStyle: TextStyle(
                              fontFamily: "Mukta",
                              fontSize: MediaQuery.of(context).size.width / 25,
                            ),
                          ),
                        ],
                        totalRepeatCount: 1,
                        pause: const Duration(milliseconds: 300),
                        displayFullTextOnTap: true,
                        stopPauseOnTap: true,
                      ),
                    ],
                  ),
                ),
                Lottie.asset(
                  'assets/sewing.json',
                  controller: _controller,
                  onLoaded: (composition) {
                    // Configure the AnimationController with the duration of the
                    // Lottie file and start the animation.
                    _controller
                      ..duration = composition.duration
                      ..repeat();
                  },
                ),
                AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    ScaleAnimatedText(
                      'Live Tracking',
                      textStyle: TextStyle(
                        fontFamily: "Mukta",
                        fontSize: MediaQuery.of(context).size.width / 20,
                      ),
                    ),
                    ScaleAnimatedText(
                      'Delivery on Time',
                      textStyle: TextStyle(
                        fontFamily: "Mukta",
                        fontSize: MediaQuery.of(context).size.width / 20,
                      ),
                    ),
                    ScaleAnimatedText(
                      'Professional Hands',
                      textStyle: TextStyle(
                        fontFamily: "Mukta",
                        fontSize: MediaQuery.of(context).size.width / 20,
                      ),
                    ),
                    ScaleAnimatedText(
                      'Customizations',
                      textStyle: TextStyle(
                        fontFamily: "Mukta",
                        fontSize: MediaQuery.of(context).size.width / 20,
                      ),
                    ),
                  ],
                  totalRepeatCount: 1,
                  pause: const Duration(milliseconds: 500),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
                Platform.isIOS
                    ? const CupertinoActivityIndicator()
                    : const CircularProgressIndicator()
              ],
            ),
          ),
        ),
      ),
    );
  }

  moveToDecision() async {
    if (mounted) {
      if (Platform.isAndroid) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const Login(),
            ),
            (route) => false);
      }
      if (Platform.isIOS) {
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(
              builder: (context) => const Login(),
            ),
            (route) => false);
      }
    }
  }

  moveToGettingStart() {
    if (Platform.isAndroid) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const OnBoard(),
          ),
          (route) => false);
    }
    if (Platform.isIOS) {
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(
            builder: (context) => const OnBoard(),
          ),
          (route) => false);
    }
  }

  Future<void> userStateSave() async {
    final value = await SharedPreferences.getInstance();
    if (value.getInt("userState") != 1) {
      moveToGettingStart();
    } else {
      moveToDecision();
    }
  }

}
