// ignore_for_file: public_member_api_docs

part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class BoardSizeChanged extends SettingsEvent {
  const BoardSizeChanged({required this.boardSize});

  final int boardSize;

  @override
  List<Object?> get props => [boardSize];
}

class ElevenToTwentyChanged extends SettingsEvent {
  const ElevenToTwentyChanged({required this.elevenToTwenty});

  final bool elevenToTwenty;

  @override
  List<Object?> get props => [elevenToTwenty];
}

class AnswerEncodingChanged extends SettingsEvent {
  const AnswerEncodingChanged({required this.answerEncoding});

  final AnswerEncoding answerEncoding;

  @override
  List<Object?> get props => [answerEncoding];
}
