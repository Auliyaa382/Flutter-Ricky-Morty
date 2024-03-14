import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; // Import Dio for making API requests
import 'package:rick_morty/character_details_screen.dart';
import 'package:rick_morty/response_api.dart';

class ListScreen extends StatelessWidget {
  final List<Result> results;

  const ListScreen({Key? key, required this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Container(
        width: double.infinity,
        height: 1,
        color: Colors.blue,
        margin: EdgeInsets.symmetric(vertical: 12),
      ),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];

        return InkWell(
          onTap: () {
            _navigateToCharacterDetails(context, result.id);
          },
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  result.image ?? '',
                  height: 150,
                  width: 150,
                ),
              ),
              const SizedBox(width: 10),
              Text(result.name ?? ''),
            ],
          ),
        );
      },
    );
  }

  void _navigateToCharacterDetails(BuildContext context, int? characterId) async {
    try {
      // Make API call to fetch character details
      final response = await Dio().get('https://rickandmortyapi.com/api/character/$characterId');
      final characterData = response.data;
      
      // Navigate to character details screen with fetched data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CharacterDetailsScreen(characterData: characterData),
        ),
      );
    } catch (e) {
      // Handle error if API call fails
      print('Error fetching character details: $e');
      // Optionally, you can show a snackbar or alert dialog to notify the user
    }
  }
}
