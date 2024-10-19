import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task_management/core/resources/constants.dart';
import 'package:task_management/data/dataSources/local/local_storage.dart';
import 'package:task_management/data/dataSources/remote/firebase_service.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/data/networkInfo/network_info.dart';
import 'package:task_management/data/repoImpl/task_repo_impl.dart';
import 'package:task_management/domain/usecase/task_usecase.dart';
import 'package:task_management/presentation/binding/connectivity_cubit.dart';
import 'package:task_management/presentation/binding/task_cubit.dart';
import 'package:task_management/presentation/binding/task_status_Selection_cubit.dart';
import 'package:task_management/presentation/screens/home.dart';
import 'firebase_options.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>(Constants.tasksBox);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context){
          return TaskCubit(taskUsecase: TaskUsecase(taskRepo: TaskRepoImpl(firebaseService: FirebaseService(), localStorage: LocalStorage(), networkInfo: NetworkInfo(connectivity: Connectivity()))));
        }),
        BlocProvider(create: (BuildContext context){
          return TaskStatusSelectionCubit();
        }),
        BlocProvider(create: (BuildContext context){
          return ConnectivityCubit(taskUsecase: TaskUsecase(taskRepo: TaskRepoImpl(firebaseService: FirebaseService(), localStorage: LocalStorage(), networkInfo: NetworkInfo(connectivity: Connectivity()))));
        })
      ],
      child: const ScreenUtilInit(child: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}