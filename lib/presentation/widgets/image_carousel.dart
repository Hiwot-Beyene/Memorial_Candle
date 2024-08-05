import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          color: Colors.transparent, 
          child: CarouselSlider(
            options: CarouselOptions(
              height: 400.0,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
            ),
            items: [
              _buildCarouselItem(
                imagePath: 'assets/1.jpg',
                text: 'Honoring the Brave: Stories of Heroism and Sacrifice',
              ),
              _buildCarouselItem(
                imagePath: 'assets/2.avif',
                text:
                    "In Memory of Heroes: Israel's Tribute to Victims of Hamas Attacks",
              ),
              _buildCarouselItem(
                imagePath: 'assets/3.jpg',
                text:
                    'Never Forgotten: A Tribute to Those Lost on Israel Memorial Day',
              ),
            ],
          ),
        ),
      )
    ;
  }

  Widget _buildCarouselItem({required String imagePath, required String text}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
