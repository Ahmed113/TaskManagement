import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';


class NetworkInfo {
  final Connectivity connectivity;
  NetworkInfo({required this.connectivity});

  Future<bool> isConnected() async {
    var result = await connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.wifi) || result.contains(ConnectivityResult.mobile)) {
      return true;
    }
    return false;
  }

  void monitorConnectivity(Function onConnected) {
    connectivity.onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.wifi) || result.contains(ConnectivityResult.mobile)) {
        onConnected();
      }
    });
  }

}
