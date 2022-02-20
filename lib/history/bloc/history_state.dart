// ignore_for_file: public_member_api_docs

part of 'history_bloc.dart';

enum HistoryStatus { initial, loading, success, failure }

class HistoryState extends Equatable {
  const HistoryState({
    this.status = HistoryStatus.initial,
    this.leaders = const [],
    this.filter = HistoryViewFilter.all,
  });

  final HistoryStatus status;
  final List<Leader> leaders;
  final HistoryViewFilter filter;

  Iterable<Leader> get filteredLeaders => filter.applyAll(leaders);

  HistoryState copyWith({
    HistoryStatus Function()? status,
    List<Leader> Function()? leaders,
    HistoryViewFilter Function()? filter,
  }) {
    return HistoryState(
      status: status != null ? status() : this.status,
      leaders: leaders != null ? leaders() : this.leaders,
      filter: filter != null ? filter() : this.filter,
    );
  }

  @override
  List<Object?> get props => [status, leaders, filter];
}
