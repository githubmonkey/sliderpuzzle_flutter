// ignore_for_file: public_member_api_docs

part of 'settings_bloc.dart';

// TODO(s): rename this, it's not longer encoding only
enum AnswerEncoding { multi, addition, hex, binary, roman, noop }

class SettingsState extends Equatable {
  // Default settings
  const SettingsState({
    this.boardSize = 4,
    this.elevenToTwenty = false,
    this.answerEncoding = AnswerEncoding.multi,
  });

  final int boardSize;
  final bool elevenToTwenty;
  final AnswerEncoding answerEncoding;

  SettingsState copyWith({
    int? boardSize,
    bool? elevenToTwenty,
    AnswerEncoding? answerEncoding,
  }) {
    return SettingsState(
      boardSize: boardSize ?? this.boardSize,
      elevenToTwenty: elevenToTwenty ?? this.elevenToTwenty,
      answerEncoding: answerEncoding ?? this.answerEncoding,
    );
  }

  @override
  List<Object?> get props => [boardSize, elevenToTwenty, answerEncoding];
}
