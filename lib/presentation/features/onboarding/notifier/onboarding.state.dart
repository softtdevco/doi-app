class OnboardingState{
  final String userName;
  final bool submitUsername;
  OnboardingState({
    required this.submitUsername,
    required this.userName
  });
  factory OnboardingState.initial(){
    return OnboardingState(submitUsername: false,
     userName: '');

  
  }
  OnboardingState copyWith({
    String?userName,
    bool?submitUsername,
  }){
    return OnboardingState(submitUsername: submitUsername?? this.submitUsername,
     userName: userName?? this.userName);
  }
}