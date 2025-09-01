import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../data/model/cartModel.dart';

class AddCartPage extends StatefulWidget {
  const AddCartPage({super.key});

  @override
  _AddCartPageState createState() => _AddCartPageState();
}

class _AddCartPageState extends State<AddCartPage> {
  bool isLoading=false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _expiredDateController = TextEditingController();
  final _firestore=FirebaseFirestore.instance;
  final _fireAuth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(tr('addCart')),
      ),
      body: Column(
        children: [
          SvgPicture.asset("assets/credit-card/credit-card.svg",width: 200,),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _cardNumberController,
                    decoration: InputDecoration(
                      labelText: tr('cardNumber'),
                    ),
                    validator: (value) {
                      if (value!.length<16) {
                        return tr('cardNumberError');
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _cvvController,
                    decoration: InputDecoration(
                      labelText: tr('cvv'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return tr('cvvError');
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _expiredDateController,
                    decoration: InputDecoration(
                      hintText: "MM/YY",
                      labelText: tr('expiredDate'),
                    ),
                    validator: (value) {
                      if (value!.length<4) {
                        return tr('expiredDateError');
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async{
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading=true;
                        });
                        final cartData = Cartmodel(
                          cartNumbers: _cardNumberController.text,
                          cartExpiration: _expiredDateController.text,
                          cartCVV: _cvvController.text,
                        );
                        final userUid=await _fireAuth.currentUser!.uid;
                        await _firestore.collection("users").doc(userUid).collection("cart").add(cartData.toJson());
                        Navigator.pushNamed(context, '/allcarts');
                        // Add cart data to database
                      }
                    },
                    child:(isLoading)?CircularProgressIndicator(): Text(tr('add'),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white
                    ),
                    ),
                  
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
