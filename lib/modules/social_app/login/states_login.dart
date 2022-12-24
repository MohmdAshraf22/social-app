
abstract class SocialLoginStates{}
class SocialChangePassState extends SocialLoginStates{}
class SocialInitialLoginState extends SocialLoginStates{}
class SocialLoadingLoginState extends SocialLoginStates{}
class SocialSuccessLoginState extends SocialLoginStates{
  late final String uId;
  SocialSuccessLoginState(this.uId);

}
class SocialErrorLoginState extends SocialLoginStates {
  late final String error;

  SocialErrorLoginState(this.error);
}

