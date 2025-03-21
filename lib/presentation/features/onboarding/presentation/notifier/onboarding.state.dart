import 'package:doi_mobile/core/utils/enums.dart';

class OnboardingState{
  final String userName;
  final LoadState loadState;
  final int authenicationIndex;
  final bool submitUsername;
  OnboardingState({
    required this.submitUsername,
    required this.authenicationIndex,
    required this.loadState,
    required this.userName
  });
  factory OnboardingState.initial(){
    return OnboardingState(
      authenicationIndex:0,
      submitUsername: false,
     userName: '', loadState: LoadState.loading);

  
  }
  OnboardingState copyWith({
    String?userName,
    LoadState? loadState,
    int? authenicationIndex,
    bool?submitUsername,
  }){
    return OnboardingState(
      loadState: loadState ?? this.loadState,
      submitUsername: submitUsername?? this.submitUsername,
     userName: userName?? this.userName, authenicationIndex: authenicationIndex?? this.authenicationIndex);
  }
}