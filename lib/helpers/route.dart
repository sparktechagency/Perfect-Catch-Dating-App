import 'package:get/get.dart';
import '../views/screen/Auth/ForgotPass/forgot_password_screen.dart';
import '../views/screen/Auth/OtpScreen/otp_screen.dart';
import '../views/screen/Auth/ResetPass/reset_password_screen.dart';
import '../views/screen/Auth/SignIn/sign_in_screen.dart';
import '../views/screen/Auth/SignUp/sign_up_screen.dart';
import '../views/screen/Auth/UploadPhotos/upload_photos_screen.dart';
import '../views/screen/Chats/MessageInbox/message_screen.dart';
import '../views/screen/Chats/chats_screen.dart';
import '../views/screen/Home/home_screen.dart';
import '../views/screen/LiveStream/live_stream_screen.dart';
import '../views/screen/Location/location_picker_screen.dart';
import '../views/screen/Location/location_screen.dart';
import '../views/screen/Matches/matches_screen.dart';
import '../views/screen/Payment/payment_screen.dart';
import '../views/screen/Profile/profile_screen.dart';
import '../views/screen/SelectMode/select_mode_screen.dart';
import '../views/screen/SongList/song_list_screen.dart';
import '../views/screen/Splash/onboarding_screen.dart';
import '../views/screen/Splash/splash_screen.dart';
import '../views/screen/Subscription/subscription_screen.dart';
import '../views/screen/UserDetails/user_details_screen.dart';
import '../views/screen/YourInterests/your_interests_screen.dart';

class AppRoutes{
  static String splashScreen="/splash_screen";
  static String onboardingScreen="/onboarding_screen";
  static String selectModeScreen="/select_mode_screen";
  static String signInScreen="/sign_in_screen";
  static String signUpScreen="/sign_up_screen";
  static String forgotPasswordScreen="/forgot_password_screen";
  static String otpScreen="/otp_screen";
  static String resetPasswordScreen="/reset_password_screen";
  static String uploadPhotosScreen="/upload_photos_screen";
  static String yourInterestsScreen="/your_interests_screen";
  static String subscriptionScreen="/subscription_screen";
  static String paymentScreen="/payment_screen";
  static String songListScreen="/song_list_screen";
  static String homeScreen="/home_screen";
  static String profileScreen="/profile_screen";
  static String matchesScreen="/matches_screen";
  static String liveStreamScreen="/live_stream_screen";
  static String chatsScreen="/chats_screen";
  static String messageScreen="/message_screen";
  static String userDetailsScreen="/user_details_screen";
  //static String locationScreen="/location_screen";
 // static String locationPickerScreen="/location_picker_screen";

 static List<GetPage> page=[
    GetPage(name:splashScreen, page: ()=>const SplashScreen()),
    GetPage(name:onboardingScreen, page: ()=>const OnboardingScreen()),
    GetPage(name:selectModeScreen, page: ()=>const SelectModeScreen()),
    GetPage(name:signInScreen, page: ()=> SignInScreen()),
    GetPage(name:signUpScreen, page: ()=> SignUpScreen()),
    GetPage(name:forgotPasswordScreen, page: ()=> ForgotPasswordScreen()),
    GetPage(name:otpScreen, page: ()=> OtpScreen()),
    GetPage(name:resetPasswordScreen, page: ()=> ResetPasswordScreen()),
    GetPage(name:uploadPhotosScreen, page: ()=> UploadPhotosScreen()),
    GetPage(name:yourInterestsScreen, page: ()=> YourInterestsScreen()),
    GetPage(name:subscriptionScreen, page: ()=> SubscriptionScreen()),
    GetPage(name:paymentScreen, page: ()=> PaymentScreen()),
    GetPage(name:songListScreen, page: ()=> SongListScreen()),
    GetPage(name:homeScreen, page: ()=>const HomeScreen(),transition:Transition.noTransition),
    GetPage(name:matchesScreen, page: ()=> MatchesScreen(),transition:Transition.noTransition),
    GetPage(name:liveStreamScreen, page: ()=>const LiveStreamScreen(),transition:Transition.noTransition),
    GetPage(name:chatsScreen, page: ()=> ChatsScreen(),transition:Transition.noTransition),
    GetPage(name:profileScreen, page: ()=>const ProfileScreen(),transition: Transition.noTransition),
    GetPage(name:messageScreen, page: ()=>const MessageScreen()),
    GetPage(name:userDetailsScreen, page: ()=>const UserDetailsScreen()),
   // GetPage(name:locationScreen, page: ()=>const LocationScreen(),transition: Transition.noTransition),
    //GetPage(name:locationPickerScreen, page: ()=>const LocationPickerScreen(),transition: Transition.noTransition),
  ];
}