import 'dart:convert';

import 'package:leaders_api/leaders_api.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template local_leaders_api}
/// A Flutter implementation of the LeadersApi that uses local storage.
/// {@endtemplate}
class LocalLeadersApi extends LeadersApi {
  /// {@macro local_leaders_api}
  LocalLeadersApi({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  final _leaderStreamController = BehaviorSubject<List<Leader>>.seeded(
    const [],
  );

  /// The key used for storing the leaders locally.
  ///
  /// This is only exposed for testing and shouldn't be used by consumers of
  /// this library.
  @visibleForTesting
  static const kLeadersCollectionKey = '__leaders_collection_key__';

  String? _getValue(String key) => _plugin.getString(key);

  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final leadersJson = _getValue(kLeadersCollectionKey);
    if (leadersJson != null) {
      final leaders = List<Map>.from(json.decode(leadersJson) as List)
          .map((jsonMap) => Leader.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _leaderStreamController.add(leaders);
    } else {
      _leaderStreamController.add(const []);
    }
  }

  // TODO(s): filter by time
  @override
  Stream<List<Leader>> getLeaders({int? time}) =>
      _leaderStreamController.asBroadcastStream();

  @override
  Future<void> saveLeader(Leader leader) {
    final leaders = [..._leaderStreamController.value];
    final leaderIndex = leaders.indexWhere((t) => t.id == leader.id);
    if (leaderIndex >= 0) {
      leaders[leaderIndex] = leader;
    } else {
      leaders.add(leader);
    }

    _leaderStreamController.add(leaders);
    return _setValue(kLeadersCollectionKey, json.encode(leaders));
  }
}
