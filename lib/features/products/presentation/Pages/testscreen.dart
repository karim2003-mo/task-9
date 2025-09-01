import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task9/features/products/controller/entity/productManager.dart';
import 'package:task9/features/products/presentation/blocs/product_blocs.dart';
import 'package:task9/features/products/presentation/blocs/product_events.dart';
import 'package:task9/features/products/presentation/blocs/product_states.dart';
import '../../../../dependency injection/di_container.dart' show sl;
import '../widgets/category_card.dart';
import '../widgets/drawer.dart';
import '../widgets/search_delegate.dart';
class Testscreen extends StatefulWidget {

  const Testscreen({super.key});

  @override
  State<Testscreen> createState() => _TestscreenState();
}

class _TestscreenState extends State<Testscreen> {
  final categoryBloc=sl<CategoryBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: DrawerWidget(),
      appBar:(Productmanager.allProducts==null)?AppBar(): AppBar(
        actions: [
          Builder(
            builder: (context) => InkWell(
              onTap:(){
                Scaffold.of(context).openDrawer();
              },
              child: Container(child: Icon(
                size: 40,
                Icons.person,
                color: Colors.blueGrey,
                )),
            ),
          )
        ],
        title: Text(tr("categories.title"),
        style: TextStyle(fontWeight: FontWeight.w600,
        fontSize: 27
        ),
        ),
        leading: 
         InkWell(
          onTap:(){
            if(Productmanager.allProducts!=null){
            showSearch(context: context, delegate:
            MySearchDelegate(Productmanager.allProducts!)
            );
            }

          },
          child: Icon(Icons.search,size:40,color: Colors.blueGrey,)),
          centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => categoryBloc..add(LoadingCategoryEvent()),
        child: BlocListener<CategoryBloc, CategoryState>(
          listener: (context, state) {
            if(state is SuccessLoadingCategoryState){
              setState(() {
                
              });
            }
            // TODO: implement listener
          },
          child: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              return Container(
                margin: EdgeInsets.only(top: 5),
                child:
                (state is SuccessLoadingCategoryState)?Center(
                  child:GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                    childAspectRatio: 1,
                    mainAxisExtent:300,
                    
                    ),
                    itemCount: state.categories.length,
                    itemBuilder:(context,index)=>Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/products',arguments:state.categories[index].name );
                        },
                        child: CategoryCard(
                          categoryName: state.categories[index].name,
                          image:state.categories[index].image[0],
                          numberOfProducts:state.categories[index].numberOfProducts ,
                        ),
                      ),
                    )
                  ,
                  )
                ):(state is FailedLoadingCategoryState)?Center(
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
