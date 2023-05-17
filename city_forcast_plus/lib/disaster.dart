import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'hostAddress.dart';

class Disaster {
  final String title;
  final String description;
  final String country;

  Disaster({
    required this.title,
    required this.description,
    required this.country,
  });

  factory Disaster.fromJson(Map<String, dynamic> json) {
    return Disaster(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      country: json['country'] ?? '',
    );
  }
}

class DisasterCard extends StatelessWidget {
  final Disaster disaster;

  const DisasterCard({Key? key, required this.disaster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            disaster.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            disaster.description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            disaster.country,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class NaturalDisastersPage extends StatefulWidget {
  const NaturalDisastersPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NaturalDisastersPageState createState() => _NaturalDisastersPageState();
}

class _NaturalDisastersPageState extends State<NaturalDisastersPage> {
  List<Disaster> items = [];
  String removeComments(String input) {
    final pattern = RegExp(r'/\*[^*]*\*+(?:[^/*][^*]*\*+)*/');
    return input.replaceAll(pattern, '');
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('${await getIpAddress(1)}/api/naturaldisasters'));
    if (response.statusCode != 200) {
    }
    final json =
        jsonDecode(removeComments(response.body)); // Decode JSON response
    final rss = json['rss'];
    final channel = rss['channel'];
    final itemJsonList = channel['item'] as List;
    setState(() {
      items = itemJsonList.map((json) => Disaster.fromJson(json)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Natural Disasters'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                items = [];
                fetchData();
              });
            },
          ),
        ],
      ),
      body: items.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                final item = items[index];
                return DisasterCard(
                  disaster: Disaster(
                      title: item.title,
                      description: item.description,
                      country: item.country),
                );
              },
            ),
    );
  }
}
