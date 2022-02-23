// ignore_for_file: public_member_api_docs

part of 'history_bloc.dart';

enum HistoryStatus { initial, loading, success, failure }

class HistoryState extends Equatable {
  const HistoryState({
    this.status = HistoryStatus.initial,
    this.leaders = const [],
  });

  final HistoryStatus status;
  final List<Leader> leaders;

  // NOTE: this used to be handled with a filter that was passed in via event.
  Iterable<Leader> filteredLeaders({
    required String userid,
    required String theme,
    required Settings settings,
  }) {
    final list = leaders
        .where((l) =>
            l.userid == userid && l.theme == theme && l.settings == settings)
        .toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    return list.reversed;
  }

  // NOTE: this used to be handled with a filter that was passed in via event.
  Leader? filteredBest({
    required String userid,
    required String theme,
    required Settings settings,
  }) {
    final list = filteredLeaders(
      userid: userid,
      theme: theme,
      settings: settings,
    );

    if (list.isEmpty) return null;

    return list.reduce(
      (value, element) => (value.result.time < element.result.time ||
              (value.result.time == element.result.time &&
                  value.result.moves < element.result.moves))
          ? value
          : element,
    );
  }

  HistoryState copyWith({
    HistoryStatus Function()? status,
    List<Leader> Function()? leaders,
    Leader? current,
    Leader? best,
  }) {
    return HistoryState(
      status: status != null ? status() : this.status,
      leaders: leaders != null ? leaders() : this.leaders,
    );
  }

  @override
  List<Object?> get props => [status, leaders];
}
