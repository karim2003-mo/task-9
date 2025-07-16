class InternetConnectionException implements Exception{}
abstract class ServerException implements Exception {}

class BadRequestException implements ServerException {
  const BadRequestException();
}

class UnauthorizedException implements ServerException {
  const UnauthorizedException();
}

class ForbiddenException implements ServerException {
  const ForbiddenException();
}

class NotFoundException implements ServerException {
  const NotFoundException();
}

class MethodNotAllowedException implements ServerException {
  const MethodNotAllowedException();
}

class RequestTimeoutException implements ServerException {
  const RequestTimeoutException();
}

class TooManyRequestsException implements ServerException {
  const TooManyRequestsException();
}

class InternalServerErrorException implements ServerException {
  const InternalServerErrorException();
}

class BadGatewayException implements ServerException {
  const BadGatewayException();
}

class ServiceUnavailableException implements ServerException {
  const ServiceUnavailableException();
}

class GatewayTimeoutException implements ServerException {
  const GatewayTimeoutException();
}

class UnknownServerException implements ServerException {
  const UnknownServerException();
}

