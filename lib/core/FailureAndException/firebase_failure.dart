import 'package:task9/core/FailureAndException/product_failure.dart';

class AuthFailure extends Failure{
  AuthFailure({required super.messege});

}
class RegisterFailure extends AuthFailure{
  RegisterFailure({required super.messege});
}