import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:otonomus/data/models/property_model.dart';

class PropertyRepository {
  Future<List<PropertyModel>> getAllProperties() async {
    try {
      var response = await http.get(Uri.parse(
          "http://192.168.88.10:31535/otonomus/inventory/api/v1/spaces/available_spaces"));
      var decodedResponse = jsonDecode(response.body);
      var result = decodedResponse['data'];

      if (result != null && result is List) {
        final finalResponse =
            result.map((map) => PropertyModel.fromJson(map)).toList();
        return finalResponse;
      }
      return [];
    } catch (e) {
      print("Error fetching properties: $e");
      return [];
    }
  }
}
