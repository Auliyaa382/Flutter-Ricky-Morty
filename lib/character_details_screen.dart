import 'package:flutter/material.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> characterData;

  const CharacterDetailsScreen({Key? key, required this.characterData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Character Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  characterData['image'],
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Name: ${characterData['name']}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Status: ${characterData['status']}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Species: ${characterData['species']}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Type: ${characterData['type'] ?? 'Unknown'}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Gender: ${characterData['gender']}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
