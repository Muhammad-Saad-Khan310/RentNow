import 'package:flutter/material.dart';

import '../screens/selected_category_screen.dart';

class CategoriesWidget extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final String categoryId;
  final String categoryTitle;
  CategoriesWidget(
      this.id, this.title, this.imageUrl, this.categoryId, this.categoryTitle);
  // const CategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(SelectedCategoryScreen.routeName,
                arguments: {
                  "categoryId": categoryId,
                  "categoryTitle": categoryTitle
                });
          },
          child: Column(
            children: [
              Card(
                color: Colors.amber,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 4,
                margin: const EdgeInsets.only(
                  // left: 20,
                  right: 10,
                  top: 10,
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          child: Image.network(
                            imageUrl,
                            height: 80,
                            width: 140,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
