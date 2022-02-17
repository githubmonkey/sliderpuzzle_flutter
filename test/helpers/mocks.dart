import 'package:auth_repository/auth_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';
import 'package:very_good_slide_puzzle/audio_control/audio_control.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/helpers/helpers.dart';
import 'package:very_good_slide_puzzle/language_control/language_control.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/login/login.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/mslide/mslide.dart';
import 'package:very_good_slide_puzzle/mswap/mswap.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/settings/settings.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/timer/timer.dart';

class MockPuzzleTheme extends Mock implements PuzzleTheme {}

class MockDashatarTheme extends Mock implements DashatarTheme {}

class MockMslideTheme extends Mock implements MslideTheme {}

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

class MockThemeBloc extends MockBloc<ThemeEvent, ThemeState>
    implements ThemeBloc {}

class MockDashatarThemeBloc
    extends MockBloc<DashatarThemeEvent, DashatarThemeState>
    implements DashatarThemeBloc {}

class MockDashatarPuzzleBloc
    extends MockBloc<DashatarPuzzleEvent, DashatarPuzzleState>
    implements DashatarPuzzleBloc {}

class MockDashatarPuzzleState extends Mock implements DashatarPuzzleState {}

class MockMslideThemeBloc extends MockBloc<MslideThemeEvent, MslideThemeState>
    implements MslideThemeBloc {}

class MockMslidePuzzleBloc
    extends MockBloc<MslidePuzzleEvent, MslidePuzzleState>
    implements MslidePuzzleBloc {}

class MockMslidePuzzleState extends Mock implements MslidePuzzleState {}

class MockMswapThemeBloc extends MockBloc<MswapThemeEvent, MswapThemeState>
    implements MswapThemeBloc {}

class MockMswapPuzzleBloc extends MockBloc<MswapPuzzleEvent, MswapPuzzleState>
    implements MswapPuzzleBloc {}

class MockMswapPuzzleState extends Mock implements MswapPuzzleState {}

class MockPuzzleBloc extends MockBloc<PuzzleEvent, PuzzleState>
    implements PuzzleBloc {}

class MockPuzzleEvent extends Mock implements PuzzleEvent {}

class MockPuzzleState extends Mock implements PuzzleState {}

class MockTimerBloc extends MockBloc<TimerEvent, TimerState>
    implements TimerBloc {}

class MockTimerState extends Mock implements TimerState {}

class MockLanguageControlBloc
    extends MockBloc<LanguageControlEvent, LanguageControlState>
    implements LanguageControlBloc {}

class MockLanguageControlEvent extends Mock implements LanguageControlEvent {}

class MockLanguageControlState extends Mock implements LanguageControlState {}

class MockSettingsBloc extends MockBloc<SettingsEvent, SettingsState>
    implements SettingsBloc {}

class MockSettingsEvent extends Mock implements SettingsEvent {}

class MockSettingsState extends Mock implements SettingsState {}

class MockPuzzle extends Mock implements Puzzle {}

class MockTile extends Mock implements Tile {}

class MockPuzzleLayoutDelegate extends Mock implements PuzzleLayoutDelegate {}

class MockTicker extends Mock implements Ticker {}

class MockUrlLauncher extends Mock
    with MockPlatformInterfaceMixin
    implements UrlLauncherPlatform {}

class MockAudioPlayer extends Mock implements AudioPlayer {}

class MockPlatformHelper extends Mock implements PlatformHelper {}

class MockAudioControlBloc
    extends MockBloc<AudioControlEvent, AudioControlState>
    implements AudioControlBloc {}

//class MockUserCredential extends Mock
//    implements firebase_auth.UserCredential {}

//class MockFirebaseAuth extends Mock implements firebase_auth.FirebaseAuth {}

class MockAuthRepository extends Mock implements AuthRepository {}
