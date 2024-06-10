import 'package:customer_application/common/constants/app_text_styles.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselPage extends StatelessWidget {
  const CarouselPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 79, 27, 124), Color.fromARGB(255, 88, 21, 88)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 50), // Add spacing from top
            Column(
              children: [
                Text(
                  'ALFA Aluminium Works',
                  style: AppTextStyles.whitetext),
                  SizedBox(height: 10,),
                  Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/387-3872576_purple-home-5-icon-free-icons-house-with.png'),
                        fit: BoxFit.fill)),
              ),
              SizedBox(height: 50), 
                  Text('Highlites of the day..',style: AppTextStyles.subheading,)
              ],
            ),
            SizedBox(height: 20), // Add spacing between heading and carousel
            Container(
              height: 400, // Specific size for the carousel
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 400,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
                items: [
                  // Add your carousel items here
                  _buildCarouselItem(context, 'assets/images/R.png', 'Welcome to our app!'),
                  _buildCarouselItem(context, 'assets/images/interior-design-violet-22273327.webp', 'Discover new features!'),
                  _buildCarouselItem(context, 'assets/images/R.png', 'Get started now!'),
                ],
              ),
            ),
            SizedBox(height: 20), // Add spacing between carousel and button
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
              },
              child: Text(
                'Next',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 50), // Add spacing from bottom
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselItem(BuildContext context, String imagePath, String text) {
    return Container(
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
