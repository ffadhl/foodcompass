import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:foodcompass_application/constants/image_constant.dart';
import 'package:foodcompass_application/screens/home/widget/banner_dot_home_screen_widget.dart';
import 'package:foodcompass_application/screens/home/widget/item_banner_home_screen_widget.dart';

class HomeCarouselSlideWidget extends StatefulWidget {
  const HomeCarouselSlideWidget({super.key});

  @override
  State<HomeCarouselSlideWidget> createState() =>
      _HomeCarouselSlideWidgetState();
}

class _HomeCarouselSlideWidgetState extends State<HomeCarouselSlideWidget> {
  int _currentSlide = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentSlide = index;
                  });
                },
                viewportFraction: 1.5,
                autoPlay: true,
              ),
              items: [
                BannerHomeScreenWidget(
                  imagePath: ImageConstant.dummyBanner1,
                ),
                BannerHomeScreenWidget(
                  imagePath: ImageConstant.dummyBanner2,
                ),
                BannerHomeScreenWidget(
                  imagePath: ImageConstant.dummyBanner3,
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 3; i++)
                  BannerDotWidget(isActive: i == _currentSlide),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
