import 'package:flutter/material.dart';
import 'package:lightforisrael/data/models/memorial.dart';
import 'package:lightforisrael/data/services/data_service.dart';
import 'package:lightforisrael/presentation/views/candles/candles.dart'; // Ensure this import points to the correct path

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _allMemorials = [];
  List<dynamic> _filteredMemorials = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final List<dynamic> memorials = await loadJsonData(); // Ensure this function is correct
    setState(() {
      _allMemorials = memorials;
      _filteredMemorials = [];
    });
  }

  void _updateSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredMemorials = [];
      } else {
        _filteredMemorials = _allMemorials
            .where((memorial) => memorial['personName']
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey[700]!),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _updateSearchResults,
                style: TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search for memorials',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: _filteredMemorials.isEmpty
                ? Center(child: Text('Search by name', style: TextStyle(color: Colors.grey)))
                : ListView.builder(
                    padding: EdgeInsets.all(8.0),
                    itemCount: _filteredMemorials.length,
                    itemBuilder: (context, index) {
                      final memorial = _filteredMemorials[index];
                      return CandleItemCard(
                        memorial: Memorial.fromJson(memorial), // Ensure you have a method to create a Memorial object from JSON
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
