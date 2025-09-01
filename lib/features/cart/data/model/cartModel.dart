import 'package:task9/features/cart/domain/entity/cartData.dart';

class Cartmodel extends CartData {
  Cartmodel({
   required super.cartNumbers,
    required super.cartExpiration,
     required super.cartCVV});

  Map<String, dynamic> toJson() {
    return {
      'cartNumbers': cartNumbers,
      'cartExpiration': cartExpiration,
      'cartCVV': cartCVV,
    };
  }

  factory Cartmodel.fromJson(Map<String, dynamic> json) {
    return Cartmodel(
      cartNumbers: json['cartNumbers'],
      cartExpiration: json['cartExpiration'],
      cartCVV: json['cartCVV'],
    );
  }


}