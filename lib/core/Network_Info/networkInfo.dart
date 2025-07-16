import 'package:internet_connection_checker/internet_connection_checker.dart';

class Networkinfo  {
  final InternetConnectionChecker connectionChecker;
  Networkinfo({required this.connectionChecker});
  Future<bool> get internetStatus async =>await connectionChecker.hasConnection;
}