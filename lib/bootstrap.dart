// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

/// Custom instance of [BlocObserver] which logs
/// any state changes and errors.
class AppBlocObserver extends BlocObserver {
  // @override
  // void onCreate(BlocBase bloc) {
  //   super.onCreate(bloc);
  //   debugPrint('onCreate(${bloc.runtimeType})');
  // }
  //
  // @override
  // void onChange(BlocBase bloc, Change change) {
  //   super.onChange(bloc, change);
  //   if (bloc is PuzzleBloc || bloc is ThemeBloc || bloc is HistoryBloc) {
  //     debugPrint('onChange(${bloc.runtimeType}, Change:...)');
  //   } else {
  //     debugPrint('onChange(${bloc.runtimeType}, $change)');
  //   }
  // }
  //
  // @override
  // void onEvent(Bloc bloc, Object? event) {
  //   super.onEvent(bloc, event);
  //   debugPrint('onEvent(${bloc.runtimeType}, $event)');
  // }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

/// Bootstrap is responsible for any common setup and calls
/// [runApp] with the widget returned by [builder] in an error zone.
Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    debugPrint('${details.exceptionAsString()}, stackTrace: ${details.stack}');
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await BlocOverrides.runZoned(
    () async => await runZonedGuarded(
      () async => runApp(await builder()),
      (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
    ),
    blocObserver: AppBlocObserver(),
  );
}
