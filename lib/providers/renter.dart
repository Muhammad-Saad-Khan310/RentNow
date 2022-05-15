import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/http_exception.dart';

class Renter with ChangeNotifier {
  final String userId;
  final String authToken;
  bool showform = false;

  Renter(this.userId, this.authToken);

  Future<void> addRenter(String userName, String imageUrl, String dateOfBirth,
      String phoneNumber, String address) async {
    final url = Uri.parse(
        "https://rentnow-f12ca-default-rtdb.firebaseio.com/renters/$userId.json?auth=$authToken");

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'userName': userName,
            'imageUrl': imageUrl,
            'dateOfBirth': dateOfBirth,
            'phoneNumber': phoneNumber,
            'address': address,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData["error"]["message"]);
      }
    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }

  // Future<void> showRentForm() async {
  //   if (authToken != "") {
  //     final url = Uri.parse(
  //         "https://rentnow-f12ca-default-rtdb.firebaseio.com/renters/$userId.json?auth=$authToken");

  //     final response = await http.get(url);
  //     final extractedData = json.decode(response.body);
  //     print(extractedData);
  //     if (extractedData == null) {

  //       showform = true;
  //       // return true;
  //     } else {

  //       showform = false;
  //     }
  //   } else {

  //     showform = false;
  //   }
  // }

  Future<bool> userType() async {
    if (authToken != "") {
      final url = Uri.parse(
          "https://rentnow-f12ca-default-rtdb.firebaseio.com/renters/$userId.json?auth=$authToken");

      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (extractedData != null) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  Future<bool> showAddProductForm() async {
    if (authToken != "") {
      final url = Uri.parse(
          "https://rentnow-f12ca-default-rtdb.firebaseio.com/renters/$userId.json?auth=$authToken");

      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (extractedData != null) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
