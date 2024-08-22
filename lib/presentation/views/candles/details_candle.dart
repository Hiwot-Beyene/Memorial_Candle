import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lightforisrael/data/models/memorial.dart';
import 'package:lightforisrael/data/services/stripe_service.dart';
import 'package:lightforisrael/presentation/widgets/message_list.dart';
import 'package:lightforisrael/presentation/widgets/my_button.dart';

class DetailCandlesView extends StatefulWidget {
  final Memorial memorial;

  DetailCandlesView({required this.memorial});

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
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    return Scaffold(
      appBar: AppBar(
        title: Text("Memorial Details"),
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
                        SizedBox(height: 8,),
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
                                widget.memorial.personName,
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
                                'Birthdate: ${dateFormat.format(widget.memorial.birthDate)}',
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
                                'Deathday: ${dateFormat.format(widget.memorial.deceasedDate)}',
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
                      child: Image.network(widget.memorial.imageUrl),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenWidth * 0.04),
              MyButton(
               buttonText: 'Light Candle \$2',
                onTap: () {
                StripeService.instance
                    .makePayment(context); 
              },
              ),
              SizedBox(height: screenWidth * 0.04),
              Text('Description',style: TextStyle(fontSize: 18)),
              Text(
                widget.memorial.description,
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
