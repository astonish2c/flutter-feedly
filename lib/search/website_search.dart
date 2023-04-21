import 'dart:convert';
import 'package:http/http.dart' as http;

import '../classes/secure.dart';

class WebsiteSearch {
  static Future<List<String>> search(String query) async {
    var url = "https://www.googleapis.com/customsearch/v1?key=${Secure.apiKey}&cx=${Secure.searchEngineId}&q=$query&num=10&fields=items(link)";

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) throw ('Failed to search: ${response.statusCode}');

      var data = jsonDecode(response.body);

      List<String> websiteLinks = [];

      for (var item in data['items']) {
        websiteLinks.add(item['link']);
      }

      return websiteLinks;
    } catch (e) {
      rethrow;
    }
  }
}
