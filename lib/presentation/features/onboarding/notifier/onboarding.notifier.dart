import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingNotifier extends ChangeNotifier{
 
 String username ='';
 bool submitUserName=false;


 updateUserName(String c){
  username = c;
  notifyListeners();
 }
 updateSubmitUsername(bool c){
  submitUserName = c;
  notifyListeners();
 }

 List avatars=[
 
  {
    'active':Assets.images.avatar2,
    'inactive':Assets.images.avatar2,
  },
   {
    'active':Assets.images.avatar1,
    'inactive':Assets.images.avatar1,
  },
  {
    'active':Assets.images.avatar4,
    'inactive':Assets.images.avatar4,
  },
  {
    'active':Assets.images.avatar3,
    'inactive':Assets.images.avatar3,
  }
 
 ];
  
 
}

final onboardingNotifierProvider =
    ChangeNotifierProvider((ref)=>OnboardingNotifier());
