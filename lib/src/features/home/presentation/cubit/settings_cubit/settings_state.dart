part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.isLoadingPicture = false,
    this.isLoadingName = false,
    this.isLoadingBio = false,
  });

  final bool isLoadingPicture;
  final bool isLoadingName;
  final bool isLoadingBio;

  SettingsState copyWith({
    bool? isLoadingPicture,
    bool? isLoadingName,
    bool? isLoadingBio,
  }) {
    return SettingsState(
      isLoadingPicture: isLoadingPicture ?? this.isLoadingPicture,
      isLoadingName: isLoadingName ?? this.isLoadingName,
      isLoadingBio: isLoadingBio ?? this.isLoadingBio,
    );
  }

  @override
  List<Object> get props => [
        isLoadingPicture,
        isLoadingName,
        isLoadingBio,
      ];
}
