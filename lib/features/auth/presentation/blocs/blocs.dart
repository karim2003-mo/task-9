import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task9/features/auth/presentation/blocs/events.dart';
import 'package:task9/features/auth/presentation/blocs/states.dart';

import '../../../../core/FailureAndException/firebase_failure.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialAuthState()) {
    on<LoadingAuthEvent>(_onLoadingAuthEvent);
    on<LoadingAuthSuccessEvent>(_onLoadingAuthSuccessEvent);
    on<LoadingAuthFailedEvent>(_onLoadingAuthFailedEvent);
  }

  FutureOr<void> _onLoadingAuthEvent(LoadingAuthEvent event, Emitter<AuthState> emit) async{
    emit(LoadingAuthState());
    final firebaseAuth=FirebaseAuth.instance;
    final firebaseFireStore=FirebaseFirestore.instance;
    try {
      if(event.authType==AuthType.signUp){
        final user = await firebaseAuth.createUserWithEmailAndPassword(email: event.email, password: event.password);
        await firebaseFireStore.collection("users").doc(firebaseAuth.currentUser!.uid).set({
          "email": event.email,
          "username": event.username,
        });
        add(LoadingAuthSuccessEvent(user.user!.uid));
      }else{
        final user= await firebaseAuth.signInWithEmailAndPassword(email: event.email, password: event.password);
        add(LoadingAuthSuccessEvent(user.user!.uid));
      }
    }
    on FirebaseAuthException catch (e) {
      add(LoadingAuthFailedEvent(AuthFailure(messege: tr("errors.${e.code}"))));
      
      
    }
     catch (e) {
      add(LoadingAuthFailedEvent(AuthFailure(messege: tr("errors.unknown"))));
    }

  }

  FutureOr<void> _onLoadingAuthSuccessEvent(LoadingAuthSuccessEvent event, Emitter<AuthState> emit) {
    emit(AuthLoadingSuccessState());
  }

  FutureOr<void> _onLoadingAuthFailedEvent(LoadingAuthFailedEvent event, Emitter<AuthState> emit) {
    emit(AuthLoadingFailedState(event.failure));
  }
}
class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc() : super(PasswordState()) {
    on<VisiblePasswordEvent>(_onVisiblePasswordEvent);
    on<InVisiblePasswordEvent>(_onInVisiblePasswordEvent);
  }

  FutureOr<void> _onVisiblePasswordEvent(VisiblePasswordEvent event, Emitter<PasswordState> emit) {
    emit(VisiblePasswordState());
  }

  FutureOr<void> _onInVisiblePasswordEvent(InVisiblePasswordEvent event, Emitter<PasswordState> emit) {
    emit(InVisiblePasswordState());
  }
}
class SwichBloc extends Bloc<SwichEvent, SwichState> {
  SwichBloc() : super(SwichState()) {
    on<TrueSwichEvent>(_onTrueSwichEvent);
    on<FalseSwichEvent>(_onFalseSwichEvent);
  }

  FutureOr<void> _onTrueSwichEvent(TrueSwichEvent event, Emitter<SwichState> emit) {
    emit(TrueSwichState());
  }

  FutureOr<void> _onFalseSwichEvent(FalseSwichEvent event, Emitter<SwichState> emit) {
    emit(FalseSwichState());
  }
}
