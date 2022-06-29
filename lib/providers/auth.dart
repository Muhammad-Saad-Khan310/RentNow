import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  bool isAllowed = false;
  Timer? _authTimer;
  bool _showForm = false;

  bool get isAuth {
    return token != null;
  }

  bool get showForm {
    return _showForm;
  }

  String? get userId {
    return _userId;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      isAllowed = true;
      return _token;
    }
    return null;
  }

  Future<void> authenticate(
      String email, String password, String urlSegment) async {
    try {
      final url = Uri.parse(
          "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAqyk7TDClx0TBfEDpaQu0VVW-IPtSOIM4");
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData["error"]["message"]);
      }
      _token = responseData["idToken"];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData["expiresIn"]),
        ),
      );
      isAllowed = true;
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate!.toIso8601String()
      });
      prefs.setString('userData', userData);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> authenticate1(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAqyk7TDClx0TBfEDpaQu0VVW-IPtSOIM4");
    try {
      final response = await http.post(
        url,
        body: json.encode(
            {"email": email, "password": password, "returnSecureToken": true}),
      );
      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData["error"]["message"]);
      }
      _token = responseData["idToken"];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData["expiresIn"]),
        ),
      );
      _autoLogout();
      notifyListeners();

      // This await key word is used b/c sharedPreferences works with future
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate!.toIso8601String()
      });
      prefs.setString('userData', userData);
      if (urlSegment == "signUp") {
        addRenter(
            "Your Name",
            "https://www.usbji.org/sites/default/files/person.jpg",
            DateTime.now().toString(),
            'Phone Number',
            'Address');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signup(String email, String password) async {
    return authenticate1(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    return authenticate1(email, password, "signInWithPassword");
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("userData")) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    final expiryDate =
        DateTime.parse(extractedUserData['expiryDate'] as String);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'] as String;
    _userId = extractedUserData['userId'] as String;
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    isAllowed = false;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove("userData");
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  Future<void> showAddItemForm() async {
    if (_token != null) {
      final url = Uri.parse(
          "https://rentnow-f12ca-default-rtdb.firebaseio.com/renters/$_userId.json?auth=$_token");

      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (extractedData != null) {
        _showForm = false;
      } else {
        _showForm = true;
      }
    } else {
      _showForm = false;
    }
  }

  Future<void> addRenter(String userName, String imageUrl, String dateOfBirth,
      String phoneNumber, String address) async {
    final url = Uri.parse(
        "https://rentnow-f12ca-default-rtdb.firebaseio.com/renters/$_userId.json?auth=$_token");

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
}
