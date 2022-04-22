import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProductCategories {
  final String CategoryId;
  final String CategoryTitle;
  final String CategoryImage;

  ProductCategories(this.CategoryId, this.CategoryTitle, this.CategoryImage);
}

final categoryData = [
  ProductCategories("V", "Vechiles",
      "https://www.sundayobserver.lk/sites/default/files/styles/large/public/news/2017/08/12/tag-Vehicle.jpg?itok=WNN4d2nD"),
  ProductCategories("E", "Electric Equipments",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRozAXQdXqKy36gZvUKEdwgnPtiwmo1tXKR7g&usqp=CAU"),
  ProductCategories("U", "Utensils",
      "https://media.istockphoto.com/vectors/kitchenware-set-kitchen-utensils-and-cutlery-vector-id1248802048"),
  ProductCategories("C", "Clothes",
      "https://www.listchallenges.com/f/lists/0db22c14-9ef5-485e-8a3a-3c95fb85a371.jpg")
];
