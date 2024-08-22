import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lightforisrael/data/models/memorial.dart';
import 'package:lightforisrael/data/services/memorials_service.dart';
import 'package:lightforisrael/presentation/views/candles/details_candle.dart';
import 'package:lightforisrael/presentation/widgets/image_carousel.dart';

class CandlesView extends StatefulWidget {
  @override
  State<CandlesView> createState() => _CandlesViewState();
}

class _CandlesViewState extends State<CandlesView> {
  late ScrollController _scrollController;
  List<Memorial> _memorials = [];
  bool _isLoading = false;
  int _page = 1;
  final int _limit = 10;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    _fetchMemorials();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchMemorials() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      List<Memorial> newMemorials =
          await MemorialService().fetchMemorials(page: _page, limit: _limit);
      setState(() {
        _memorials.addAll(newMemorials);
        _page++; // Increment page for the next fetch
      });
    } catch (e) {
      print('Failed to load memorials: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading) {
      _fetchMemorials();
    }
  }

  Future<void> _refreshMemorials() async {
    setState(() {
      _memorials.clear();
      _page = 1;
    });
    await _fetchMemorials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(height: 16.0),
          Container(
            height: 230.0,
            child: ImageCarousel(),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshMemorials,
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                controller: _scrollController,
                itemCount: _memorials.length + (_isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < _memorials.length) {
                    Memorial memorial = _memorials[index];
                    return CandleItemCard(memorial: memorial);
                  } else if (_isLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return SizedBox(); // Return empty widget when not loading
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CandleItemCard extends StatefulWidget {
  final Memorial memorial;

  CandleItemCard({required this.memorial});

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
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DetailCandlesView(memorial: widget.memorial),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF295270), Color(0xFF524175)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
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
                          widget.memorial.personName,
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
                              'Born: ${dateFormat.format(widget.memorial.birthDate)}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.event, color: Colors.white),
                            SizedBox(width: 4.0),
                            Text(
                              'Died: ${dateFormat.format(widget.memorial.deceasedDate)}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.memorial.imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Text(
                widget.memorial.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 8.0),
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
            ],
          ),
        ),
      ),
    );
  }
}
