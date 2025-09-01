import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:task9/features/products/controller/entity/product_entity_model.dart';
class ProductDialogue extends StatelessWidget {
  const ProductDialogue({super.key,required this.product});
  final ProductModel? product;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(tr("productdetails")),
      content: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.network(product!.images[0]),
          Text('Product Name: ${product!.title}',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          ),
          Text(product!.description,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          ),
          Text('\$${product!.price}',
          style: TextStyle(
            fontSize: 18,
            color: Colors.red,
            fontWeight: FontWeight.w500,
          ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red,
            ),
            child: ElevatedButton(
              
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: ()async{
                
              }, child: Text('Add To Cart',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white
            ),
            )),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Close'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}