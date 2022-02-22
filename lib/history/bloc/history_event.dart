// ignore_for_file: public_member_api_docs

part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class HistorySubscriptionRequested extends HistoryEvent {
  const HistorySubscriptionRequested();
}

class HistoryLeaderSaved extends HistoryEvent {
  const HistoryLeaderSaved(this.leader);

  final Leader leader;

  @override
  List<Object> get props => [leader];
}
