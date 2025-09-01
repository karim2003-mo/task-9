import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:task9/dependency%20injection/di_container.dart';
import 'package:task9/features/auth/presentation/blocs/blocs.dart';
import 'package:task9/features/auth/presentation/widgets/txtfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/events.dart';
import '../blocs/states.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();

  final TextEditingController usernamecontroller = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authbloc = sl<AuthBloc>();
    return Scaffold(
      appBar: AppBar(
        actions: [
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
                        color: (state is TrueSwichState) ? Colors.deepPurpleAccent : Colors.white,
                        fontSize: 18,
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
                        color: (state is TrueSwichState) ? Colors.white : Colors.deepPurpleAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
        backgroundColor: Colors.blue,
        title: Text(tr("signUp.title")),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              width: double.infinity,
              height: 500,
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: CustomFormTextField(
                        controller: emailcontroller,
                        hintText: "signUp.email".tr(),
                        prefixIcon: Icon(Icons.email),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return tr("formvalidations.emailerror");
                          } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(value)) {
                            return tr("formvalidations.emailerror");
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: CustomFormTextField(
                        controller: usernamecontroller,
                        hintText: tr("signUp.name"),
                        prefixIcon: Icon(Icons.person),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return tr("formvalidations.nameerror");
                          }
                          return null;
                        },
                      ),
                    ),
                    BlocProvider(
                      create: (context) => PasswordBloc(),

                      child: BlocListener<PasswordBloc, PasswordState>(
                        listener: (context, passwordState) {},
                        child: BlocBuilder<PasswordBloc, PasswordState>(
                          builder: (context, state) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 15),
                              child: CustomFormTextField(
                                controller: passwordcontroller,
                                hintText: tr("signUp.password"),
                                prefixIcon: Icon(Icons.password),
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: (state is InVisiblePasswordState)
                                    ? true
                                    : false,
                                suffixIcon: InkWell(
                                  onTap: () {
                                    if (state is InVisiblePasswordState) {
                                      context.read<PasswordBloc>().add(
                                        VisiblePasswordEvent(),
                                      );
                                    } else {
                                      context.read<PasswordBloc>().add(
                                        InVisiblePasswordEvent(),
                                      );
                                    }
                                  },
                                  child: Icon(
                                    (state is InVisiblePasswordState)
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return tr("formvalidations.passworderror");
                                  } else if (value.length < 6) {
                                    return tr("formvalidations.passworderror");
                                  }
                                  return null;
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BlocProvider(
              create: (context) => authbloc,
              child: BlocListener<AuthBloc, AuthState>(
                listener: (context, authState) {
                  if (authState is AuthLoadingSuccessState) {
                    Navigator.pushReplacementNamed(context, "/categories");
                  } else if (authState is AuthLoadingFailedState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(authState.failure.messege)),
                    );
                  }
                },
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, sigupState) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(50),
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: (sigupState is LoadingAuthState)
                            ? null
                            : () {
                                if (formkey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                    LoadingAuthEvent(
                                      usernamecontroller.text,
                                      email: emailcontroller.text,
                                      password: passwordcontroller.text,
                                      authType: AuthType.signUp,
                                    ),
                                  );
                                }
                              },
                        child: (sigupState is LoadingAuthState)
                            ? Center(child: CircularProgressIndicator())
                            : Text(
                                tr("signUp.signUp"),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                              ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
