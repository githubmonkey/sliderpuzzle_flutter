// ignore_for_file: prefer_const_constructors
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:leaders_api/leaders_api.dart';
import 'package:leaders_repository/leaders_repository.dart';

class MockLeadersApi extends Mock implements LeadersApi {}

class FakeLeader extends Fake implements Leader {}

void main() {
  group('LeadersRepository', () {
    late LeadersApi api;

    final leaders = [
      Leader(
        id: '1',
        userid: 'user 1',
        nickname: '',
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
      Leader(
        id: '4',
        userid: 'user 3',
        settings: 'settings',
        time: 100,
        moves: 5,
      ),
    ];

    setUpAll(() {
      registerFallbackValue(FakeLeader());
    });

    setUp(() {
      api = MockLeadersApi();
      when(() => api.getLeaders()).thenAnswer((_) => Stream.value(leaders));
      when(() => api.saveLeader(any())).thenAnswer((_) async {});
    });

    LeadersRepository createSubject() => LeadersRepository(leadersApi: api);

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
          subject.getLeaders(),
          isNot(throwsA(anything)),
        );

        verify(() => api.getLeaders()).called(1);
      });

      test('returns stream of current list leaders', () {
        expect(
          createSubject().getLeaders(),
          emits(leaders),
        );
      });
    });

    group('saveLeader', () {
      test('makes correct api request', () {
        final newLeader = Leader(
          id: '10',
          userid: 'user 10',
          settings: 'settings',
          time: 110,
          moves: 15,
        );

        final subject = createSubject();

        expect(subject.saveLeader(newLeader), completes);

        verify(() => api.saveLeader(newLeader)).called(1);
      });
    });
  });
}
