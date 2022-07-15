import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
import './item.dart';

class Items with ChangeNotifier {
  List<ProductItem> _userItems = [];
  List<ProductItem> _items = [
    // ProductItem(
    //     id: "p1",
    //     title: "Camera",
    //     description: "Beautiful Product",
    //     phoneNumber: '03074635923',
    //     imageUrl:
    //         "https://image.shutterstock.com/image-photo/camera-260nw-610909205.jpg",
    //     price: '15.0',
    //     address: "District Nowshera Teshil Pabbi",
    //     categoryId: "E",
    //     categoyTitle: "Appliances"),
    // ProductItem(
    //     id: "p2",
    //     title: "Car",
    //     description: "2020 Model",
    //     phoneNumber: '03074635923',
    //     imageUrl:
    //         "https://images.hgmsites.net/lrg/2020-honda-civic-sport-manual-angular-front-exterior-view_100751892_l.jpg",
    //     price: '3000.0',
    //     address: "Hayatabad Phase 7 E5 Sector",
    //     categoryId: "V",
    //     categoyTitle: "Vechiles"),
    // ProductItem(
    //     id: "p3",
    //     title: "clothes",
    //     description: "Beaufitul Clothes",
    //     phoneNumber: '03074635923',
    //     imageUrl:
    //         "https://images.unsplash.com/photo-1598033129183-c4f50c736f10?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHNoaXJ0fGVufDB8fDB8fA%3D%3D&w=1000&q=80",
    //     price: '22.2',
    //     address: "Dalazak Road Pakha Ghulam",
    //     categoryId: "C",
    //     categoyTitle: "Clothes"),
    // ProductItem(
    //     id: "p4",
    //     title: "Honda Civic Car",
    //     description: "Beaufitul Clothes",
    //     phoneNumber: '03074635923',
    //     imageUrl:
    //         "https://www.rentcars247.com/btPublic/bt-uploads/large/civic31.jpg",
    //     price: '2400',
    //     address: "Dalazak Road Pakha Ghulam",
    //     categoryId: "V",
    //     categoyTitle: "Vechiles"),
    // ProductItem(
    //     id: "p5",
    //     title: "Coat",
    //     description: "Beaufitul Clothes",
    //     phoneNumber: '03074635923',
    //     imageUrl:
    //         "https://kapok.pk/wp-content/uploads/2021/08/Skin-and-Off-White-Masoori-Prince-Coat-1.jpg",
    //     price: '2400',
    //     address: "Dalazak Road Pakha Ghulam",
    //     categoryId: "C",
    //     categoyTitle: "Clothes"),
    // ProductItem(
    //     id: "p6",
    //     title: "Toyota",
    //     description: "Beaufitul Car",
    //     phoneNumber: '03074635923',
    //     imageUrl:
    //         "https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    //     price: '2400',
    //     address: "Dalazak Road Pakha Ghulam",
    //     categoryId: "V",
    //     categoyTitle: "Vechiles"),
    // ProductItem(
    //     id: "p7",
    //     title: "Toyota",
    //     description: "Beaufitul Car",
    //     phoneNumber: '03074635923',
    //     imageUrl:
    //         "https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    //     price: '2400',
    //     address: "Dalazak Road Pakha Ghulam",
    //     categoryId: "V",
    //     categoyTitle: "Vechiles"),
    // ProductItem(
    //     id: "p8",
    //     title: "Suzuki",
    //     description: "Beaufitul Car",
    //     phoneNumber: '03074635923',
    //     imageUrl:
    //         "https://1auto.co/storage/ready_for_sales/20210709155718_2022-chevrolet-corvette-z06-1607016574.jpg",
    //     price: '2400',
    //     address: "Dalazak Road Pakha Ghulam",
    //     categoryId: "V",
    //     categoyTitle: "Vechiles"),
    // ProductItem(
    //     id: "p9",
    //     title: "Suzuki",
    //     description: "Beaufitul Car",
    //     phoneNumber: '03074635923',
    //     imageUrl:
    //         "https://i.pinimg.com/originals/f0/6b/3a/f06b3ad09ef4cc68eb6e1fb3a0962385.jpg",
    //     price: '2400',
    //     address: "Dalazak Road Pakha Ghulam",
    //     categoryId: "V",
    //     categoyTitle: "Vechiles"),
  ];

