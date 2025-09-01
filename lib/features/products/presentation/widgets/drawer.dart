import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/blocs/blocs.dart';
import '../../../auth/presentation/blocs/events.dart';
import '../../../auth/presentation/blocs/states.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          return Drawer(
            child: ListView(
              children: [
                BlocProvider(
            create: (context) => SwichBloc(),
            child: BlocBuilder<SwichBloc, SwichState>(
              builder: (context, state) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text("English",
                      style: TextStyle(
                        color: (state is TrueSwichState) ? Colors.black : Colors.deepPurpleAccent,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      Switch(
                        activeThumbColor: Colors.deepPurpleAccent,
                        value: context.locale==Locale('ar','EG'),
                        onChanged: (value) {
                          if (value) {
                            context.read<SwichBloc>().add(TrueSwichEvent());
                            context.setLocale(Locale('ar', 'EG'));
                            print(context.locale);
                          } else {
                            context.read<SwichBloc>().add(FalseSwichEvent());
                            context.setLocale(Locale('en', 'US'));
                            print(context.locale);
                          }
                        },
                      ),
                      Text("العربيه",
                      style: TextStyle(
                        color: (state is TrueSwichState) ? Colors.deepPurpleAccent : Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          
          Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            child: ListTile(
              title: Text(tr("categories.cart")
              ,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              ),
              leading: Icon(size: 30,Icons.shopping_cart),
              onTap: () {
                Navigator.of(context).pushNamed('/cart');
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            child: ListTile(
              title: Text(tr("categories.SignOut")
              ,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              ),
              leading: Icon(size: 30,Icons.logout),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed('/signin');
              },
            ),
          ),

              ],
            ),
          );
        },
      );
  }
}
  