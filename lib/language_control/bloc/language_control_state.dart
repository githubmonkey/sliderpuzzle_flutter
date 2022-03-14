// ignore_for_file: public_member_api_docs

part of 'language_control_bloc.dart';

class LanguageControlState extends Equatable {
  const LanguageControlState({required this.locale});

  final Locale? locale;

  @override
  List<Object> get props => [locale ?? const Locale('en')];
}
