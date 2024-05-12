import 'package:flutter/material.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/image_constant.dart';
import 'package:foodcompass_application/models/welcome_screen_model_widget.dart';
import 'package:foodcompass_application/screens/welcome_screen/widget/welcome_screen_widget.dart';
import 'package:foodcompass_application/screens/navigation/bottom_navigatior_widget.dart';
import 'package:foodcompass_application/widgets/global_dot_animation_widget.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  final List<WelcomeOnBoard> _onBoard = [
    WelcomeOnBoard(
      title: 'FoodCompass',
      description:
          'FoodCompass is an online platform that provides quick and easy access to delicious recipes from around the world.',
      imagePath: ImageConstant.welcomePage1,
    ),
    WelcomeOnBoard(
      title: 'Find Your Recipe!',
      description:
          'With thousands of delicious recipes from around the world, we are ready to take you on a journey of unlimited culinary delight.',
      imagePath: ImageConstant.welcomePage2,
    ),
    WelcomeOnBoard(
      title: 'Save Your Favorite Recipes!',
      description:
          'Save your favorite recipes, access them anytime and enjoy the convenience of accessing your favorite recipes.',
      imagePath: ImageConstant.welcomePage3,
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: _onBoard.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) => WelcomeScreenContent(
                    imagePath: _onBoard[index].imagePath,
                    title: _onBoard[index].title,
                    description: _onBoard[index].description,
                  ),
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                    _onBoard.length,
                    (index) => GlobalDotAnimationWidget(
                      isActive: index == _currentPage,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 60.0,
                    width: 60.0,
                    child: FloatingActionButton(
                      onPressed: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                        if (_currentPage == _onBoard.length - 1) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const BottomNavBar(),
                            ),
                          );
                        }
                      },
                      backgroundColor: ColorConstant.colorOrange,
                      shape: const CircleBorder(),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: ColorConstant.colorWhite,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
