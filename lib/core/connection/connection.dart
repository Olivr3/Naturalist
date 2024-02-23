import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class Connection {
  Future<bool> isConnected();
}

class ConnectionImpl extends Connection {
  @override
  Future<bool> isConnected() => InternetConnectionChecker().hasConnection;
}
