// ignore_for_file: public_member_api_docs

part of 'language_control_bloc.dart';

abstract class LanguageControlEvent extends Equatable {
  const LanguageControlEvent();

  @override
  List<Object> get props => [];
}

class LanguageToggled extends LanguageControlEvent {
  const LanguageToggled();
}

class LanguageInit extends LanguageControlEvent {
  const LanguageInit(this.locale);

  final Locale locale;

  @override
  List<Object> get props => [locale];
}
