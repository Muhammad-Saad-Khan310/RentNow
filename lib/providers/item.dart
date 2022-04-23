// import 'package:flutter/cupertino.dart';

class ProductItem {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final String address;
  final String categoryId;
  final String categoyTitle;

  ProductItem(
      {required this.id,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.price,
      required this.address,
      required this.categoryId,
      required this.categoyTitle});
}
