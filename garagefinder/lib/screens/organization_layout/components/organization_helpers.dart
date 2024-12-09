import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> fetchOrganizations() async {
  try {
    const url = 'http://10.0.2.2:3000/schools';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((data) {
        return {
          'name': data['name'] ?? '',
          'type': data['type'] ?? '',
          'location': data['location'] ?? '',
          'image': data['image'] ?? '',
        };
      }).toList();
    } else {
      throw Exception('Failed to load organizations');
    }
  } catch (e) {
    throw Exception('Error fetching organizations: $e');
  }
}

Map<String, List<Map<String, dynamic>>> groupOrganizations(
    List<Map<String, dynamic>> organizations) {
  final Map<String, List<Map<String, dynamic>>> groupedOrganizations = {};

  for (var org in organizations) {
    String letter = org['name'][0].toUpperCase();
    if (!groupedOrganizations.containsKey(letter)) {
      groupedOrganizations[letter] = [];
    }
    groupedOrganizations[letter]!.add(org);
  }

  return groupedOrganizations;
}
