import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 27,
        ),
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/addcart');
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                  child: Center(
                    child: Text(
                      "add cart",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 35,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
                
              ),
              SizedBox(height: 40,),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/allcarts');
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.indigoAccent,
                  ),
                  child: Center(
                    child: Text(
                      "Your Cards",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 35,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
                
              ),
            ],
          ),
        ),

      ),
    );
  }
}