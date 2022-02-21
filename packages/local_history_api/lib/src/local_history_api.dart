import 'dart:convert';

import 'package:english_words/english_words.dart';
import 'package:leaders_api/leaders_api.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template local_history_api}
/// A Flutter implementation of the LeadersApi that uses local storage.
/// {@endtemplate}
class LocalHistoryApi extends LeadersApi {
  /// {@macro local_history_api}
  LocalHistoryApi({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  final _historyStreamController = BehaviorSubject<List<Leader>>.seeded(
    const [],
  );

  // NOTE: does this have to be a stream?
  Map<String, String> _nicknames = {};


  /// The key used for storing the leaders locally.
  ///
  /// This is only exposed for testing and shouldn't be used by consumers of
  /// this library.
  @visibleForTesting
  static const kHistoryCollectionKey = '__history_collection_key__';

  /// The key used for storing the nicknames locally.
  ///
  /// This is only exposed for testing and shouldn't be used by consumers of
  /// this library.
  @visibleForTesting
  static const kNicknameCollectionKey = '__nickname_collection_key__';

  String? _getValue(String key) => _plugin.getString(key);

  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final leadersJson = _getValue(kHistoryCollectionKey);
    if (leadersJson != null) {
      final leaders = List<Map>.from(json.decode(leadersJson) as List)
          .map((jsonMap) => Leader.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _historyStreamController.add(leaders);
    } else {
      _historyStreamController.add(const []);
    }

    final nicknamesJson = _getValue(kNicknameCollectionKey);
    if (nicknamesJson != null) {
      _nicknames = Map<String, String>.from(json.decode(nicknamesJson) as Map);
    } else {
      _nicknames = {};
    }

  }

  @override
  Stream<List<Leader>> getHistory() =>
      _historyStreamController.asBroadcastStream();

  @override
  Future<void> saveHistory(Leader leader) {
    final leaders = [..._historyStreamController.value];
    final leaderIndex = leaders.indexWhere((t) => t.id == leader.id);
    if (leaderIndex >= 0) {
      leaders[leaderIndex] = leader;
    } else {
      leaders.add(leader);
    }

    _historyStreamController.add(leaders);
    return _setValue(kHistoryCollectionKey, json.encode(leaders));
  }

  String getNickname(String userid) {
    if (!_nicknames.containsKey(userid)) {
      _nicknames[userid] = generateNickname();
      _setValue(kNicknameCollectionKey, json.encode(_nicknames));
    }
    return _nicknames[userid]!;
  }

  String generateNickname() {
    return WordPair.random().asUpperCase;
  }
}
