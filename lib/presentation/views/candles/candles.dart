import 'package:flutter/material.dart';
import 'package:lightforisrael/data/services/data_service.dart';
import 'package:lightforisrael/presentation/views/candles/details_candle.dart';
import 'package:lightforisrael/presentation/widgets/image_carousel.dart';

class CandlesView extends StatefulWidget {
  @override
  State<CandlesView> createState() => _CandlesViewState();
}

class _CandlesViewState extends State<CandlesView> {
  Future<List<dynamic>> fetchData() async {
    return await loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<List<dynamic>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Data Found'));
          } else {
            return Column(
              children: [
                SizedBox(height: 16.0),
                Container(
                  height: 230.0,
                  child: ImageCarousel(),
                ),
                SizedBox(height: 16.0),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(8.0),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final item = snapshot.data![index];
                      return CandleItemCard(item: item);
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class CandleItemCard extends StatefulWidget {
  final dynamic item;

  CandleItemCard({required this.item});

  @override
  State<CandleItemCard> createState() => _CandleItemCardState();
}

class _CandleItemCardState extends State<CandleItemCard> {
  bool _isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailCandlesView(item: widget.item),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 53, 80, 103),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 56, 94, 165).withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(height: 25),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/candle.gif',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item['personName'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Row(
                          children: [
                            Icon(Icons.cake, color: Colors.white),
                            SizedBox(width: 4.0),
                            Text(
                              'Born: ${widget.item['birthdate']}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.event),
                            SizedBox(width: 4.0),
                            Text(
                              'Died: ${widget.item['deathday']}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      widget.item['imgUrl'],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Text(
                widget.item['description'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height:1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: _isFavorite ? Colors.red : Colors.white,
                    ),
                    onPressed: _toggleFavorite,
                  ),
                  SizedBox(width: 20),
                  IconButton(
                      icon: Icon(
                        Icons.share,
                        color: Colors.blue,
                      ),
                      onPressed: () {}),
                  SizedBox(width: 20),
                ],
              ),
              SizedBox(
                height: 4.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
