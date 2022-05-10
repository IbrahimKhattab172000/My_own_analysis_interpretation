// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:abdullah_mansour/modules/shop_app/login/shop_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: "assets/images/onboarding1.PNG",
      title: "On board 1 title",
      body: "On board 1 body",
    ),
    BoardingModel(
      image: "assets/images/onboarding1.PNG",
      title: "On board 2 title",
      body: "On board 2 body",
    ),
    BoardingModel(
      image: "assets/images/onboarding1.PNG",
      title: "On board 3 title",
      body: "On board 3 body",
    ),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              navigateAndFinish(
                context: context,
                widget: ShopLoginScreen(),
              );
            },
            child: Text("SKIP"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: ((context, index) =>
                    buildBoardingItem(boarding[index])),
                itemCount: boarding.length,
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  }
                  // else {
                  //   setState(() {
                  //     isLast = false;
                  //   });
                  // }
                },
              ),
            ),
            SizedBox(height: 40),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      navigateAndFinish(
                        context: context,
                        widget: ShopLoginScreen(),
                      );
                    } else {
                      boardController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastOutSlowIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Center(
            child: Image(
              image: AssetImage(model.image),
            ),
          ),
        ),
        Text(
          model.title,
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          model.body,
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
