import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget{
  final String image;
  final String categoryName;
  final int numberOfProducts;
  const CategoryCard({super.key , required this.image,
  required this.categoryName ,
  required this.numberOfProducts});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
      return Card(
        child: Column(
        children: [
          SizedBox(
          height: constraints.maxHeight*0.7,
          child: Image.network(image, fit: BoxFit.contain),
          ),
          Text(
          categoryName,
          style: TextStyle(
            fontSize: constraints.maxWidth * 0.08,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          ),
          Text(
          "$numberOfProducts Products",
          style: TextStyle(
            fontSize: constraints.maxWidth * 0.07,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          ),
        ],
        ),
      );
      },
    );
  }

}