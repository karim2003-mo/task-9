
import 'package:flutter/material.dart';
import 'package:task9/features/products/controller/entity/product_entity_model.dart';

class MySearchDelegate extends SearchDelegate<String> {
  final List<ProductModel> data;

  MySearchDelegate(this.data);
  List<ProductModel> searchsuggestions(String text){
    return data.where((product){
      final category=product.category.toLowerCase().split("");
      final title=product.title.toLowerCase().split(" ");
      if(category.contains(text.toLowerCase()) || title.contains(text.toLowerCase())){
        return true;
      }else if(product.category.toLowerCase().startsWith(text.toLowerCase())||
      product.title.toLowerCase().startsWith(text.toLowerCase())){
        return true;
      }else if(product.category.toLowerCase().endsWith(text.toLowerCase())||
      product.title.toLowerCase().endsWith(text.toLowerCase())){
        return true;
      }
      return false;
    }).toList();
  }
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; 
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestions = data
        .where((item) => item.category.toLowerCase().contains(query.toLowerCase())
        ||item.title.toLowerCase().contains(query.toLowerCase())
        ||item.title.split(" ").contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return  Container(
    padding: EdgeInsets.all(16),
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      
      children: [
        SizedBox(
          width: 70,
          child: Image.network(suggestions[index].images[0])),
        Expanded(
          child: Text(
            overflow: TextOverflow.ellipsis,
            suggestions[index].title,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    ),
  );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = searchsuggestions(query);
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return  Container(
    padding: EdgeInsets.all(16),
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      
      children: [
        SizedBox(
          width: 70,
          child: Image.network(suggestions[index].images[0])),
        Expanded(
          child: Text(
            overflow: TextOverflow.ellipsis,
            suggestions[index].title,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    ),
  );
      },
    );
  }
}
