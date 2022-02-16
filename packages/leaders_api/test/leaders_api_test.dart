import 'package:leaders_api/leaders_api.dart';
import 'package:test/test.dart';

class TestLeadersApi extends LeadersApi {
  TestLeadersApi() : super();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

void main() {
  group('LeadersApi', () {
    test('can be constructed', () {
      expect(TestLeadersApi.new, returnsNormally);
    });
  });
}
