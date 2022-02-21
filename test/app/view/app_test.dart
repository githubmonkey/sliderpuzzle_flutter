// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';

import 'package:auth_repository/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_repository/history_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_slide_puzzle/app/app.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';

import '../../helpers/helpers.dart';

void main() {
  late AuthRepository authRepository;
  late HistoryRepository historyRepository;

  setUp(() {
    authRepository = MockAuthRepository();
    historyRepository = MockHistoryRepository();
    when(() => authRepository.user).thenAnswer((_) => const Stream.empty());
    when(() => authRepository.currentUser).thenAnswer((_) => User.empty);
    when(() => historyRepository.getHistory())
        .thenAnswer((_) => const Stream<List<Leader>>.empty());
    final leader = Leader(
      userid: 'user 1',
      settings: 'settings',
      time: 25,
      moves: 5,
      timestamp: DateTime.fromMillisecondsSinceEpoch(12345),
    );
    when(() => firestoreRepository.saveLeader(leader)).thenAnswer((_) async {});
  });

  group('App', () {
    testWidgets(
        'renders PuzzlePage '
        'when the platform is Web', (tester) async {
      final platformHelper = MockPlatformHelper();
      when(() => platformHelper.isWeb).thenReturn(true);

      await tester.pumpWidget(
        App(
          platformHelperFactory: () => platformHelper,
          authRepository: authRepository,
          firestoreRepository: firestoreRepository,
        ),
      );

      await tester.pump(const Duration(milliseconds: 20));

      expect(find.byType(PuzzlePage), findsOneWidget);
    });

    testWidgets(
        'throws UnimplementedError '
        'when the platform is not Web', (tester) async {
      Object? caughtError;
      await runZonedGuarded(() async {
        final platformHelper = MockPlatformHelper();
        when(() => platformHelper.isWeb).thenReturn(false);

        await tester.pumpWidget(
          App(
            platformHelperFactory: () => platformHelper,
            authRepository: authRepository,
            firestoreRepository: firestoreRepository,
          ),
        );

        await tester.pump(const Duration(seconds: 1));
      }, (error, stack) {
        caughtError = error;
      });

      expect(caughtError, isUnimplementedError);
    });
  });
}
