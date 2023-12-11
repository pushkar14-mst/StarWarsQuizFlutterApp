import 'package:bloc/bloc.dart';
import 'package:flag_master/modules/game/game_screen.dart';
import 'package:flag_master/modules/onboarding/onboarding_screen.dart';
import 'package:flag_master/shared/cubit/cubit.dart';
import 'package:flag_master/shared/cubit/states.dart';
import 'package:flag_master/shared/styles/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_observer.dart';
import 'network/local/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  Widget widget;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;

  if (onBoarding != false) {
    widget = const GameScreen();
  } else {
    widget = const OnBoardingScreen();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Widget startWidget;
  const MyApp(this.startWidget, {super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GameCubit()),
      ],
      child: BlocConsumer<GameCubit, GameStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            theme: darkTheme,
            darkTheme: darkTheme,
            // themeMode:
            // NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
