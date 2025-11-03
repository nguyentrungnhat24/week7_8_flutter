import 'package:firebase_core/firebase_core.dart';
import 'package:fl_week01/firebase_options.dart';
import 'package:fl_week01/src/blocs/login_bloc.dart';
import 'package:fl_week01/src/blocs/signup_bloc.dart';
import 'package:fl_week01/src/repositories/auth_repository.dart';
import 'package:fl_week01/src/resources/signIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo Firebase với options cho từng platform
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Tạo instance của AuthRepository
  final authRepository = AuthRepository();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (context) => authRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginCubit>(
            create: (context) =>
                LoginCubit(authRepository: context.read<AuthRepository>()),
          ),
          BlocProvider<SignUpCubit>(
            create: (context) =>
                SignUpCubit(authRepository: context.read<AuthRepository>()),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}
