import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:task_management/domain/usecase/task_usecase.dart';

enum ConnectivityStatus { connected, disconnected }

class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  final Connectivity _connectivity = Connectivity();
  TaskUsecase taskUsecase;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  ConnectivityCubit({required this.taskUsecase}) : super(ConnectivityStatus.connected) {
    // Start listening to connectivity changes
    monitorConnectivity();
    taskUsecase.monitorConnectivity(taskUsecase.syncTasks);
    taskUsecase.monitorConnectivity(taskUsecase.syncUpdatedTasks);
  }

  void monitorConnectivity() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi)) {
        emit(ConnectivityStatus.connected);
      } else {
        emit(ConnectivityStatus.disconnected);
      }
    });
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
