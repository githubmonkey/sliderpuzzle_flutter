// ignore_for_file: prefer_const_constructors
import 'package:history_repository/history_repository.dart';
import 'package:leaders_api/leaders_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockLeadersApi extends Mock implements LeadersApi {}

class FakeLeader extends Fake implements Leader {}

void main() {
  group('HistoryRepository', () {
    late LeadersApi api;

    const settings = Settings(
      boardSize: 4,
      game: Game.noop,
      elevenToTwenty: true,
      //withClues: true,
    );
    const result = Result(time: 100, moves: 25);

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
        nickname: 'nickname3',
        theme: 'theme',
        settings: settings,
        result: result,
        timestamp: DateTime.fromMillisecondsSinceEpoch(12345),
      ),
      Leader(
        id: '4',
        userid: 'user 3',
        theme: 'theme',
        settings: settings,
        result: result,
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
      when(() => api.getNickname(any())).thenAnswer((_) => 'generated');
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
          result: result,
          timestamp: DateTime.fromMillisecondsSinceEpoch(12345),
        );

        final subject = createSubject();

        expect(subject.saveHistory(newLeader), completes);

        verify(() => api.saveHistory(newLeader)).called(1);
      });
    });

    group('getNickname', () {
      test('makes correct api request', () {
        final subject = createSubject();
        const userid = '123';

        expect(subject.getNickname(userid), isNot(throwsA(anything)));

        verify(() => api.getNickname(userid)).called(1);
      });

      test('returns a nickname', () {
        final nickname = createSubject().getNickname('123');
        expect(nickname, matches('generated'));
      });
    });
  });
}
