part of 'theme_cubit.dart';

enum AppTheme { light, dark }

class ThemeState extends Equatable {
  final AppTheme theme;

  const ThemeState({this.theme = AppTheme.light});

  factory ThemeState.initital() {
    return const ThemeState();
  }

  @override
  List<Object> get props => [theme];

  ThemeState copyWith({AppTheme? theme}) {
    return ThemeState(
      theme: theme ?? this.theme,
    );
  }
}
