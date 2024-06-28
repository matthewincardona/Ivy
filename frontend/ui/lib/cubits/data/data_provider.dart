part of 'cubit.dart';

class DataDataProvider {
  static Future<Data> fetch() async {
    try {
      print('Initiating request to http://localhost:8080');
      final request = await http.get(Uri.parse('http://localhost:8080'));

      print('Request completed with status code: ${request.statusCode}');
      print('Response body: ${request.body}');

      final Map<String, dynamic> jsonResponse = json.decode(request.body);
      final List<String> words = List<String>.from(jsonResponse['data'] ?? []);

      return Data(words: words);
    } catch (e) {
      print('Exception caught: $e');
      throw Exception("Internal Server Error");
    }
  }
}
