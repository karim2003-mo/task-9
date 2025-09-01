
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math';
import '../../data/model/cartModel.dart';
class AllCartsPage extends StatelessWidget {
   AllCartsPage({Key? key}) : super(key: key);
  final random = Random();
  static const List colors=[
    Color.fromRGBO(70, 99, 240, 1),
    Color.fromRGBO(135, 102, 253, 1),
    Color.fromRGBO(165, 15, 224, 1),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Carts"),
      ),
      body: FutureBuilder(
        future: getCarts(),
        builder: (context, AsyncSnapshot<List<Cartmodel>> snapshot) {
          if (snapshot.hasData) {
            return Container(
              color: Colors.white,
              child: Center(
                child:(snapshot.data!.isEmpty)?CircularProgressIndicator():
                 ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    Cartmodel cart = snapshot.data![index];
                    return Container(
                
                      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:colors[random.nextInt(colors.length)] ,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset("assets/credit-card/credit-card.svg",width: 100,),
                          Text("${cart.cartNumbers}",style: TextStyle(fontSize: 18),),
                          
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
  Future<List<Cartmodel>> getCarts() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return [];
    }

    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('cart')
        .get();

    return snapshot.docs.map((doc) => Cartmodel.fromJson(doc.data())).toList();
  }
}
class SelectCartPage extends StatefulWidget {
   SelectCartPage({Key? key}) : super(key: key);
  static const List colors=[
    Color.fromRGBO(70, 99, 240, 1),
    Color.fromRGBO(135, 102, 253, 1),
    Color.fromRGBO(165, 15, 224, 1),
  ];

  @override
  State<SelectCartPage> createState() => _SelectCartPageState();
}

class _SelectCartPageState extends State<SelectCartPage> {
  final random = Random();
String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Cart"),
      ),
      body: FutureBuilder(
        future: getCarts(),
        builder: (context, AsyncSnapshot<List<Cartmodel>> snapshot) {
          if (snapshot.hasData) {
            return Container(
              color: Colors.white,
              child: Center(
                child:(snapshot.data!.isEmpty)?CircularProgressIndicator():
                 ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    Cartmodel cart = snapshot.data![index];
                    return Container(
                
                      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:SelectCartPage.colors[random.nextInt(SelectCartPage.colors.length)] ,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Radio<String>(
              value: cart.cartNumbers,
              groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                });}),
                          Text("${cart.cartNumbers}",style: TextStyle(fontSize: 18),),
                          
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<List<Cartmodel>> getCarts() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return [];
    }

    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('cart')
        .get();

    return snapshot.docs.map((doc) => Cartmodel.fromJson(doc.data())).toList();
  }
}