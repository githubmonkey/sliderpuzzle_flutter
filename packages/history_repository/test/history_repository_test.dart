// ignore_for_file: prefer_const_constructors
import 'package:leaders_api/leaders_api.dart';
import 'package:history_repository/history_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockLeadersApi extends Mock implements LeadersApi {}

class FakeLeader extends Fake implements Leader {}

void main() {
  group('LeadersRepository', () {
    late LeadersApi api;

    const settings = Settings(
      boardSize: 4,
      game: Game.noop,
      elevenToTwenty: true,
    );

    final leaders = [
      Leader(
        id: '1',
        userid: 'user 1',
        theme: 'theme',
        settings: settings,
        time: 0,
        moves: 0,
        timestamp: DateTime.fromMillisecondsSinceEpoch(12345),
      ),
      Leader(
        id: '2',
        userid: 'user 2',
        theme: 'theme',
        settings: settings,
        time: 0,
        moves: 0,
        timestamp: DateTime.fromMillisecondsSinceEpoch(12345),
      ),
      Leader(
        id: '3',
        userid: 'user 3',
        nickname: 'nickname',
        theme: 'theme',
        settings: settings,
        time: 100,
        moves: 25,
        timestamp: DateTime.fromMillisecondsSinceEpoch(12345),
      ),
      Leader(
        id: '4',
        userid: 'user 3',
        theme: 'theme',
        settings: settings,
        time: 100,
        moves: 5,
        timestamp: DateTime.fromMillisecondsSinceEpoch(12345),
      ),
    ];

    setUpAll(() {
      registerFallbackValue(FakeLeader());
    });

    setUp(() {
      api = MockLeadersApi();
      when(() => api.getHistory()).thenAnswer((_) => Stream.value(leaders));
      when(() => api.saveHistory(any())).thenAnswer((_) async {});
    });

    HistoryRepository createSubject() => HistoryRepository(leadersApi: api);

    group('constructor', () {
      test('works properly', () {
        expect(
          createSubject,
          returnsNormally,
        );
      });
    });

    group('getLeaders', () {
      test('makes correct api request', () {
        final subject = createSubject();

        expect(
          subject.getHistory(),
          isNot(throwsA(anything)),
        );

        verify(() => api.getHistory()).called(1);
      });

      test('returns stream of current list leaders', () {
        expect(
          createSubject().getHistory(),
          emits(leaders),
        );
      });
    });

    group('saveLeader', () {
      test('makes correct api request', () {
        final newLeader = Leader(
          id: '10',
          userid: 'user 10',
          theme: 'theme',
          settings: settings,
          time: 110,
          moves: 15,
          timestamp: DateTime.fromMillisecondsSinceEpoch(12345),
        );

        final subject = createSubject();

        expect(subject.saveHistory(newLeader), completes);

        verify(() => api.saveHistory(newLeader)).called(1);
      });
    });
  });
}
