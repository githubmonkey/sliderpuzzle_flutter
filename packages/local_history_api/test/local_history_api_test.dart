// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:leaders_api/leaders_api.dart';
import 'package:local_history_api/local_history_api.dart';
import 'package:mocktail/mocktail.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('LocalLeadersApi', () {
    late SharedPreferences plugin;

    const settings = Settings(
      boardSize: 4,
      game: Game.noop,
      elevenToTwenty: true,
    );
    const result = Result(time: 0, moves: 0);

    final leaders = [
      Leader(
        id: '1',
        userid: 'user 1',
        theme: 'theme',
        settings: settings,
        result: result,
        timestamp: DateTime.fromMillisecondsSinceEpoch(12345),
      ),
      Leader(
        id: '2',
        userid: 'user 2',
        theme: 'theme',
        settings: settings,
        result: result,
        timestamp: DateTime.fromMillisecondsSinceEpoch(12345),
      ),
      Leader(
        id: '3',
        userid: 'user 3',
        nickname: 'nickname',
        theme: 'theme',
        settings: settings,
        result: result,
        timestamp: DateTime.fromMillisecondsSinceEpoch(12345),
      ),
    ];

    setUp(() {
      plugin = MockSharedPreferences();
      when(() => plugin.getString(any())).thenReturn(json.encode(leaders));
      when(() => plugin.setString(any(), any())).thenAnswer((_) async => true);
    });

    LocalHistoryApi createSubject() {
      return LocalHistoryApi(
        plugin: plugin,
      );
    }

    group('constructor', () {
      test('works properly', () {
        expect(
          createSubject,
          returnsNormally,
        );
      });

      group('initializes the history stream', () {
        test('with existing history if present', () {
          final subject = createSubject();

          expect(subject.getHistory(), emits(leaders));
          verify(
            () => plugin.getString(
              LocalHistoryApi.kHistoryCollectionKey,
            ),
          ).called(1);
        });

        test('with empty list if no history present', () {
          when(() => plugin.getString(any())).thenReturn(null);

          final subject = createSubject();

          expect(subject.getHistory(), emits(const <Leader>[]));
          verify(
            () => plugin.getString(
              LocalHistoryApi.kHistoryCollectionKey,
            ),
          ).called(1);
        });
      });
    });

    test('getHistory returns stream of current list history', () {
      expect(
        createSubject().getHistory(),
        emits(leaders),
      );
    });

    group('saveLeader', () {
      test('saves new history', () {
        final newLeader = Leader(
          id: '4',
          userid: 'user 3',
          theme: 'theme',
          settings: settings,
          result: result,
          timestamp: DateTime.fromMillisecondsSinceEpoch(12345),
        );

        final newLeaders = [...leaders, newLeader];

        final subject = createSubject();

        expect(subject.saveHistory(newLeader), completes);
        expect(subject.getHistory(), emits(newLeaders));

        verify(
          () => plugin.setString(
            LocalHistoryApi.kHistoryCollectionKey,
            json.encode(newLeaders),
          ),
        ).called(1);
      });

      test('updates existing history', () {
        final updatedLeader = Leader(
          id: '1',
          userid: 'new user',
          theme: 'theme',
          settings: settings,
          result: result,
          timestamp: DateTime.fromMillisecondsSinceEpoch(12345),
        );
        final newLeaders = [updatedLeader, ...leaders.sublist(1)];

        final subject = createSubject();

        expect(subject.saveHistory(updatedLeader), completes);
        expect(subject.getHistory(), emits(newLeaders));

        verify(
          () => plugin.setString(
            LocalHistoryApi.kHistoryCollectionKey,
            json.encode(newLeaders),
          ),
        ).called(1);
      });
    });
  });
}
