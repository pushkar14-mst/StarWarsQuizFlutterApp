import 'dart:convert';
import 'package:http/http.dart' as http;

// typedef CarLogosCallback = void Function(Map<String, String> carLogos);

Map<String, String> starWarsImages = {};
Future<Map<String, String>> fetchStarWarsImages() async {
  final response = await http.get(Uri.parse(
      'https://raw.githubusercontent.com/akabab/starwars-api/0.2.1/api/all.json'));
  if (response.statusCode == 200) {
    final List<dynamic> characters = json.decode(response.body);

    for (var character in characters) {
      final String name = character['name'];
      final String imageUrl = character['image'];
      starWarsImages[name] = imageUrl;
    }
    print(starWarsImages);
    return starWarsImages;
  } else {
    throw Exception('Failed to fetch SW images');
  }
}

// void main() async {
//   await _fetchStarWarsImages();
// }
