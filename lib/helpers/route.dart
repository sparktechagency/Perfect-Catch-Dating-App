import 'package:get/get.dart';
import '../views/screen/Auth/ForgotPass/forgot_password_screen.dart';
import '../views/screen/Auth/OtpScreen/otp_screen.dart';
import '../views/screen/Auth/ResetPass/reset_password_screen.dart';
import '../views/screen/Auth/SignIn/sign_in_screen.dart';
import '../views/screen/Auth/SignUp/sign_up_screen.dart';
import '../views/screen/Auth/UploadPhotos/upload_photos_screen.dart';
import '../views/screen/Categories/categories_screen.dart';
import '../views/screen/Home/home_screen.dart';
import '../views/screen/Location/location_picker_screen.dart';
import '../views/screen/Location/location_screen.dart';
import '../views/screen/Profile/profile_screen.dart';
import '../views/screen/SelectMode/select_mode_screen.dart';
import '../views/screen/Splash/onboarding_screen.dart';
import '../views/screen/Splash/splash_screen.dart';
import '../views/screen/Subscription/subscription_screen.dart';
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
  static String homeScreen="/home_screen";
  static String profileScreen="/profile_screen";
  static String categoriesScreen="/categories_screen";
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
    GetPage(name:homeScreen, page: ()=>const HomeScreen(),transition:Transition.noTransition),
    GetPage(name:categoriesScreen, page: ()=>const CategoriesScreen(),transition:Transition.noTransition),
    GetPage(name:profileScreen, page: ()=>const ProfileScreen(),transition: Transition.noTransition),
   // GetPage(name:locationScreen, page: ()=>const LocationScreen(),transition: Transition.noTransition),
    //GetPage(name:locationPickerScreen, page: ()=>const LocationPickerScreen(),transition: Transition.noTransition),
  ];
}