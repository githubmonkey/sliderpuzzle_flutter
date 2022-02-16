// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:leaders_api/leaders_api.dart';
import 'package:local_leaders_api/local_leaders_api.dart';
import 'package:mocktail/mocktail.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('LocalLeadersApi', () {
    late SharedPreferences plugin;

    final leaders = [
      Leader(
        id: '1',
        userid: 'user 1',
        settings: 'settings',
        time: 0,
        moves: 0,
      ),
      Leader(
        id: '2',
        userid: 'user 2',
        settings: 'settings',
        time: 0,
        moves: 0,
      ),
      Leader(
        id: '3',
        userid: 'user 3',
        nickname: 'nickname',
        settings: 'settings',
        time: 100,
        moves: 25,
      ),
    ];

    setUp(() {
      plugin = MockSharedPreferences();
      when(() => plugin.getString(any())).thenReturn(json.encode(leaders));
      when(() => plugin.setString(any(), any())).thenAnswer((_) async => true);
    });

    LocalLeadersApi createSubject() {
      return LocalLeadersApi(
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

      group('initializes the leaders stream', () {
        test('with existing leaders if present', () {
          final subject = createSubject();

          expect(subject.getLeaders(), emits(leaders));
          verify(
            () => plugin.getString(
              LocalLeadersApi.kLeadersCollectionKey,
            ),
          ).called(1);
        });

        test('with empty list if no leaders present', () {
          when(() => plugin.getString(any())).thenReturn(null);

          final subject = createSubject();

          expect(subject.getLeaders(), emits(const <Leader>[]));
          verify(
            () => plugin.getString(
              LocalLeadersApi.kLeadersCollectionKey,
            ),
          ).called(1);
        });
      });
    });

    test('getLeaders returns stream of current list leaders', () {
      expect(
        createSubject().getLeaders(),
        emits(leaders),
      );
    });

    group('saveLeader', () {
      test('saves new leaders', () {
        final newLeader = Leader(
          id: '4',
          userid: 'user 3',
          settings: 'settings',
          time: 100,
          moves: 5,
        );

        final newLeaders = [...leaders, newLeader];

        final subject = createSubject();

        expect(subject.saveLeader(newLeader), completes);
        expect(subject.getLeaders(), emits(newLeaders));

        verify(
          () => plugin.setString(
            LocalLeadersApi.kLeadersCollectionKey,
            json.encode(newLeaders),
          ),
        ).called(1);
      });

      test('updates existing leaders', () {
        final updatedLeader = Leader(
          id: '1',
          userid: 'new user',
          settings: 'new settings',
          time: 1,
          moves: 2,
        );
        final newLeaders = [updatedLeader, ...leaders.sublist(1)];

        final subject = createSubject();

        expect(subject.saveLeader(updatedLeader), completes);
        expect(subject.getLeaders(), emits(newLeaders));

        verify(
          () => plugin.setString(
            LocalLeadersApi.kLeadersCollectionKey,
            json.encode(newLeaders),
          ),
        ).called(1);
      });
    });
  });
}
