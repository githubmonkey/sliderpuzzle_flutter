// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leaders_repository/leaders_repository.dart';
import 'package:very_good_slide_puzzle/audio_control/audio_control.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/language_control/bloc/language_control_bloc.dart';
import 'package:very_good_slide_puzzle/login/login.dart';
import 'package:very_good_slide_puzzle/mslide/mslide.dart';
import 'package:very_good_slide_puzzle/mswap/mswap.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/settings/settings.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/timer/timer.dart';

import 'helpers.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget, {
    LoginBloc? loginBloc,
    ThemeBloc? themeBloc,
    SettingsBloc? settingsBloc,
    LanguageControlBloc? languageControlBloc,
    DashatarThemeBloc? dashatarThemeBloc,
    DashatarPuzzleBloc? dashatarPuzzleBloc,
    MslideThemeBloc? mslideThemeBloc,
    MslidePuzzleBloc? mslidePuzzleBloc,
    MswapThemeBloc? mswapThemeBloc,
    MswapPuzzleBloc? mswapPuzzleBloc,
    PuzzleBloc? puzzleBloc,
    TimerBloc? timerBloc,
    AudioControlBloc? audioControlBloc,
    //firebase_auth.UserCredential? userCredential,
    //firebase_auth.FirebaseAuth? firebaseAuth,
    AuthRepository? authRepository,
    LeadersRepository? leadersRepository,
  }) {
    return pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(
            value: authRepository ?? MockAuthRepository(),
          ),
          RepositoryProvider.value(
            value: leadersRepository ?? MockLeadersRepository(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: loginBloc ?? MockLoginBloc(),
            ),
            BlocProvider.value(
              value: themeBloc ?? MockThemeBloc(),
            ),
            BlocProvider.value(
              value: settingsBloc ?? MockSettingsBloc(),
            ),
            BlocProvider.value(
              value: languageControlBloc ?? MockLanguageControlBloc(),
            ),
            BlocProvider.value(
              value: dashatarThemeBloc ?? MockDashatarThemeBloc(),
            ),
            BlocProvider.value(
              value: dashatarPuzzleBloc ?? MockDashatarPuzzleBloc(),
            ),
            BlocProvider.value(
              value: mslideThemeBloc ?? MockMslideThemeBloc(),
            ),
            BlocProvider.value(
              value: mslidePuzzleBloc ?? MockMslidePuzzleBloc(),
            ),
            BlocProvider.value(
              value: mswapThemeBloc ?? MockMswapThemeBloc(),
            ),
            BlocProvider.value(
              value: mswapPuzzleBloc ?? MockMswapPuzzleBloc(),
            ),
            BlocProvider.value(
              value: puzzleBloc ?? MockPuzzleBloc(),
            ),
            BlocProvider.value(
              value: timerBloc ?? MockTimerBloc(),
            ),
            BlocProvider.value(
              value: audioControlBloc ?? MockAudioControlBloc(),
            ),
          ],
          child: MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: widget,
          ),
        ),
      ),
    );
  }
}
