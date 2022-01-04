// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/simple/simple.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/timer/timer.dart';

import '../../helpers/helpers.dart';

void main() {
  group('PuzzlePage', () {
    testWidgets('renders PuzzleView', (tester) async {
      await tester.pumpApp(PuzzlePage());
      expect(find.byType(PuzzleView), findsOneWidget);
    });

    testWidgets('provides all Dashatar themes to PuzzleView', (tester) async {
      await tester.pumpApp(PuzzlePage());

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

    testWidgets('provides correct initial themes to PuzzleView',
        (tester) async {
      await tester.pumpApp(PuzzlePage());

      final BuildContext puzzleViewContext =
          tester.element(find.byType(PuzzleView));

      final initialThemes = puzzleViewContext.read<ThemeBloc>().state.themes;

      expect(
        initialThemes,
        equals([
          SimpleTheme(),
          GreenDashatarTheme(),
        ]),
      );
    });
  });

  group('PuzzleView', () {
    late ThemeBloc themeBloc;
    late PuzzleTheme theme;
    late DashatarThemeBloc dashatarThemeBloc;
    late PuzzleLayoutDelegate layoutDelegate;

    setUp(() {
      theme = MockPuzzleTheme();
      final themeState = ThemeState(themes: [theme], theme: theme);
      themeBloc = MockThemeBloc();
      layoutDelegate = MockPuzzleLayoutDelegate();

      when(() => layoutDelegate.startSectionBuilder(any()))
          .thenReturn(SizedBox());

      when(() => layoutDelegate.endSectionBuilder(any()))
          .thenReturn(SizedBox());

      when(() => layoutDelegate.backgroundBuilder(any()))
          .thenReturn(SizedBox());

      when(() => layoutDelegate.boardBuilder(any(), any()))
          .thenReturn(SizedBox());

      when(() => layoutDelegate.tileBuilder(any(), any()))
          .thenReturn(SizedBox());

      when(layoutDelegate.whitespaceTileBuilder).thenReturn(SizedBox());

      when(() => theme.layoutDelegate).thenReturn(layoutDelegate);
      when(() => theme.backgroundColor).thenReturn(Colors.black);
      when(() => theme.logoColor).thenReturn(Colors.black);
      when(() => theme.menuActiveColor).thenReturn(Colors.black);
      when(() => theme.menuUnderlineColor).thenReturn(Colors.black);
      when(() => theme.menuInactiveColor).thenReturn(Colors.black);
      when(() => theme.hasTimer).thenReturn(true);
      when(() => theme.name).thenReturn('Name');
      when(() => themeBloc.state).thenReturn(themeState);

      dashatarThemeBloc = MockDashatarThemeBloc();
      when(() => dashatarThemeBloc.state)
          .thenReturn(DashatarThemeState(themes: [GreenDashatarTheme()]));
    });

    setUpAll(() {
      registerFallbackValue(MockPuzzleState());
      registerFallbackValue(MockTile());
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
        themeBloc: themeBloc,
        dashatarThemeBloc: dashatarThemeBloc,
      );

      verify(() => themeBloc.add(ThemeUpdated(theme: GreenDashatarTheme())))
          .called(1);

      verify(() => themeBloc.add(ThemeUpdated(theme: BlueDashatarTheme())))
          .called(1);
    });

    testWidgets(
        'renders Scaffold with descendant AnimatedContainer  '
        'having background color from theme', (tester) async {
      const backgroundColor = Colors.orange;
      when(() => theme.backgroundColor).thenReturn(backgroundColor);

      await tester.pumpApp(
        PuzzleView(),
        themeBloc: themeBloc,
        dashatarThemeBloc: dashatarThemeBloc,
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
        themeBloc: themeBloc,
        dashatarThemeBloc: dashatarThemeBloc,
      );

      expect(find.byKey(Key('puzzle_view_puzzle')), findsOneWidget);
    });

    testWidgets(
        'renders puzzle correctly '
        'on a medium display', (tester) async {
      tester.setMediumDisplaySize();

      await tester.pumpApp(
        PuzzleView(),
        themeBloc: themeBloc,
        dashatarThemeBloc: dashatarThemeBloc,
      );

      expect(find.byKey(Key('puzzle_view_puzzle')), findsOneWidget);
    });

    testWidgets(
        'renders puzzle correctly '
        'on a small display', (tester) async {
      tester.setSmallDisplaySize();

      await tester.pumpApp(
        PuzzleView(),
        themeBloc: themeBloc,
        dashatarThemeBloc: dashatarThemeBloc,
      );

      expect(find.byKey(Key('puzzle_view_puzzle')), findsOneWidget);
    });

    testWidgets('renders PuzzleHeader', (tester) async {
      await tester.pumpApp(
        PuzzleView(),
        themeBloc: themeBloc,
        dashatarThemeBloc: dashatarThemeBloc,
      );

      expect(find.byType(PuzzleHeader), findsOneWidget);
    });

    testWidgets('renders puzzle sections', (tester) async {
      await tester.pumpApp(
        PuzzleView(),
        themeBloc: themeBloc,
        dashatarThemeBloc: dashatarThemeBloc,
      );

      expect(find.byType(PuzzleSections), findsOneWidget);
    });

    testWidgets(
        'builds background '
        'with layoutDelegate.backgroundBuilder', (tester) async {
      await tester.pumpApp(
        PuzzleView(),
        themeBloc: themeBloc,
        dashatarThemeBloc: dashatarThemeBloc,
      );

      verify(() => layoutDelegate.backgroundBuilder(any())).called(1);
    });

    testWidgets(
        'builds board '
        'with layoutDelegate.boardBuilder', (tester) async {
      await tester.pumpApp(
        PuzzleView(),
        themeBloc: themeBloc,
        dashatarThemeBloc: dashatarThemeBloc,
      );

      await tester.pumpAndSettle();

      verify(() => layoutDelegate.boardBuilder(any(), any())).called(1);
    });

    testWidgets(
        'builds 15 tiles '
        'with layoutDelegate.tileBuilder', (tester) async {
      when(() => layoutDelegate.boardBuilder(any(), any()))
          .thenAnswer((invocation) {
        final tiles = invocation.positionalArguments[1] as List<Widget>;
        return Row(children: tiles);
      });

      await tester.pumpApp(
        PuzzleView(),
        themeBloc: themeBloc,
        dashatarThemeBloc: dashatarThemeBloc,
      );

      await tester.pumpAndSettle();

      verify(() => layoutDelegate.tileBuilder(any(), any())).called(15);
    });

    testWidgets(
        'builds 1 whitespace tile '
        'with layoutDelegate.whitespaceTileBuilder', (tester) async {
      when(() => layoutDelegate.boardBuilder(any(), any()))
          .thenAnswer((invocation) {
        final tiles = invocation.positionalArguments[1] as List<Widget>;
        return Row(children: tiles);
      });

      await tester.pumpApp(
        PuzzleView(),
        themeBloc: themeBloc,
        dashatarThemeBloc: dashatarThemeBloc,
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
        themeBloc: themeBloc,
        dashatarThemeBloc: dashatarThemeBloc,
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
        );

        expect(find.byType(PuzzleLogo), findsOneWidget);
        expect(find.byType(PuzzleMenu), findsOneWidget);
      });

      testWidgets(
          'renders PuzzleLogo '
          'on a small display', (tester) async {
        tester.setSmallDisplaySize();

        await tester.pumpApp(
          PuzzleHeader(),
          themeBloc: themeBloc,
        );

        expect(find.byType(PuzzleLogo), findsOneWidget);
        expect(find.byType(PuzzleMenu), findsNothing);
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
        when(() => puzzleState.puzzle).thenReturn(puzzle);
        when(() => puzzleState.puzzleStatus).thenReturn(PuzzleStatus.complete);
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
          );

          verify(() => layoutDelegate.endSectionBuilder(any())).called(1);
        });

        testWidgets('renders PuzzleBoard', (tester) async {
          tester.setLargeDisplaySize();

          await tester.pumpApp(
            PuzzleSections(),
            themeBloc: themeBloc,
            puzzleBloc: puzzleBloc,
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
          );

          verify(() => layoutDelegate.endSectionBuilder(any())).called(1);
        });

        testWidgets('renders PuzzleBoard', (tester) async {
          tester.setMediumDisplaySize();

          await tester.pumpApp(
            PuzzleSections(),
            themeBloc: themeBloc,
            puzzleBloc: puzzleBloc,
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
            puzzleBloc: puzzleBloc,
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
            puzzleBloc: puzzleBloc,
          );

          verify(() => layoutDelegate.endSectionBuilder(any())).called(1);
        });

        testWidgets('renders PuzzleMenu', (tester) async {
          tester.setSmallDisplaySize();

          await tester.pumpApp(
            PuzzleSections(),
            themeBloc: themeBloc,
            puzzleBloc: puzzleBloc,
          );

          expect(find.byType(PuzzleMenu), findsOneWidget);
        });

        testWidgets('renders PuzzleBoard', (tester) async {
          tester.setSmallDisplaySize();

          await tester.pumpApp(
            PuzzleSections(),
            themeBloc: themeBloc,
            puzzleBloc: puzzleBloc,
          );

          expect(find.byType(PuzzleBoard), findsOneWidget);
        });
      });
    });

    group('PuzzleBoard', () {
      testWidgets(
          'adds TimerStopped to TimerBloc '
          'when the puzzle completes', (tester) async {
        final timerBloc = MockTimerBloc();
        final timerState = MockTimerState();
        final puzzleBloc = MockPuzzleBloc();
        final puzzleState = MockPuzzleState();
        final puzzle = MockPuzzle();

        when(puzzle.getDimension).thenReturn(4);
        when(() => puzzle.tiles).thenReturn([]);
        when(() => puzzleState.puzzle).thenReturn(puzzle);
        when(() => puzzleState.puzzleStatus).thenReturn(PuzzleStatus.complete);
        whenListen(
          puzzleBloc,
          Stream.value(puzzleState),
          initialState: puzzleState,
        );

        const secondsElapsed = 60;
        when(() => timerState.secondsElapsed).thenReturn(secondsElapsed);
        when(() => timerBloc.state).thenReturn(timerState);

        await tester.pumpApp(
          PuzzleBoard(),
          themeBloc: themeBloc,
          dashatarThemeBloc: dashatarThemeBloc,
          timerBloc: timerBloc,
          puzzleBloc: puzzleBloc,
        );

        verify(() => timerBloc.add(TimerStopped())).called(1);
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
    });

    group('PuzzleMenuItem', () {
      testWidgets(
          'adds ThemeChanged to ThemeBloc '
          'on pressed', (tester) async {
        final theme = GreenDashatarTheme();
        final themes = [SimpleTheme(), theme];
        final themeState = ThemeState(themes: themes, theme: theme);

        when(() => themeBloc.state).thenReturn(themeState);

        await tester.pumpApp(
          PuzzleMenuItem(
            theme: theme,
            themeIndex: 1,
          ),
          themeBloc: themeBloc,
        );

        await tester.tap(find.byType(PuzzleMenuItem));

        verify(() => themeBloc.add(ThemeChanged(themeIndex: 1))).called(1);
      });
    });
  });
}