import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

Future<bool> checkAccess() async {
  try {
    final response = await http.get(Uri.parse('https://app-access-api.onrender.com/api/access?appName=ispacalise'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['canAccess'] == true; // Assuming the API returns { "canAccess": true/false }
    } else {
      return false;
    }
  } catch (e) {
    log('Error: $e');
    return false; // Default to no access if the request fails
  }
}
