import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:primed_health/common/db_constants.dart';

import 'package:primed_health/data/core/api_constants.dart';

import 'package:primed_health/data/models/product.dart';
import 'package:primed_health/data/models/user.dart';

import 'package:primed_health/data/repositories/auth_repository_impl.dart';
import 'package:primed_health/data/repositories/products_repository_impl.dart';

import 'package:primed_health/domain/repositories/auth_repository.dart';
import 'package:primed_health/domain/repositories/products_repository.dart';

import 'package:primed_health/presentation/blocs/auth/auth_bloc.dart';
import 'package:primed_health/presentation/blocs/products/products_bloc.dart';

import 'package:primed_health/presentation/journeys/landing.dart';
import 'package:primed_health/presentation/journeys/dashboard/home.dart';

import 'package:primed_health/di/injector.dart' as di;

import 'package:primed_health/utils/router.dart';
import 'package:primed_health/utils/my_bloc_observer.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:pedantic/pedantic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  unawaited(di.init());

  Bloc.observer = MyBlocObserver();

  final path = await getApplicationDocumentsDirectory();
  Hive.init(path.path);

  await Hive.openBox(
    DBConstants.appBoxName,
  );

    runApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthRepository>(
            create: (_) => AuthRepositoryImpl(dataSource: di.inject()),
          ),
          RepositoryProvider<ProductsRepository>(
            create: (_) => ProductsRepositoryImpl(dataSource: di.inject()),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (_) => AuthBloc(repository: di.inject()),
            ),
            BlocProvider<ProductsBloc>(
              create: (_) => ProductsBloc(repository: di.inject()),
            ),
          ],
          child: const PrimedHealthApp(),
        ),
      )
    );
  // });

}

class PrimedHealthApp extends StatefulWidget {

  const PrimedHealthApp({Key? key}) : super(key: key);

  @override
  State<PrimedHealthApp> createState() => _PrimedHealthAppState();
}

class _PrimedHealthAppState extends State<PrimedHealthApp> {

  @override
  void initState() {
    super.initState();

    BlocProvider.of<AuthBloc>(context).add(CheckAuthStatusEvent());

  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 1328),
      minTextAdapt: true,
      ensureScreenSize: true,
      splitScreenMode: true,
      builder: (_, child){
        return const MaterialApp(
          title: "Prime e-Health",
          debugShowCheckedModeBanner: false,
          home: Landing(),
          onGenerateRoute: AppRouter.generateRoute,
        );
      },
      },
    );
  }

}