// ignore_for_file: avoid_redundant_argument_values
import 'package:leaders_api/leaders_api.dart';
import 'package:leaders_api/src/models/models.dart';
import 'package:test/test.dart';

void main() {
  group('Leader', () {
    // DateTime.fromMillisecondsSinceEpoch(12345);
    // 1970-01-01 02:00:12.345  // print(d);
    // 970-01-01T02:00:12.345  // print(d.toIso8601String());
    const settings = Settings(
      theme: 'swap',
      boardSize: 4,
      game: Game.noop,
      elevenToTwenty: true,
    );

    Leader createSubject({
      String? id = '1',
      String userid = 'user 1',
      String nickname = 'nickname',
      Settings settings = settings,
      int time = 100,
      int moves = 25,
      DateTime? timestamp,
    }) {
      return Leader(
        id: id,
        userid: userid,
        settings: settings,
        nickname: nickname,
        time: time,
        moves: moves,
        timestamp: timestamp ?? DateTime.fromMillisecondsSinceEpoch(12345),
      );
    }

    group('constructor', () {
      test('works correctly', () {
        expect(
          createSubject,
          returnsNormally,
        );
      });

      test('throws AssertionError when id is empty', () {
        expect(
          () => createSubject(id: ''),
          throwsA(isA<AssertionError>()),
        );
      });

      test('sets id if not provided', () {
        expect(
          createSubject(id: null).id,
          isNotEmpty,
        );
      });
    });

    test('supports value equality', () {
      expect(
        createSubject(),
        equals(createSubject()),
      );
    });

    test('props are correct', () {
      expect(
        createSubject().props,
        equals([
          '1', // id
          'user 1', // userid
          'nickname', // nickname
          settings, // settings
          100, // time
          25, // moves
          DateTime.fromMillisecondsSinceEpoch(12345),
        ]),
      );
    });

    group('copyWith', () {
      test('returns the same object if not arguments are provided', () {
        expect(
          createSubject().copyWith(),
          equals(createSubject()),
        );
      });

      test('retains the old value for every parameter if null is provided', () {
        expect(
          createSubject().copyWith(
            id: null,
            userid: null,
            nickname: null,
            settings: null,
            time: null,
            moves: null,
          ),
          equals(createSubject()),
        );
      });

      test('replaces every non-null parameter', () {
        const newsettings = Settings(
          theme: 'new theme',
          boardSize: 3,
          game: Game.roman,
          elevenToTwenty: false,
        );
        expect(
          createSubject().copyWith(
            id: '2',
            userid: 'new user',
            nickname: 'new nickname',
            settings: newsettings,
            time: 200,
            moves: 50,
          ),
          equals(
            createSubject(
              id: '2',
              userid: 'new user',
              nickname: 'new nickname',
              settings: newsettings,
              time: 200,
              moves: 50,
            ),
          ),
        );
      });
    });

    group('fromJson', () {
      test('works correctly', () {
        expect(
          Leader.fromJson(<String, dynamic>{
            'id': '1',
            'userid': 'user 1',
            'nickname': 'nickname',
            'settings': {
              'theme': 'swap',
              'boardSize': 4,
              'game': 'noop',
              'elevenToTwenty': true,
            },
            'time': 100,
            'moves': 25,
            'timestamp':
                DateTime.fromMillisecondsSinceEpoch(12345).toIso8601String(),
          }),
          equals(createSubject()),
        );
      });
    });

    group('toJson', () {
      test('works correctly', () {
        expect(
          createSubject().toJson(),
          equals(<String, dynamic>{
            'id': '1',
            'userid': 'user 1',
            'nickname': 'nickname',
            'settings': {
              'theme': 'swap',
              'boardSize': 4,
              'game': 'noop',
              'elevenToTwenty': true,
            },
            'time': 100,
            'moves': 25,
            'timestamp':
                DateTime.fromMillisecondsSinceEpoch(12345).toIso8601String(),
          }),
        );
      });
    });
  });
}
