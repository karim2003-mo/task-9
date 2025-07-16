// ignore_for_file: use_super_parameters, prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';
import 'package:task9/core/FailureAndException/errors_str.dart';

class Failure extends Equatable{
  final String messege;
  Failure({required this.messege});
  @override
  List<Object?> get props => [messege];
}
class InternetFailure extends Failure{
  InternetFailure({String messege=AppErrorMessages.noInternetConnection}):super(messege: messege);

}
class BadRequestFailure extends Failure {
  BadRequestFailure({String messege = AppErrorMessages.badRequest}) : super(messege: messege);
}

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure({String messege = AppErrorMessages.unauthorized}) : super(messege: messege);
}

class ForbiddenFailure extends Failure {
  ForbiddenFailure({String messege =AppErrorMessages.forbidden }) : super(messege: messege);
}

class NotFoundFailure extends Failure {
  NotFoundFailure({String messege = AppErrorMessages.notFound}) : super(messege: messege);
}

class MethodNotAllowedFailure extends Failure {
  MethodNotAllowedFailure({String messege = AppErrorMessages.methodNotAllowed}) : super(messege: messege);
}

class RequestTimeoutFailure extends Failure {
  RequestTimeoutFailure({String messege = AppErrorMessages.requestTimeout}) : super(messege: messege);
}

class TooManyRequestsFailure extends Failure {
  TooManyRequestsFailure({String messege = AppErrorMessages.tooManyRequests}) : super(messege: messege);
}

class InternalServerErrorFailure extends Failure {
  InternalServerErrorFailure({String messege = AppErrorMessages.internalServerError}) : super(messege: messege);
}

class BadGatewayFailure extends Failure {
  BadGatewayFailure({String messege = AppErrorMessages.badGateway}) : super(messege: messege);
}

class ServiceUnavailableFailure extends Failure {
  ServiceUnavailableFailure({String messege = AppErrorMessages.serviceUnavailable}) : super(messege: messege);
}

class GatewayTimeoutFailure extends Failure {
  GatewayTimeoutFailure({String messege = AppErrorMessages.gatewayTimeout}) : super(messege: messege);
}

class UnknownErrorFailure extends Failure {
  UnknownErrorFailure({String messege = AppErrorMessages.unknownError}) : super(messege: messege);
}