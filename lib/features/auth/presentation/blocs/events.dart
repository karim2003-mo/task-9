
// AUTH EVENTS
import '../../../../core/FailureAndException/firebase_failure.dart';
enum AuthType { signIn, signUp }
abstract class AuthEvent {}
class LoadingAuthEvent extends AuthEvent {
  final String email;
  final String password;
  final String username;
  final AuthType authType;
  LoadingAuthEvent(this.username,{required this.email, required this.password,required this.authType});
}

class LoadingAuthSuccessEvent extends AuthEvent {
  final String userId;

  LoadingAuthSuccessEvent(this.userId);
}

class LoadingAuthFailedEvent extends AuthEvent {
  final AuthFailure failure;

  LoadingAuthFailedEvent(this.failure);
}
class PasswordEvent{}
class VisiblePasswordEvent extends PasswordEvent{}
class InVisiblePasswordEvent extends PasswordEvent{}
class SwichEvent{}
class TrueSwichEvent extends SwichEvent{}
class FalseSwichEvent extends SwichEvent{}
