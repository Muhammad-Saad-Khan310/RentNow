// import 'package:flutter/cupertino.dart';

class ProductItem {
  final String id;
  final String title;
  final String description;
  final String phoneNumber;
  final String imageUrl;
  final String price;
  final String address;
  final String categoryId;
  final String categoryTitle;

  ProductItem(
      {required this.id,
      required this.title,
      required this.description,
      required this.phoneNumber,
      required this.imageUrl,
      required this.price,
      required this.address,
      required this.categoryId,
      required this.categoryTitle});
}
