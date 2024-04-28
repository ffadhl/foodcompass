import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodcompass_application/constants/color_constant.dart';
import 'package:foodcompass_application/constants/image_constant.dart';
import 'package:foodcompass_application/models/welcome_screen_model_widget.dart';
import 'package:foodcompass_application/screens/welcome_screen/widget/welcome_screen_dot_widget.dart';
import 'package:foodcompass_application/screens/welcome_screen/widget/welcome_screen_widget.dart';

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
          'Dengan ribuan resep lezat dari seluruh dunia, kami siap membawa Anda merasakan kenikmatan kuliner tanpa batas. Ayo, mari kita mulai!',
      imagePath: ImageConstant.orangeLogo,
    ),
    WelcomeOnBoard(
      title: 'Temukan Resep\nyang Anda Cari!',
      description:
          'Dengan fitur pencarian yang canggih, Anda dapat menemukan resep yang Anda inginkan dengan mudah. Cukup ketik kata kunci, dan kami akan menampilkannya untuk Anda.',
      imagePath: ImageConstant.orangeLogo,
    ),
    WelcomeOnBoard(
      title: 'Simpan Resep\nFavorit Anda!',
      description:
          'Dengan fitur favorite, Anda dapat menyimpan resep favorit Anda dan mengaksesnya kapan saja. Cukup tekan tombol bookmark, dan resep akan tersimpan di dalam daftar favorit Anda.',
      imagePath: ImageConstant.orangeLogo,
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
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: WelcomeScreenDot(
                        isActive: index == _currentPage,
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 60.0,
                    width: 60,
                    child: FloatingActionButton(
                      onPressed: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
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
