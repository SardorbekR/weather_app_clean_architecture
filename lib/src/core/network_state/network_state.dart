import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkState {
  Future<bool> isInternetConnected() async {
    final connection = await Connectivity().checkConnectivity();

    switch (connection) {
      case ConnectivityResult.none:
        return false;
      case ConnectivityResult.mobile:
        return true;
      case ConnectivityResult.wifi:
        return _checkConnection();
      default:
        return false;
    }
  }

  Future<bool> _checkConnection() async {
    late bool connected;

    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connected = true;
      }
    } catch (_) {
      connected = false;
    }

    return connected;
  }
}
