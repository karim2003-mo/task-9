import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math';
import '../../data/model/cartModel.dart';

class AllCartsPage extends StatelessWidget {
  final bool isshow;
  AllCartsPage({Key? key, this.isshow = true}) : super(key: key);
  final random = Random();
  @override
  Widget build(BuildContext context) {
    return (isshow)
        ? Scaffold(
            appBar: AppBar(title: Text("All Carts")),
            body: FutureBuilder(
              future: getCarts(),
              builder: (context, AsyncSnapshot<List<Cartmodel>> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    color: Colors.white,
                    child: Center(
                      child: (snapshot.data!.isEmpty)
                          ? CircularProgressIndicator()
                          : ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) {
                                Cartmodel cart = snapshot.data![index];
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 20,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(70, 99, 240, 1),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/credit-card/credit-card.svg",
                                        width: 100,
                                      ),
                                      Text(
                                        "${cart.cartNumbers}",
                                        style: TextStyle(fontSize: 18),
                                      ),
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
          )
        : SelectCartPage();
  }
}

class SelectCartPage extends StatefulWidget {
  SelectCartPage({Key? key}) : super(key: key);

  @override
  State<SelectCartPage> createState() => _SelectCartPageState();
}

class _SelectCartPageState extends State<SelectCartPage> {
  final random = Random();
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Cart")),
      body: FutureBuilder(
        future: getCarts(),
        builder: (context, AsyncSnapshot<List<Cartmodel>> snapshot) {
          if (snapshot.hasData) {
            return Container(
              color: Colors.white,
              child: Center(
                child: (snapshot.data!.isEmpty)
                    ? CircularProgressIndicator()
                    : Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 500,
                            child: ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) {
                                Cartmodel cart = snapshot.data![index];
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 20,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(70, 99, 240, 1),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Radio<String>(
                                        value: cart.cartNumbers,
                                        groupValue: selectedValue,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedValue = value;
                                          });
                                        },
                                      ),
                                      Text(
                                        "${cart.cartNumbers}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 50),
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        15,
                                      ),
                                    ),
                                    child: Container(
                                      width: 250,
                                      height: 200,
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size: 50,
                                          ),
                                          SizedBox(height: 15),
                                          Text(
                                            "Added to cart successfully",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(
                              "Add To Cart",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

Future<List<Cartmodel>> getCarts() async {
  final User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return [];
  }

  final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
      .instance
      .collection('users')
      .doc(user.uid)
      .collection('cart')
      .get();

  return snapshot.docs.map((doc) => Cartmodel.fromJson(doc.data())).toList();
}
