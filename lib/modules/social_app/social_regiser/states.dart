
abstract class SocialRegisterStates {}
class SocialInitialRegisterState extends SocialRegisterStates {}
class SocialChangePassRegisterState extends SocialRegisterStates {}
class SocialAddProfileRegisterSuccessState extends SocialRegisterStates {}
class SocialUploadProfileRegisterSuccessState extends SocialRegisterStates {}
class SocialUploadProfileRegisterErrorState extends SocialRegisterStates {}
class SocialAddProfileRegisterErrorState extends SocialRegisterStates {}

class SocialLoadingRegisterState extends SocialRegisterStates {}
class SocialSuccessRegisterState extends SocialRegisterStates {}
class SocialErrorRegisterState extends SocialRegisterStates {
 late final String error;
 SocialErrorRegisterState(this.error);
}



class SocialLoadingCreateUserState extends SocialRegisterStates {}
class SocialSuccessCreateUserState extends SocialRegisterStates {
 late String uId;
 SocialSuccessCreateUserState(this.uId);
}
class SocialErrorCreateUserState extends SocialRegisterStates {
 late final String error;

 SocialErrorCreateUserState(this.error);
}