import 'package:flutter/widgets.dart';
import 'package:task9/features/products/presentation/Pages/testscreen.dart';

import '../../features/products/presentation/Pages/product_screen.dart';

class Routes {
  static final Map<String, Widget Function(BuildContext)> routes={
    "/categories":(context)=>Testscreen(),
    "/products":(context)=>ProductScreen()
  };
}