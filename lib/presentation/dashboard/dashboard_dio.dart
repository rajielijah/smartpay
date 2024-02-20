import 'package:http/http.dart' as http;
import 'dart:convert';



//I tried to use the HTTP method to consume the API here but I keep getting StatusCode 500
class DashboardService {
  Future<dynamic> fetchDashboard() async {
    final url = Uri.parse('https://mobile-test-2d7e555a4f85.herokuapp.com/api/v1/dashboard');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // Assuming the response is JSON and you want to return the parsed data
        return json.decode(response.body);
      } else {
        // Handle non-200 responses
        return Future.error("Failed to load dashboard data, status code: ${response.statusCode}");
      }
    } catch (e) {
      // Handle network errors or invalid JSON format errors
      return Future.error("Error fetching dashboard data: $e");
    }
  }
}
