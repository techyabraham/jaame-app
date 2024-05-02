import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../backend/backend_utils/custom_snackbar.dart';
import '../backend/services/api_endpoint.dart';
import 'language_model.dart';

class LanguageService {
  Future<List<Language>> fetchLanguages() async {
    final response = await http.get(Uri.parse(ApiEndpoint.languageURL));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> languageDataList = data["data"]["languages"];
      final List<Language> languages =
          languageDataList.map((json) => Language.fromJson(json)).toList();
      return languages;
    } else {
      CustomSnackBar.error('Failed to load language data');
      throw Exception('Failed to load language data');
    }
  }
}
