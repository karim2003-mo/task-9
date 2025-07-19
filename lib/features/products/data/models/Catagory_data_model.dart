import 'package:task9/features/products/controller/entity/categories_model.dart';

class CatagoryDataModel extends CategoryModel {
  CatagoryDataModel({required super.name,
   required super.numberOfProducts,
    required super.image,
     required super.thumbnail});
    factory CatagoryDataModel.fromJson(Map<String, dynamic> json) {
      return CatagoryDataModel(
        name: json['name'] as String,
        numberOfProducts: json['numberOfProducts'] as int,
        image: json['image'],
        thumbnail: json['thumbnail'],
      );
    }

    Map<String, dynamic> toJson() {
      return {
        'name': name,
        'numberOfProducts': numberOfProducts,
        'image': image,
        'thumbnail': thumbnail,
      };
    }
}