import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  ApiClient(this.baseUrl);

  Future<String?> get(String path) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$path'));
      return response.body.isEmpty ? 'HTTP ${response.statusCode}' : response.body;
    } catch (e) {
      return 'Connection error: $e';
    }
  }

  Future<dynamic> post(String path, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$baseUrl$path'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    if (response.body.isEmpty) return null;
    return jsonDecode(response.body);
  }
}
