// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/http_exception.dart';

class RenterClass {
  final String id;
  final String userName;
  final String dateOfBirth;
  final String phoneNumber;
  final String address;
  final String imageUrl;

  RenterClass(
      {required this.id,
      required this.userName,
      required this.dateOfBirth,
      required this.phoneNumber,
      required this.address,
      required this.imageUrl});
}

class Renter with ChangeNotifier {
  List<RenterClass> _renter = [
    RenterClass(
        id: "u1",
        userName: "User Name",
        dateOfBirth: "10/12/2000",
        phoneNumber: "your number",
        address: "Your address",
        imageUrl: "https://www.usbji.org/sites/default/files/person.jpg")
  ];
  // Map<String, dynamic> rent = {};
  final String userId;
  final String authToken;
  bool showform = false;

  Renter(this.userId, this.authToken);

  List<RenterClass> get rentItems {
    return [..._renter];
  }

  Future<void> fetchRenter() async {
    final url = Uri.parse("your api");
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      List<RenterClass> loadedItem = [];

      extractedData.forEach((renterId, renterData) {
        loadedItem.insert(
          0,
          RenterClass(
              id: renterId,
              userName: renterData.userName,
              dateOfBirth: renterData.dateOfBirth,
              phoneNumber: renterData.phoneNumber,
              address: renterData.address,
              imageUrl: renterData.imageUrl),
        );
      });
      _renter = loadedItem;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addRenter(String userName, String imageUrl, String dateOfBirth,
      String phoneNumber, String address) async {
    final url = Uri.parse("your api");

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

  RenterClass findById(String id) {
    return _renter.firstWhere((prodItem) => prodItem.id == id);
  }

  Future<void> updateRenter(String id, RenterClass newProduct) async {
    final prodIndex = _renter.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.parse("your api");
      http.patch(url,
          body: json.encode({
            'userName': newProduct.userName,
            'imageUrl': newProduct.imageUrl,
            'dateOfBirth': newProduct.dateOfBirth,
            'phoneNumber': newProduct.phoneNumber,
            'address': newProduct.address,
          }));
      _renter[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print("product with that id not exsit");
    }
  }

  Future<void> getUserProfile() async {
    final url = Uri.parse("your api");
    final response = await http.get(url);
    final extractedData = json.decode(response.body);
    List<RenterClass> loadedItem = [];
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((renterId, renterData) {
      loadedItem.insert(
        0,
        RenterClass(
            id: renterId,
            userName: renterData['userName'],
            dateOfBirth: renterData['dateOfBirth'],
            phoneNumber: renterData['phoneNumber'],
            address: renterData['address'],
            imageUrl: renterData['imageUrl']),
      );
    });
    _renter = loadedItem;
    notifyListeners();
  }
}
