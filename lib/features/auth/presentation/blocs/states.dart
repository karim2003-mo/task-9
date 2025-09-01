import '../../../../core/FailureAndException/firebase_failure.dart';

abstract class AuthState {}

class InitialAuthState extends AuthState {}

class LoadingAuthState extends AuthState {}

class AuthLoadingSuccessState extends AuthState {}

class AuthLoadingFailedState extends AuthState {
  final AuthFailure failure;

  AuthLoadingFailedState(this.failure);
}
class PasswordState{}
class VisiblePasswordState extends PasswordState{}
class InVisiblePasswordState extends PasswordState{}
class SwichState{}
class TrueSwichState extends SwichState{}
class FalseSwichState extends SwichState{}


