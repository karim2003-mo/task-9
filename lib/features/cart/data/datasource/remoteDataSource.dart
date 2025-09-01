import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/FailureAndException/cardException.dart';
import '../model/cartModel.dart';

class RemoteDataSource {
  final fireStoreInstance=FirebaseFirestore.instance;

  Future addCart(Cartmodel cartData, String userId)async{
    try {
      final result=await fireStoreInstance.collection("users").doc(userId).
      collection("carts").add(cartData.toJson());
      return result;
      
    } catch (e) {
      throw CreditCardException();
    }

  }
  Future<List<Cartmodel>> getCart(String userId)async{
    try {
      final result=await fireStoreInstance.collection("users").doc(userId).
      collection("carts").get();
      final List<Cartmodel> cartList=[];
      for (var element in result.docs) {
        cartList.add(Cartmodel.fromJson(element.data()));
      }
      return cartList;
    } catch (e) {
      throw CreditCardException();
    }
  }
}