import 'package:flutter/material.dart';
import 'package:lightforisrael/presentation/widgets/my_button.dart';

class DetailCandlesView extends StatelessWidget {
  final Map<String, dynamic> item;

  DetailCandlesView({required this.item});

  @override
  Widget build(BuildContext context) {
   
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          item['title'] ?? 'Details',
          style: TextStyle(color: Color.fromARGB(255, 59, 57, 57)),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back, color: Color.fromARGB(255, 128, 128, 128)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04), 
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9, 
                child: Image.asset('assets/candle.jpg', fit: BoxFit.cover),
              ),
              SizedBox(height: screenWidth * 0.04),
              Container(
                padding: EdgeInsets.all(screenWidth * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person, size: screenWidth * 0.06),
                              SizedBox(width: screenWidth * 0.02),
                              Expanded(
                                child: Text(
                                  item['personName'] ?? 'Unknown',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.06,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenWidth * 0.02),
                          Row(
                            children: [
                              Icon(Icons.cake, size: screenWidth * 0.06),
                              SizedBox(width: screenWidth * 0.02),
                              Expanded(
                                child: Text(
                                  'Birthdate: ${item['birthdate'] ?? 'Unknown'}',
                                  style:
                                      TextStyle(fontSize: screenWidth * 0.04),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenWidth * 0.02),
                          Row(
                            children: [
                              Icon(Icons.highlight_off,
                                  size: screenWidth * 0.06),
                              SizedBox(width: screenWidth * 0.02),
                              Expanded(
                                child: Text(
                                  'Deathday: ${item['deathday'] ?? 'Unknown'}',
                                  style:
                                      TextStyle(fontSize: screenWidth * 0.04),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        width: screenWidth *
                            0.02), 
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: screenWidth * 0.25, 
                        height: screenWidth * 0.25, 
                        child: Image.asset(
                          item['imgUrl'] ?? 'assets/placeholder.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenWidth * 0.04),
              Text(
                item['description'] ?? 'No description available',
                style: TextStyle(fontSize: screenWidth * 0.04),
              ),
              SizedBox(height: screenWidth * 0.04),
              MyButton(
                buttonText: 'Light Candle',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
