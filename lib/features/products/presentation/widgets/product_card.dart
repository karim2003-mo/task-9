
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget{
  final String image;
  final String productName;
  final double productprice;
  const ProductCard({super.key,required this.image,
  required this.productName,
  required this.productprice,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              SizedBox(
                height: constraints.maxHeight*0.7,
                child: Image.network(image, fit: BoxFit.contain),
                
              ),
              Text(
          productName,
          style: TextStyle(
            fontSize: constraints.maxWidth * 0.08,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          ),
          Text(
          "price: $productprice \$",
          style: TextStyle(
            fontSize: constraints.maxWidth * 0.07,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          ),
            ],
          ),
        ),
      );
      },
    );
  }

}