  final String authToken;
  final String userId;
  final String userEmail;
  Items(
    this.authToken,
    this.userId,
    this.userEmail,
    this._items,
  );

  List<ProductItem> get items {
    return [..._items];
  }

  List<ProductItem> get userItems {
    return [..._userItems];
  }

  ProductItem findById(String id) {
    return _items.firstWhere((prodItem) => prodItem.id == id);
  }

  List<ProductItem> findCategoryItem(String category) {
    return _items
        .where((prodItem) => prodItem.categoryTitle == category)
        .toList();
  }

  Future<void> fetchAndSetItems([bool filterByUser = false]) async {
    final filterString = filterByUser
        ? '?auth=$authToken&orderBy="creatorId"&equalTo="$userId"'
        : '';
    final url = Uri.parse(
        "https://rentnow-f12ca-default-rtdb.firebaseio.com/items.json$filterString");
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      List<ProductItem> loadedItem = [];

      extractedData.forEach((itemId, itemData) {
        if (itemData['validItem']) {
          loadedItem.insert(
              0,
              ProductItem(
                  id: itemId,
                  title: itemData['title'],
                  description: itemData['description'],
                  phoneNumber: itemData['phoneNumber'],
                  imageUrl: itemData['imageUrl'],
                  price: itemData['price'],
                  address: itemData['address'],
                  categoryTitle: itemData['categoryTitle'],
                  categoryId: itemData['categoryId'],
                  available: itemData['available'],
                  validItem: itemData!['validItem'],
                  userEmail: itemData['userEmail']));
        }
      });
      if (filterByUser) {
        _userItems = loadedItem;
      } else {
        _items = loadedItem;
      }

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addItem(ProductItem product) async {
    final url = Uri.parse(
        "https://rentnow-f12ca-default-rtdb.firebaseio.com/items.json?auth=$authToken");
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'phoneNumber': product.phoneNumber,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'address': product.address,
          'categoryId': product.categoryId,
          'categoryTitle': product.categoryTitle,
          'creatorId': userId,
          'available': product.available,
          'validItem': product.validItem,
          'userEmail': userEmail,
        }),
      );
      // final newProduct = ProductItem(
      //     id: json.decode(response.body)['name'],
      //     title: product.title,
      //     description: product.description,
      //     phoneNumber: product.phoneNumber,
      //     imageUrl: product.imageUrl,
      //     price: product.price,
      //     address: product.address,
      //     categoryId: product.categoryId,
      //     categoryTitle: product.categoryTitle,
      //     available: product.available,
      //     validItem: false);
      // _items.add(newProduct);
      // _items.insert(0, newProduct);

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateItem(String id, ProductItem newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.parse(
          "https://rentnow-f12ca-default-rtdb.firebaseio.com/items/$id.json?auth=$authToken");
      http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'phoneNumber': newProduct.phoneNumber,
            'imageUrl': newProduct.imageUrl,
            'categoryTitle': newProduct.categoryTitle,
            'categoryId': newProduct.categoryId,
            'address': newProduct.address,
            'available': newProduct.available,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print("product with that id not exsit");
    }
  }

  Future<void> reportPorduct(String report, String itemImage, String itemId,
      String itemOwnerEmail) async {
    final url = Uri.parse(
        "https://rentnow-f12ca-default-rtdb.firebaseio.com/ReportItems.json?auth=$authToken");

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'itemReport': report,
          'itemOwnerEmail': itemOwnerEmail,
          'itemImage': itemImage,
          'itemId': itemId
        }),
      );
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteItem(String id) async {
    final url = Uri.parse(
        "https://rentnow-f12ca-default-rtdb.firebaseio.com/items/$id.json?auth=$authToken");

    final existingItemIndex = _items.indexWhere((item) => item.id == id);
    ProductItem? existingItem = _items[existingItemIndex];
    _items.removeAt(existingItemIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingItemIndex, existingItem);
      notifyListeners();
      throw HttpException("Could not delete Item.");
    }
    existingItem = null;

    // _items.removeWhere((item) => item.id == id);
  }

  // void
}
