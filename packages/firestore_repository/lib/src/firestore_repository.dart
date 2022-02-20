// ignore_for_file: public_member_api_docs

import 'package:cloud_firestore/cloud_firestore.dart' hide Settings;
import 'package:leaders_api/leaders_api.dart';
import 'package:meta/meta.dart';

/// {@template local_leaders_api}
/// Firebase Repo without extra api
/// {@endtemplate}
class FirestoreRepository {
  /// {@macro local_leaders_api}
  FirestoreRepository();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// This is only exposed for testing and shouldn't be used by consumers of
  /// this library.
  @visibleForTesting
  static const kUsersCollectionKey = 'users';

  /// This is only exposed for testing and shouldn't be used by consumers of
  /// this library.
  @visibleForTesting
  static const kHistoryCollectionKey = 'history';

  /// This is only exposed for testing and shouldn't be used by consumers of
  /// this library.
  @visibleForTesting
  static const kLeadersCollectionKey = 'leaders';

  final _leadersRef = FirebaseFirestore.instance
      .collection(kLeadersCollectionKey)
      .withConverter<Leader>(
        fromFirestore: (snapshot, _) => Leader.fromJson(snapshot.data()!),
        toFirestore: (leader, _) => leader.toJson(),
      );

  CollectionReference<Leader> _getHistoryRef(String uid) =>
      FirebaseFirestore.instance
          .collection(kUsersCollectionKey)
          .doc(uid)
          .collection(kHistoryCollectionKey)
          .withConverter<Leader>(
            fromFirestore: (snapshot, _) => Leader.fromJson(snapshot.data()!),
            toFirestore: (leader, _) => leader.toJson(),
          );

  /// //TODO(s): add filters
  Stream<QuerySnapshot<Leader>> getLeaders() =>
      _leadersRef.orderBy('timestamp', descending: true).snapshots();

  /// //TODO(s): add filters
  Stream<QuerySnapshot<Leader>> getHistory(
    String uid, {
    String? theme,
    Settings? settings,
  }) {
    Query<Leader> ref = _getHistoryRef(uid);

    if (theme != null) ref = ref.where('theme', isEqualTo: theme);
    if (settings != null)
      ref = ref.where('settings', isEqualTo: settings.toJson());

    return ref.orderBy('timestamp', descending: true).snapshots();
  }

  Future<void> saveLeader(Leader leader) {
    return _leadersRef.add(leader);
  }

  Future<void> saveHistory(Leader leader) {
    final uid = leader.userid;
    return _getHistoryRef(uid).add(leader);
  }
}
