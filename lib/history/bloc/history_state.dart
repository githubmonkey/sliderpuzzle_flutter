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
    required String theme,
    required Settings settings,
  }) {
    var list = leaders
        .where((l) => l.theme == theme && l.settings == settings)
        .toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    return list.reversed;
  }

  HistoryState copyWith({
    HistoryStatus Function()? status,
    List<Leader> Function()? leaders,
  }) {
    return HistoryState(
      status: status != null ? status() : this.status,
      leaders: leaders != null ? leaders() : this.leaders,
    );
  }

  @override
  List<Object?> get props => [status, leaders];
}
