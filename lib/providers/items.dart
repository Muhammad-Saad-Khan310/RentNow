import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import './item.dart';

class Items with ChangeNotifier {
  final List<ProductItem> _items = [
    ProductItem(
        id: "p1",
        title: "Camera",
        description: "Beautiful Product",
        phoneNumber: 03074635923,
        imageUrl:
            "https://image.shutterstock.com/image-photo/camera-260nw-610909205.jpg",
        price: 15.0,
        address: "District Nowshera Teshil Pabbi",
        categoryId: "E",
        categoyTitle: "Electric Equipments"),
    ProductItem(
        id: "p2",
        title: "Car",
        description: "2020 Model",
        phoneNumber: 03074635923,
        imageUrl:
            "https://images.hgmsites.net/lrg/2020-honda-civic-sport-manual-angular-front-exterior-view_100751892_l.jpg",
        price: 3000.0,
        address: "Hayatabad Phase 7 E5 Sector",
        categoryId: "V",
        categoyTitle: "Vechiles"),
    ProductItem(
        id: "p3",
        title: "clothes",
        description: "Beaufitul Clothes",
        phoneNumber: 03074635923,
        imageUrl:
            "https://images.unsplash.com/photo-1598033129183-c4f50c736f10?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHNoaXJ0fGVufDB8fDB8fA%3D%3D&w=1000&q=80",
        price: 22.2,
        address: "Dalazak Road Pakha Ghulam",
        categoryId: "C",
        categoyTitle: "Clothes"),
    ProductItem(
        id: "p4",
        title: "Honda Civic Car",
        description: "Beaufitul Clothes",
        phoneNumber: 03074635923,
        imageUrl:
            "https://www.rentcars247.com/btPublic/bt-uploads/large/civic31.jpg",
        price: 2400,
        address: "Dalazak Road Pakha Ghulam",
        categoryId: "V",
        categoyTitle: "Vechiles"),
    ProductItem(
        id: "p5",
        title: "Coat",
        description: "Beaufitul Clothes",
        phoneNumber: 03074635923,
        imageUrl:
            "https://kapok.pk/wp-content/uploads/2021/08/Skin-and-Off-White-Masoori-Prince-Coat-1.jpg",
        price: 2400,
        address: "Dalazak Road Pakha Ghulam",
        categoryId: "C",
        categoyTitle: "Clothes"),
    ProductItem(
        id: "p6",
        title: "Toyota",
        description: "Beaufitul Car",
        phoneNumber: 03074635923,
        imageUrl:
            "https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
        price: 2400,
        address: "Dalazak Road Pakha Ghulam",
        categoryId: "V",
        categoyTitle: "Vechiles"),
    ProductItem(
        id: "p7",
        title: "Toyota",
        description: "Beaufitul Car",
        phoneNumber: 03074635923,
        imageUrl:
            "https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
        price: 2400,
        address: "Dalazak Road Pakha Ghulam",
        categoryId: "V",
        categoyTitle: "Vechiles"),
    ProductItem(
        id: "p8",
        title: "Suzuki",
        description: "Beaufitul Car",
        phoneNumber: 03074635923,
        imageUrl:
            "https://1auto.co/storage/ready_for_sales/20210709155718_2022-chevrolet-corvette-z06-1607016574.jpg",
        price: 2400,
        address: "Dalazak Road Pakha Ghulam",
        categoryId: "V",
        categoyTitle: "Vechiles"),
    ProductItem(
        id: "p9",
        title: "Suzuki",
        description: "Beaufitul Car",
        phoneNumber: 03074635923,
        imageUrl:
            "https://i.pinimg.com/originals/f0/6b/3a/f06b3ad09ef4cc68eb6e1fb3a0962385.jpg",
        price: 2400,
        address: "Dalazak Road Pakha Ghulam",
        categoryId: "V",
        categoyTitle: "Vechiles"),
  ];

  List<ProductItem> get items {
    return [..._items];
  }

  ProductItem findById(String id) {
    return _items.firstWhere((prodItem) => prodItem.id == id);
  }

  List<ProductItem> findCategoryItem(String categoryId) {
    return _items
        .where((prodItem) => prodItem.categoryId == categoryId)
        .toList();
  }

  void addItem(ProductItem product) {
    final newProduct = ProductItem(
        id: DateTime.now().toString(),
        title: product.title,
        description: product.description,
        phoneNumber: product.phoneNumber,
        imageUrl: product.imageUrl,
        price: product.price,
        address: product.address,
        categoryId: product.categoryId,
        categoyTitle: product.categoyTitle);
    _items.add(newProduct);
    notifyListeners();
  }
}

// final List<ProductItem> loadeditems = [
//   ProductItem(
//       id: "p1",
//       title: "Camera",
//       description: "Beautiful Product",
//       imageUrl:
//           "https://image.shutterstock.com/image-photo/camera-260nw-610909205.jpg",
//       price: 15.0),
//   ProductItem(
//       id: "p2",
//       title: "Car",
//       description: "2020 Model",
//       imageUrl:
//           "https://images.hgmsites.net/lrg/2020-honda-civic-sport-manual-angular-front-exterior-view_100751892_l.jpg",
//       price: 3000.0),
//   ProductItem(
//       id: "p3",
//       title: "clothes",
//       description: "Beaufitul Clothes",
//       imageUrl:
//           "https://images.unsplash.com/photo-1598033129183-c4f50c736f10?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHNoaXJ0fGVufDB8fDB8fA%3D%3D&w=1000&q=80",
//       price: 22.2)
// ];
