import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CharactersProvider extends ChangeNotifier {
  String gender = "male";
  String? imagePath;
  String promptText = "";
  String accessToken = "";
  List generatedImages = [];
  String? selectedImageUrl;

  selectImage(String imageUrl) {
    this.selectedImageUrl = imageUrl;
  }

  loginUsingDeviceId() async {
    final response = await http.post(
      Uri.parse('https://dev.newtype-backend.zazz.buzz/api/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          {"deviceId": "238434834782348923", "devicePlatform": "Android"}),
    );
    if (response.statusCode == 200) {
      accessToken = jsonDecode(response.body)["accessToken"];
    }
  }

  generateCharacterImage() async {
    generatedImages = [];
    final response = await http.post(
      Uri.parse(
          'https://dev.newtype-backend.zazz.buzz/api/characters/profile-images'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode({
        "prompt": promptText,
        "imageUrl": null,
        "numOutputs": 6,
        "style": "anime",
        "gender": gender
      }),
    );
    if (response.statusCode == 201) {
      generatedImages = jsonDecode(response.body)["result"];
    }
    notifyListeners();
  }
}
