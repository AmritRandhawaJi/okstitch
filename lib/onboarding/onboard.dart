import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okstitch/login/login.dart';
import 'package:okstitch/onboarding/slide_dots.dart';
import 'package:okstitch/onboarding/slide_items.dart';
import 'package:okstitch/onboarding/slide_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      home: Scaffold(
          body: PageView.builder(
            physics: const BouncingScrollPhysics(),
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: slideList.length,
            itemBuilder: (ctx, i) => SlideItem(i),
          ),
          bottomSheet: _currentPage != slideList.length - 1
              ? Container(
            height: MediaQuery.of(context).size.height/18,
                  margin:
                      const EdgeInsets.only(bottom: 40, left: 15, right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xff2b6747),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          for (int i = 0; i < slideList.length; i++)
                            if (i == _currentPage)
                              const SlideDots(true)
                            else
                              const SlideDots(false)
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            _pageController.animateToPage(_currentPage + 1,
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeIn);
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              )
                            ],
                          )),
                    ],
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: DelayedDisplay(
                        child: CupertinoButton(
                          borderRadius: BorderRadius.circular(30),
                          onPressed: () async {
                            userStateSave();
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const Login(),
                            ));
                          },
                          color: const Color(0xff2b6747),
                          child: Text(
                            "Let's Start",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.height / 50),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
    );
  }
}

void userStateSave() async {
  final data = await SharedPreferences.getInstance();
  data.setInt("userState", 1);
}
