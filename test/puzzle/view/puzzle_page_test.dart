// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leaders_api/leaders_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_slide_puzzle/audio_control/audio_control.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/language_control/language_control.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/login/login.dart';
import 'package:very_good_slide_puzzle/mslide/mslide.dart';
import 'package:very_good_slide_puzzle/mswap/mswap.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/settings/bloc/settings_bloc.dart';
import 'package:very_good_slide_puzzle/simple/simple.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/timer/timer.dart';

import '../../helpers/helpers.dart';

void main() {
  group('PuzzlePage', () {
    late LanguageControlBloc languageControlBloc;
    late LoginBloc loginBloc;
    late LanguageControlState languageControlState;

    setUp(() {
      languageControlState = LanguageControlState(locale: null);
      languageControlBloc = MockLanguageControlBloc();
      loginBloc = MockLoginBloc();
      when(() => languageControlBloc.state).thenReturn(languageControlState);
      when(() => loginBloc.state).thenReturn(LoginState.unauthenticated());
    });

    testWidgets('renders PuzzleView', (tester) async {
      await tester.pumpApp(
        PuzzlePage(),
        languageControlBloc: languageControlBloc,
        loginBloc: loginBloc,
      );
      expect(find.byType(PuzzleView), findsOneWidget);
    });

    testWidgets('provides all Dashatar themes to PuzzleView', (tester) async {
      await tester.pumpApp(
        PuzzlePage(),
        languageControlBloc: languageControlBloc,
        loginBloc: loginBloc,
      );

      final BuildContext puzzleViewContext =
          tester.element(find.byType(PuzzleView));

      final dashatarThemes =
          puzzleViewContext.read<DashatarThemeBloc>().state.themes;

      expect(
        dashatarThemes,
        equals([
          BlueDashatarTheme(),
          GreenDashatarTheme(),
          YellowDashatarTheme(),
        ]),
      );
    });

    testWidgets('provides all Mslide themes to PuzzleView', (tester) async {
      await tester.pumpApp(
        PuzzlePage(),
        languageControlBloc: languageControlBloc,
        loginBloc: loginBloc,
      );

      final BuildContext puzzleViewContext =
          tester.element(find.byType(PuzzleView));

      final mslideThemes =
          puzzleViewContext.read<MslideThemeBloc>().state.themes;

      expect(
        mslideThemes,
        equals([
          BlueMslideTheme(),
          GreenMslideTheme(),
          YellowMslideTheme(),
        ]),
      );
    });

    testWidgets('provides correct initial themes to PuzzleView',
        (tester) async {
      await tester.pumpApp(
        PuzzlePage(),
        languageControlBloc: languageControlBloc,
        loginBloc: loginBloc,
      );

      final BuildContext puzzleViewContext =
          tester.element(find.byType(PuzzleView));

      final initialThemes = puzzleViewContext.read<ThemeBloc>().state.themes;

      expect(
        initialThemes,
        equals([
          YellowMslideTheme(),
          GreenMswapTheme(),
          SimpleTheme(),
          BlueDashatarTheme(),
        ]),
      );
    });

    testWidgets(
        'provides DashatarPuzzleBloc '
        'with secondsToBegin equal to 3', (tester) async {
      await tester.pumpApp(
        PuzzlePage(),
        languageControlBloc: languageControlBloc,
        loginBloc: loginBloc,
      );

      final BuildContext puzzleViewContext =
          tester.element(find.byType(PuzzleView));

      final secondsToBegin =
          puzzleViewContext.read<DashatarPuzzleBloc>().state.secondsToBegin;

      expect(
        secondsToBegin,
        equals(3),
      );
    });

    testWidgets(
        'provides TimerBloc '
        'with initial state', (tester) async {
      await tester.pumpApp(
        PuzzlePage(),
        languageControlBloc: languageControlBloc,
        loginBloc: loginBloc,
      );

      final BuildContext puzzleViewContext =
          tester.element(find.byType(PuzzleView));

      expect(
        puzzleViewContext.read<TimerBloc>().state,
        equals(TimerState()),
      );
    });

    testWidgets(
        'provides AudioControlBloc '
        'with initial state', (tester) async {
      await tester.pumpApp(
        PuzzlePage(),
        languageControlBloc: languageControlBloc,
        loginBloc: loginBloc,
      );

      final BuildContext puzzleViewContext =
          tester.element(find.byType(PuzzleView));

      expect(
        puzzleViewContext.read<AudioControlBloc>().state,
        equals(AudioControlState()),
      );
    });
  });

  group('PuzzleView', () {
    late LoginBloc loginBloc;
    late ThemeBloc themeBloc;
    late PuzzleTheme theme;
    late TimerBloc timerBloc;
    late SettingsBloc settingsBloc;
    late LanguageControlBloc languageControlBloc;
    late DashatarThemeBloc dashatarThemeBloc;
    late MslideThemeBloc mslideThemeBloc;
    late MswapThemeBloc mswapThemeBloc;
    late PuzzleLayoutDelegate layoutDelegate;
    late AudioControlBloc audioControlBloc;
    late TimerState  timerState;
    late SettingsState settingsState;
    late LanguageControlState languageControlState;

    setUp(() {
      theme = MockPuzzleTheme();
      final themeState = ThemeState(themes: [theme], theme: theme);
      themeBloc = MockThemeBloc();
      timerBloc = MockTimerBloc();
      timerState = TimerState(isRunning: true, secondsElapsed: 100);
      when(() => timerBloc.state).thenReturn(timerState);

      settingsBloc = MockSettingsBloc();
      settingsState = SettingsState(
        settings: Settings(
          boardSize: 2,
          game: Game.roman,
          elevenToTwenty: true,
        ),
      );
      languageControlState = LanguageControlState(locale: null);

      layoutDelegate = MockPuzzleLayoutDelegate();

      loginBloc = MockLoginBloc();
      when(() => loginBloc.state).thenReturn(LoginState.unauthenticated());

      languageControlBloc = MockLanguageControlBloc();
      when(() => languageControlBloc.state).thenReturn(languageControlState);

      when(() => layoutDelegate.startSectionBuilder(any()))
          .thenReturn(SizedBox());

      when(() => layoutDelegate.endSectionBuilder(any()))
          .thenReturn(SizedBox());

      when(() => layoutDelegate.backgroundBuilder(any()))
          .thenReturn(SizedBox());

      when(() => layoutDelegate.boardBuilder(any(), any(), any()))
          .thenReturn(SizedBox());

      when(() => layoutDelegate.tileBuilder(any(), any()))
          .thenReturn(SizedBox());

      when(layoutDelegate.whitespaceTileBuilder).thenReturn(SizedBox());

      when(() => theme.layoutDelegate).thenReturn(layoutDelegate);
      when(() => theme.backgroundColor).thenReturn(Colors.black);
      when(() => theme.isLogoColored).thenReturn(true);
      when(() => theme.menuActiveColor).thenReturn(Colors.black);
      when(() => theme.menuUnderlineColor).thenReturn(Colors.black);
      when(() => theme.menuInactiveColor).thenReturn(Colors.black);
      when(() => theme.hasTimer).thenReturn(true);
      when(() => theme.name).thenReturn('Name');
      when(() => theme.audioControlOnAsset)
          .thenReturn('assets/images/audio_control/simple_on.png');
      when(() => theme.audioControlOffAsset)
          .thenReturn('assets/images/audio_control/simple_off.png');
      when(() => themeBloc.state).thenReturn(themeState);
      when(() => settingsBloc.state).thenReturn(settingsState);

      dashatarThemeBloc = MockDashatarThemeBloc();
      when(() => dashatarThemeBloc.state)
          .thenReturn(DashatarThemeState(themes: [GreenDashatarTheme()]));

      mslideThemeBloc = MockMslideThemeBloc();
      when(() => mslideThemeBloc.state)
          .thenReturn(MslideThemeState(themes: [GreenMslideTheme()]));

      mswapThemeBloc = MockMswapThemeBloc();
      when(() => mswapThemeBloc.state)
          .thenReturn(MswapThemeState(themes: [YellowMswapTheme()]));

      audioControlBloc = MockAudioControlBloc();
      when(() => audioControlBloc.state).thenReturn(AudioControlState());
    });

    setUpAll(() {
      registerFallbackValue(MockPuzzleState());
      registerFallbackValue(MockTile());
      registerFallbackValue(MockSettingsState());
    });

    testWidgets(
        'adds ThemeUpdated to ThemeBloc '
        'when DashatarTheme changes', (tester) async {
      final themes = [GreenDashatarTheme(), BlueDashatarTheme()];

      whenListen(
        dashatarThemeBloc,
        Stream.fromIterable([
          DashatarThemeState(themes: themes, theme: GreenDashatarTheme()),
          DashatarThemeState(themes: themes, theme: BlueDashatarTheme()),
        ]),
      );

      await tester.pumpApp(
        PuzzleView(),
        loginBloc: loginBloc,
        themeBloc: themeBloc,
        settingsBloc: settingsBloc,
        languageControlBloc: languageControlBloc,
        dashatarThemeBloc: dashatarThemeBloc,
        mslideThemeBloc: mslideThemeBloc,
        mswapThemeBloc: mswapThemeBloc,
        audioControlBloc: audioControlBloc,
      );

      verify(() => themeBloc.add(ThemeUpdated(theme: GreenDashatarTheme())))
          .called(1);

      verify(() => themeBloc.add(ThemeUpdated(theme: BlueDashatarTheme())))
          .called(1);
    });

    testWidgets(
        'renders Scaffold with descendant AnimatedContainer  '
        'using PuzzleTheme.backgroundColor as background color',
        (tester) async {
      const backgroundColor = Colors.orange;
      when(() => theme.backgroundColor).thenReturn(backgroundColor);

      await tester.pumpApp(
        PuzzleView(),
        loginBloc: loginBloc,
        themeBloc: themeBloc,
        settingsBloc: settingsBloc,
        languageControlBloc: languageControlBloc,
        dashatarThemeBloc: dashatarThemeBloc,
        mslideThemeBloc: mslideThemeBloc,
        mswapThemeBloc: mswapThemeBloc,
        audioControlBloc: audioControlBloc,
      );

      expect(
        find.descendant(
          of: find.byType(Scaffold),
          matching: find.byWidgetPredicate(
            (widget) =>
                widget is AnimatedContainer &&
                widget.decoration == BoxDecoration(color: backgroundColor),
          ),
        ),
        findsOneWidget,
      );
    });

    testWidgets(
        'renders puzzle correctly '
        'on a large display', (tester) async {
      tester.setLargeDisplaySize();

      await tester.pumpApp(
        PuzzleView(),
        loginBloc: loginBloc,
        themeBloc: themeBloc,
        settingsBloc: settingsBloc,
        languageControlBloc: languageControlBloc,
        dashatarThemeBloc: dashatarThemeBloc,
        mslideThemeBloc: mslideThemeBloc,
        mswapThemeBloc: mswapThemeBloc,
        audioControlBloc: audioControlBloc,
      );

      expect(find.byKey(Key('puzzle_view_puzzle')), findsOneWidget);
    });

    testWidgets(
        'renders puzzle correctly '
        'on a medium display', (tester) async {
      tester.setMediumDisplaySize();

      await tester.pumpApp(
        PuzzleView(),
        loginBloc: loginBloc,
        themeBloc: themeBloc,
        settingsBloc: settingsBloc,
        languageControlBloc: languageControlBloc,
        dashatarThemeBloc: dashatarThemeBloc,
        mslideThemeBloc: mslideThemeBloc,
        mswapThemeBloc: mswapThemeBloc,
        audioControlBloc: audioControlBloc,
      );

      expect(find.byKey(Key('puzzle_view_puzzle')), findsOneWidget);
    });

    testWidgets(
        'renders puzzle correctly '
        'on a small display', (tester) async {
      tester.setSmallDisplaySize();

      await tester.pumpApp(
        PuzzleView(),
        loginBloc: loginBloc,
        themeBloc: themeBloc,
        settingsBloc: settingsBloc,
        languageControlBloc: languageControlBloc,
        dashatarThemeBloc: dashatarThemeBloc,
        mslideThemeBloc: mslideThemeBloc,
        mswapThemeBloc: mswapThemeBloc,
        audioControlBloc: audioControlBloc,
      );

      expect(find.byKey(Key('puzzle_view_puzzle')), findsOneWidget);
    });

    testWidgets('renders PuzzleHeader', (tester) async {
      await tester.pumpApp(
        PuzzleView(),
        loginBloc: loginBloc,
        themeBloc: themeBloc,
        settingsBloc: settingsBloc,
        languageControlBloc: languageControlBloc,
        dashatarThemeBloc: dashatarThemeBloc,
        mslideThemeBloc: mslideThemeBloc,
        mswapThemeBloc: mswapThemeBloc,
        audioControlBloc: audioControlBloc,
      );

      expect(find.byType(PuzzleHeader), findsOneWidget);
    });

    testWidgets('renders puzzle sections', (tester) async {
      await tester.pumpApp(
        PuzzleView(),
        loginBloc: loginBloc,
        themeBloc: themeBloc,
        settingsBloc: settingsBloc,
        languageControlBloc: languageControlBloc,
        dashatarThemeBloc: dashatarThemeBloc,
        mslideThemeBloc: mslideThemeBloc,
        mswapThemeBloc: mswapThemeBloc,
        audioControlBloc: audioControlBloc,
      );

      expect(find.byType(PuzzleSections), findsOneWidget);
    });

    testWidgets(
        'builds background '
        'with layoutDelegate.backgroundBuilder', (tester) async {
      await tester.pumpApp(
        PuzzleView(),
        loginBloc: loginBloc,
        themeBloc: themeBloc,
        settingsBloc: settingsBloc,
        languageControlBloc: languageControlBloc,
        dashatarThemeBloc: dashatarThemeBloc,
        mslideThemeBloc: mslideThemeBloc,
        mswapThemeBloc: mswapThemeBloc,
        audioControlBloc: audioControlBloc,
      );

      verify(() => layoutDelegate.backgroundBuilder(any())).called(1);
    });

    testWidgets(
        'builds board '
        'with layoutDelegate.boardBuilder', (tester) async {
      await tester.pumpApp(
        PuzzleView(),
        loginBloc: loginBloc,
        themeBloc: themeBloc,
        settingsBloc: settingsBloc,
        languageControlBloc: languageControlBloc,
        dashatarThemeBloc: dashatarThemeBloc,
        mslideThemeBloc: mslideThemeBloc,
        mswapThemeBloc: mswapThemeBloc,
        audioControlBloc: audioControlBloc,
      );

      await tester.pumpAndSettle();

      verify(() => layoutDelegate.boardBuilder(any(), any(), any())).called(1);
    });

    testWidgets(
      'builds 3 tiles '
      'with layoutDelegate.tileBuilder',
      (tester) async {
        when(() => layoutDelegate.boardBuilder(any(), any(), any()))
            .thenAnswer((invocation) {
          final tiles = invocation.positionalArguments[1] as List<Widget>;
          return Row(children: tiles);
        });

        await tester.pumpApp(
          PuzzleView(),
          themeBloc: themeBloc,
          settingsBloc: settingsBloc,
          languageControlBloc: languageControlBloc,
          dashatarThemeBloc: dashatarThemeBloc,
          mslideThemeBloc: mslideThemeBloc,
          mswapThemeBloc: mswapThemeBloc,
          audioControlBloc: audioControlBloc,
        );

        await tester.pumpAndSettle();

        verify(() => layoutDelegate.tileBuilder(any(), any())).called(3);
      },
    );

    testWidgets(
        'builds 1 whitespace tile '
        'with layoutDelegate.whitespaceTileBuilder', (tester) async {
      when(() => layoutDelegate.boardBuilder(any(), any(), any()))
          .thenAnswer((invocation) {
        final tiles = invocation.positionalArguments[1] as List<Widget>;
        return Row(children: tiles);
      });

      await tester.pumpApp(
        PuzzleView(),
        loginBloc: loginBloc,
        themeBloc: themeBloc,
        settingsBloc: settingsBloc,
        languageControlBloc: languageControlBloc,
        dashatarThemeBloc: dashatarThemeBloc,
        mslideThemeBloc: mslideThemeBloc,
        mswapThemeBloc: mswapThemeBloc,
        audioControlBloc: audioControlBloc,
      );

      await tester.pumpAndSettle();

      verify(layoutDelegate.whitespaceTileBuilder).called(1);
    });

    testWidgets(
        'may start a timer '
        'in layoutDelegate', (tester) async {
      when(() => layoutDelegate.startSectionBuilder(any()))
          .thenAnswer((invocation) {
        return Builder(
          builder: (context) {
            return TextButton(
              onPressed: () => context.read<TimerBloc>().add(TimerStarted()),
              key: Key('__start_timer__'),
              child: Text('Start timer'),
            );
          },
        );
      });

      await tester.pumpApp(
        PuzzleView(),
        loginBloc: loginBloc,
        themeBloc: themeBloc,
        settingsBloc: settingsBloc,
        languageControlBloc: languageControlBloc,
        dashatarThemeBloc: dashatarThemeBloc,
        mslideThemeBloc: mslideThemeBloc,
        mswapThemeBloc: mswapThemeBloc,
        audioControlBloc: audioControlBloc,
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key('__start_timer__')));
    });

    group('PuzzleHeader', () {
      testWidgets(
          'renders PuzzleLogo and PuzzleMenu '
          'on a large display', (tester) async {
        tester.setLargeDisplaySize();

        await tester.pumpApp(
          PuzzleHeader(),
          themeBloc: themeBloc,
          settingsBloc: settingsBloc,
          languageControlBloc: languageControlBloc,
          audioControlBloc: audioControlBloc,
        );

        expect(find.byType(PuzzleLogo), findsOneWidget);
        expect(find.byType(PuzzleMenu), findsOneWidget);
      });

      testWidgets(
          'renders PuzzleLogo and PuzzleMenu '
          'on a medium display', (tester) async {
        tester.setMediumDisplaySize();

        await tester.pumpApp(
          PuzzleHeader(),
          themeBloc: themeBloc,
          settingsBloc: settingsBloc,
          languageControlBloc: languageControlBloc,
          audioControlBloc: audioControlBloc,
        );

        expect(find.byType(PuzzleLogo), findsOneWidget);
        expect(find.byType(PuzzleMenu), findsOneWidget);
      });

      testWidgets(
          'renders PuzzleLogo and AudioControl '
          'on a small display', (tester) async {
        tester.setSmallDisplaySize();

        await tester.pumpApp(
          PuzzleHeader(),
          themeBloc: themeBloc,
          settingsBloc: settingsBloc,
          languageControlBloc: languageControlBloc,
          audioControlBloc: audioControlBloc,
        );

        expect(find.byType(PuzzleLogo), findsOneWidget);
        expect(find.byType(PuzzleMenu), findsNothing);
        expect(find.byType(AudioControl), findsOneWidget);
      });
    });

    group('PuzzleSections', () {
      late PuzzleBloc puzzleBloc;

      setUp(() {
        final puzzleState = MockPuzzleState();
        final puzzle = MockPuzzle();
        puzzleBloc = MockPuzzleBloc();

        when(puzzle.getDimension).thenReturn(4);
        when(() => puzzle.tiles).thenReturn([]);
        when(() => puzzle.questions).thenReturn([]);
        when(() => puzzleState.puzzle).thenReturn(puzzle);
        when(() => puzzleState.puzzleStatus).thenReturn(PuzzleStatus.complete);
        when(() => puzzleState.numberOfMoves).thenReturn(19);
        whenListen(
          puzzleBloc,
          Stream.value(puzzleState),
          initialState: puzzleState,
        );
      });

      group('on a large display', () {
        testWidgets(
            'builds start section '
            'with layoutDelegate.startSectionBuilder', (tester) async {
          tester.setLargeDisplaySize();

          await tester.pumpApp(
            PuzzleSections(),
            themeBloc: themeBloc,
            puzzleBloc: puzzleBloc,
            audioControlBloc: audioControlBloc,
            loginBloc: loginBloc,
            settingsBloc: settingsBloc,
            timerBloc: timerBloc,
          );

          verify(() => layoutDelegate.startSectionBuilder(any())).called(1);
        });

        testWidgets(
            'builds end section '
            'with layoutDelegate.endSectionBuilder', (tester) async {
          tester.setLargeDisplaySize();

          await tester.pumpApp(
            PuzzleSections(),
            themeBloc: themeBloc,
            puzzleBloc: puzzleBloc,
            audioControlBloc: audioControlBloc,
            loginBloc: loginBloc,
            settingsBloc: settingsBloc,
            timerBloc: timerBloc,
          );

          verify(() => layoutDelegate.endSectionBuilder(any())).called(1);
        });

        testWidgets('renders PuzzleBoard', (tester) async {
          tester.setLargeDisplaySize();

          await tester.pumpApp(
            PuzzleSections(),
            themeBloc: themeBloc,
            puzzleBloc: puzzleBloc,
            audioControlBloc: audioControlBloc,
            loginBloc: loginBloc,
            settingsBloc: settingsBloc,
            timerBloc: timerBloc,
          );

          expect(find.byType(PuzzleBoard), findsOneWidget);
        });
      });

      group('on a medium display', () {
        testWidgets(
            'builds start section '
            'with layoutDelegate.startSectionBuilder', (tester) async {
          tester.setMediumDisplaySize();

          await tester.pumpApp(
            PuzzleSections(),
            themeBloc: themeBloc,
            puzzleBloc: puzzleBloc,
            audioControlBloc: audioControlBloc,
            settingsBloc: settingsBloc,
            loginBloc: loginBloc,
            timerBloc: timerBloc,
          );

          verify(() => layoutDelegate.startSectionBuilder(any())).called(1);
        });

        testWidgets(
            'builds end section '
            'with layoutDelegate.endSectionBuilder', (tester) async {
          tester.setMediumDisplaySize();

          await tester.pumpApp(
            PuzzleSections(),
            themeBloc: themeBloc,
            puzzleBloc: puzzleBloc,
            audioControlBloc: audioControlBloc,
            settingsBloc: settingsBloc,
            loginBloc: loginBloc,
            timerBloc: timerBloc,
          );

          verify(() => layoutDelegate.endSectionBuilder(any())).called(1);
        });

        testWidgets('renders PuzzleBoard', (tester) async {
          tester.setMediumDisplaySize();

          await tester.pumpApp(
            PuzzleSections(),
            themeBloc: themeBloc,
            puzzleBloc: puzzleBloc,
            audioControlBloc: audioControlBloc,
            settingsBloc: settingsBloc,
            timerBloc: timerBloc,
            loginBloc: loginBloc,
          );

          expect(find.byType(PuzzleBoard), findsOneWidget);
        });
      });

      group('on a small display', () {
        testWidgets(
            'builds start section '
            'with layoutDelegate.startSectionBuilder', (tester) async {
          tester.setSmallDisplaySize();

          await tester.pumpApp(
            PuzzleSections(),
            themeBloc: themeBloc,
            settingsBloc: settingsBloc,
            languageControlBloc: languageControlBloc,
            puzzleBloc: puzzleBloc,
            audioControlBloc: audioControlBloc,
            timerBloc: timerBloc,
            loginBloc: loginBloc,
          );

          verify(() => layoutDelegate.startSectionBuilder(any())).called(1);
        });

        testWidgets(
            'builds end section '
            'with layoutDelegate.endSectionBuilder', (tester) async {
          tester.setSmallDisplaySize();

          await tester.pumpApp(
            PuzzleSections(),
            themeBloc: themeBloc,
            settingsBloc: settingsBloc,
            languageControlBloc: languageControlBloc,
            puzzleBloc: puzzleBloc,
            audioControlBloc: audioControlBloc,
            timerBloc: timerBloc,
            loginBloc: loginBloc,
          );

          verify(() => layoutDelegate.endSectionBuilder(any())).called(1);
        });

        testWidgets('renders PuzzleMenu', (tester) async {
          tester.setSmallDisplaySize();

          await tester.pumpApp(
            PuzzleSections(),
            themeBloc: themeBloc,
            settingsBloc: settingsBloc,
            languageControlBloc: languageControlBloc,
            puzzleBloc: puzzleBloc,
            audioControlBloc: audioControlBloc,
            timerBloc: timerBloc,
            loginBloc: loginBloc,
          );

          expect(find.byType(PuzzleMenu), findsOneWidget);
        });

        testWidgets('renders PuzzleBoard', (tester) async {
          tester.setSmallDisplaySize();

          await tester.pumpApp(
            PuzzleSections(),
            themeBloc: themeBloc,
            settingsBloc: settingsBloc,
            languageControlBloc: languageControlBloc,
            puzzleBloc: puzzleBloc,
            audioControlBloc: audioControlBloc,
            timerBloc: timerBloc,
            loginBloc: loginBloc,
          );

          expect(find.byType(PuzzleBoard), findsOneWidget);
        });
      });
    });

    group('PuzzleBoard', () {
      late PuzzleBloc puzzleBloc;

      setUp(() {
        puzzleBloc = MockPuzzleBloc();
        final puzzleState = MockPuzzleState();
        final puzzle = MockPuzzle();

        when(puzzle.getDimension).thenReturn(4);
        when(() => puzzle.tiles).thenReturn([]);
        when(() => puzzle.questions).thenReturn([]);
        when(() => puzzleState.puzzle).thenReturn(puzzle);
        when(() => puzzleState.puzzleStatus).thenReturn(PuzzleStatus.complete);
        when(() => puzzleState.numberOfMoves).thenReturn(19);
        whenListen(
          puzzleBloc,
          Stream.value(puzzleState),
          initialState: puzzleState,
        );
      });

      testWidgets(
          'adds TimerStopped to TimerBloc '
          'when the puzzle completes', (tester) async {
        final timerBloc = MockTimerBloc();
        final timerState = MockTimerState();

        const secondsElapsed = 60;
        when(() => timerState.secondsElapsed).thenReturn(secondsElapsed);
        when(() => timerBloc.state).thenReturn(timerState);

        await tester.pumpApp(
          PuzzleBoard(),
          themeBloc: themeBloc,
          settingsBloc: settingsBloc,
          languageControlBloc: languageControlBloc,
          dashatarThemeBloc: dashatarThemeBloc,
          mslideThemeBloc: mslideThemeBloc,
          audioControlBloc: audioControlBloc,
          timerBloc: timerBloc,
          puzzleBloc: puzzleBloc,
          loginBloc: loginBloc
        );

        verify(() => timerBloc.add(TimerStopped())).called(1);
      });

      testWidgets('renders PuzzleKeyboardHandler', (tester) async {
        await tester.pumpApp(
          PuzzleBoard(),
          themeBloc: themeBloc,
          settingsBloc: settingsBloc,
          languageControlBloc: languageControlBloc,
          puzzleBloc: puzzleBloc,
          audioControlBloc: audioControlBloc,
          timerBloc: timerBloc,
          loginBloc: loginBloc,
        );

        expect(find.byType(PuzzleKeyboardHandler), findsOneWidget);
      });
    });

    group('PuzzleMenu', () {
      testWidgets(
          'renders PuzzleMenuItem '
          'for each theme in ThemeState', (tester) async {
        final themes = [SimpleTheme(), GreenDashatarTheme()];
        final themeState = ThemeState(themes: themes, theme: themes[1]);
        when(() => themeBloc.state).thenReturn(themeState);

        await tester.pumpApp(
          PuzzleMenu(),
          themeBloc: themeBloc,
          settingsBloc: settingsBloc,
          languageControlBloc: languageControlBloc,
          audioControlBloc: audioControlBloc,
        );

        expect(find.byType(PuzzleMenuItem), findsNWidgets(themes.length));

        for (final theme in themes) {
          expect(
            find.byWidgetPredicate(
              (widget) => widget is PuzzleMenuItem && widget.theme == theme,
            ),
            findsOneWidget,
          );
        }
      });

      testWidgets('renders AudioControl on a large display', (tester) async {
        tester.setLargeDisplaySize();

        await tester.pumpApp(
          PuzzleMenu(),
          themeBloc: themeBloc,
          settingsBloc: settingsBloc,
          languageControlBloc: languageControlBloc,
          audioControlBloc: audioControlBloc,
        );

        expect(find.byType(AudioControl), findsOneWidget);
      });

      testWidgets('renders AudioControl on a medium display', (tester) async {
        tester.setMediumDisplaySize();

        await tester.pumpApp(
          PuzzleMenu(),
          themeBloc: themeBloc,
          settingsBloc: settingsBloc,
          languageControlBloc: languageControlBloc,
          audioControlBloc: audioControlBloc,
        );

        expect(find.byType(AudioControl), findsOneWidget);
      });
    });

    group('PuzzleMenuItem', () {
      late PuzzleTheme tappedTheme;
      late List<PuzzleTheme> themes;
      late ThemeState themeState;

      setUp(() {
        tappedTheme = GreenDashatarTheme();
        themes = [SimpleTheme(), tappedTheme];
        themeState = ThemeState(themes: themes, theme: SimpleTheme());

        when(() => themeBloc.state).thenReturn(themeState);
      });

      group('when tapped', () {
        testWidgets('adds ThemeChanged to ThemeBloc', (tester) async {
          await tester.pumpApp(
            PuzzleMenuItem(
              theme: tappedTheme,
              themeIndex: themes.indexOf(tappedTheme),
            ),
            themeBloc: themeBloc,
            settingsBloc: settingsBloc,
            languageControlBloc: languageControlBloc,
          );

          await tester.tap(find.byType(PuzzleMenuItem));

          verify(() => themeBloc.add(ThemeChanged(themeIndex: 1))).called(1);
        });

        testWidgets('adds TimerReset to TimerBloc', (tester) async {
          final timerBloc = MockTimerBloc();

          await tester.pumpApp(
            PuzzleMenuItem(
              theme: tappedTheme,
              themeIndex: themes.indexOf(tappedTheme),
            ),
            themeBloc: themeBloc,
            settingsBloc: settingsBloc,
            languageControlBloc: languageControlBloc,
            timerBloc: timerBloc,
          );

          await tester.tap(find.byType(PuzzleMenuItem));

          verify(() => timerBloc.add(TimerReset())).called(1);
        });

        testWidgets('adds DashatarCountdownStopped to DashatarPuzzleBloc',
            (tester) async {
          final dashatarPuzzleBloc = MockDashatarPuzzleBloc();

          await tester.pumpApp(
            PuzzleMenuItem(
              theme: tappedTheme,
              themeIndex: themes.indexOf(tappedTheme),
            ),
            themeBloc: themeBloc,
            settingsBloc: settingsBloc,
            languageControlBloc: languageControlBloc,
            dashatarPuzzleBloc: dashatarPuzzleBloc,
          );

          await tester.tap(find.byType(PuzzleMenuItem));

          verify(() => dashatarPuzzleBloc.add(DashatarCountdownStopped()))
              .called(1);
        });

        testWidgets(
            'adds PuzzleInitialized to PuzzleBloc '
            'with shufflePuzzle equal to true '
            'if theme is SimpleTheme', (tester) async {
          final puzzleBloc = MockPuzzleBloc();

          when(() => themeBloc.state).thenReturn(
            ThemeState(
              themes: themes,
              theme: GreenDashatarTheme(),
            ),
          );

          await tester.pumpApp(
            PuzzleMenuItem(
              theme: SimpleTheme(),
              themeIndex: themes.indexOf(SimpleTheme()),
            ),
            themeBloc: themeBloc,
            settingsBloc: settingsBloc,
            languageControlBloc: languageControlBloc,
            puzzleBloc: puzzleBloc,
          );

          await tester.tap(find.byType(PuzzleMenuItem));

          verify(
            () => puzzleBloc.add(
              PuzzleInitialized(settings: settingsState.settings),
            ),
          ).called(1);
        });

        testWidgets(
            'adds PuzzleInitialized to PuzzleBloc '
            'with shufflePuzzle equal to false '
            'if current theme is not SimpleTheme', (tester) async {
          final puzzleBloc = MockPuzzleBloc();

          when(() => themeBloc.state).thenReturn(
            ThemeState(
              themes: themes,
              theme: SimpleTheme(),
            ),
          );

          await tester.pumpApp(
            PuzzleMenuItem(
              theme: GreenDashatarTheme(),
              themeIndex: themes.indexOf(GreenDashatarTheme()),
            ),
            themeBloc: themeBloc,
            settingsBloc: settingsBloc,
            languageControlBloc: languageControlBloc,
            puzzleBloc: puzzleBloc,
          );

          await tester.tap(find.byType(PuzzleMenuItem));

          verify(() => puzzleBloc.add(
              PuzzleInitialized(settings: settingsState.settings))).called(1);
        });
      });

      testWidgets('renders Tooltip', (tester) async {
        await tester.pumpApp(
          PuzzleMenuItem(
            theme: tappedTheme,
            themeIndex: themes.indexOf(tappedTheme),
          ),
          themeBloc: themeBloc,
          settingsBloc: settingsBloc,
        );

        expect(find.byType(Tooltip), findsOneWidget);
      });

      testWidgets('renders theme name', (tester) async {
        await tester.pumpApp(
          PuzzleMenuItem(
            theme: tappedTheme,
            themeIndex: themes.indexOf(tappedTheme),
          ),
          themeBloc: themeBloc,
          settingsBloc: settingsBloc,
        );

        expect(find.text(tappedTheme.name), findsOneWidget);
      });
    });
  });
}
