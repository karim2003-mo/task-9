import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task9/dependency%20injection/di_container.dart';
import 'package:task9/features/products/controller/entity/product_entity_model.dart';
import 'package:task9/features/products/presentation/blocs/product_blocs.dart';
import 'package:task9/features/products/presentation/blocs/product_events.dart';
import 'package:task9/features/products/presentation/blocs/product_states.dart';
import 'package:task9/features/products/presentation/widgets/product_card.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final productBloc=sl<ProductBloc>();
  @override
  Widget build(BuildContext context) {
    final Object args= ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products',
        style: TextStyle(fontWeight: FontWeight.w600,
        fontSize: 27
        ),
        ),
      ),
      body:BlocProvider(
        create: (context) => productBloc..add(LoadingProductEvent(null)),
        child:BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {
            // TODO: implement listener
          },
           child:BlocBuilder<ProductBloc, ProductState>(
             builder: (context, state) {
               return Container(
                child:
                (state is SuccessLoadingProductState)?Center(
                  child:GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                    childAspectRatio: 1,
                    mainAxisExtent:300,
                    
                    ),
                    itemCount: ((state.productOrProducts as List<ProductModel>).where((product)=> product.category==args)).length,
                    itemBuilder:(context,index){
                      final  products=((state.productOrProducts as List<ProductModel>).where((product)=> product.category==args)).toList();
                      return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                        },
                        child: ProductCard(
                          productName: products[index].title,
                          image:products[index].images[0],
                          productprice:products[index].price ,
                        ),
                      ),
                    );
                    }
                  )
                ):(state is FailedLoadingProductState)?Center(
                  child:Text(state.failure.messege)
                ):Center(child: CircularProgressIndicator(),)
                              );
             },
           ),
        ),
      ),
    );
  }
}