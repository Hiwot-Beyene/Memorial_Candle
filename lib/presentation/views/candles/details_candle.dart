import 'package:flutter/material.dart';
import 'package:lightforisrael/presentation/widgets/message_list.dart';
import 'package:lightforisrael/presentation/widgets/my_button.dart';

class DetailCandlesView extends StatefulWidget {
  final Map<String, dynamic> item;

  DetailCandlesView({required this.item});

  @override
  State<DetailCandlesView> createState() => _DetailCandlesViewState();
}

class _DetailCandlesViewState extends State<DetailCandlesView> {
  bool _isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item['title'] ?? 'Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset('assets/candle.gif', fit: BoxFit.contain),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: _isFavorite ? Colors.red : Colors.white,
                    ),
                    onPressed: _toggleFavorite,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.share,
                      color: Colors.blue,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: screenWidth * 0.04),
              Row(
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
                            Icon(
                              Icons.person,
                              size: screenWidth * 0.06,
                              color: Colors.white,
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Expanded(
                              child: Text(
                                widget.item['personName'] ?? 'Unknown',
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
                            Icon(
                              Icons.cake,
                              size: screenWidth * 0.06,
                              color: Colors.white,
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Expanded(
                              child: Text(
                                'Birthdate: ${widget.item['birthdate'] ?? 'Unknown'}',
                                style: TextStyle(fontSize: screenWidth * 0.04),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenWidth * 0.02),
                        Row(
                          children: [
                            Icon(
                              Icons.highlight_off,
                              size: screenWidth * 0.06,
                              color: Colors.red,
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Expanded(
                              child: Text(
                                'Deathday: ${widget.item['deathday'] ?? 'Unknown'}',
                                style: TextStyle(fontSize: screenWidth * 0.04),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: screenWidth * 0.25,
                      height: screenWidth * 0.25,
                      child: Image.asset(
                        widget.item['imgUrl'] ?? 'assets/placeholder.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenWidth * 0.04),
              MyButton(
                buttonText: 'Light Candle',
                onTap: () {},
              ),
              SizedBox(height: screenWidth * 0.04),
              Text('Description',style: TextStyle(fontSize: 18)),
              Text(
                widget.item['description'] ?? 'No description available',
                style: TextStyle(fontSize: screenWidth * 0.04),
              ),
              SizedBox(height: screenWidth * 0.04),
              Text('Messages',style: TextStyle(fontSize: 18),),
              SizedBox(height: screenWidth * 0.04),
              Container(
                height: screenHeight * 0.3, 
                child: MessageList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
