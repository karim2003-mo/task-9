import 'package:flutter/widgets.dart';
import 'package:task9/features/auth/presentation/pages/signin.dart';
import 'package:task9/features/auth/presentation/pages/signup.dart';
import 'package:task9/features/cart/presentation/pages/allcarts.dart';
import 'package:task9/features/products/presentation/Pages/testscreen.dart';

import '../../features/cart/presentation/pages/Cart.dart';
import '../../features/cart/presentation/pages/addcart.dart';
import '../../features/products/presentation/Pages/product_screen.dart';

class Routes {
  static final Map<String, Widget Function(BuildContext)> routes={
    "/categories":(context)=>Testscreen(),
    "/products":(context)=>ProductScreen(),
    "/signup":(context)=>SignUp(),
    "/signin":(context)=>SigIn(),
    "/addcart":(context)=>AddCartPage(),
    "/cart":(context)=>CartPage(),
    "/allcarts":(context)=>AllCartsPage(),
  };
}