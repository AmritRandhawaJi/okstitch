import 'package:flutter/material.dart';
import 'package:okstitch/onboarding/slide_list.dart';

class SlideItem extends StatelessWidget {
  final int index;

  const SlideItem(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
         Text(
          "Ok Stitch",
          style: TextStyle(
              fontFamily: "Mukta",
              fontSize: MediaQuery.of(context).size.width/20,
              color: Colors.black54,
              fontWeight: FontWeight.bold),
        ),
        Image.asset(slideList[index].image,
            width: MediaQuery.of(context).size.width - 50,
            height: MediaQuery.of(context).size.width),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Text(
                    slideList[index].title,
                    style:  TextStyle(
                        fontFamily: "Mukta",
                        fontSize: MediaQuery.of(context).size.height/35,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Text(
                    slideList[index].description,
                    style:  TextStyle(
                      fontFamily: "Mukta",
                      fontSize: MediaQuery.of(context).size.height/50,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

      ],
    );
  }
}
