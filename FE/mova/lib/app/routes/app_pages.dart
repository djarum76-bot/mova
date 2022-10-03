import 'package:get/get.dart';

import '../modules/create_new_password/bindings/create_new_password_binding.dart';
import '../modules/create_new_password/views/create_new_password_view.dart';
import '../modules/custom_auth/bindings/custom_auth_binding.dart';
import '../modules/custom_auth/views/custom_auth_view.dart';
import '../modules/download/bindings/download_binding.dart';
import '../modules/download/views/download_view.dart';
import '../modules/download_setting/bindings/download_setting_binding.dart';
import '../modules/download_setting/views/download_setting_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/explore/bindings/explore_binding.dart';
import '../modules/explore/views/explore_view.dart';
import '../modules/fill_profile/bindings/fill_profile_binding.dart';
import '../modules/fill_profile/views/fill_profile_view.dart';
import '../modules/forget_password_1/bindings/forget_password_1_binding.dart';
import '../modules/forget_password_1/views/forget_password_1_view.dart';
import '../modules/forget_password_2_email/bindings/forget_password_2_email_binding.dart';
import '../modules/forget_password_2_email/views/forget_password_2_email_view.dart';
import '../modules/forget_password_2_sms/bindings/forget_password_2_sms_binding.dart';
import '../modules/forget_password_2_sms/views/forget_password_2_sms_view.dart';
import '../modules/forget_password_3_sms/bindings/forget_password_3_sms_binding.dart';
import '../modules/forget_password_3_sms/views/forget_password_3_sms_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/interest/bindings/interest_binding.dart';
import '../modules/interest/views/interest_view.dart';
import '../modules/intersection/bindings/intersection_binding.dart';
import '../modules/intersection/views/intersection_view.dart';
import '../modules/introduction/bindings/introduction_binding.dart';
import '../modules/introduction/views/introduction_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/movie_comment/bindings/movie_comment_binding.dart';
import '../modules/movie_comment/views/movie_comment_view.dart';
import '../modules/movie_detail/bindings/movie_detail_binding.dart';
import '../modules/movie_detail/views/movie_detail_view.dart';
import '../modules/my_list/bindings/my_list_binding.dart';
import '../modules/my_list/views/my_list_view.dart';
import '../modules/navbar/bindings/navbar_binding.dart';
import '../modules/navbar/views/navbar_view.dart';
import '../modules/new_pin/bindings/new_pin_binding.dart';
import '../modules/new_pin/views/new_pin_view.dart';
import '../modules/new_release/bindings/new_release_binding.dart';
import '../modules/new_release/views/new_release_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/notification_setting/bindings/notification_setting_binding.dart';
import '../modules/notification_setting/views/notification_setting_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/security/bindings/security_binding.dart';
import '../modules/security/views/security_view.dart';
import '../modules/series_comment/bindings/series_comment_binding.dart';
import '../modules/series_comment/views/series_comment_view.dart';
import '../modules/series_detail/bindings/series_detail_binding.dart';
import '../modules/series_detail/views/series_detail_view.dart';
import '../modules/subscribe/bindings/subscribe_binding.dart';
import '../modules/subscribe/views/subscribe_view.dart';
import '../modules/subscription/bindings/subscription_binding.dart';
import '../modules/subscription/views/subscription_view.dart';
import '../modules/top_10/bindings/top_10_binding.dart';
import '../modules/top_10/views/top_10_view.dart';
import '../modules/video_play/bindings/video_play_binding.dart';
import '../modules/video_play/views/video_play_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INTRODUCTION,
      page: () => IntroductionView(),
      binding: IntroductionBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOM_AUTH,
      page: () => CustomAuthView(),
      binding: CustomAuthBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.INTEREST,
      page: () => InterestView(),
      binding: InterestBinding(),
    ),
    GetPage(
      name: _Paths.FILL_PROFILE,
      page: () => FillProfileView(),
      binding: FillProfileBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PIN,
      page: () => NewPinView(),
      binding: NewPinBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD_1,
      page: () => ForgetPassword1View(),
      binding: ForgetPassword1Binding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD_2_SMS,
      page: () => ForgetPassword2SmsView(),
      binding: ForgetPassword2SmsBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD_2_EMAIL,
      page: () => ForgetPassword2EmailView(),
      binding: ForgetPassword2EmailBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD_3_SMS,
      page: () => ForgetPassword3SmsView(),
      binding: ForgetPassword3SmsBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_NEW_PASSWORD,
      page: () => CreateNewPasswordView(),
      binding: CreateNewPasswordBinding(),
    ),
    GetPage(
      name: _Paths.NAVBAR,
      page: () => NavbarView(),
      binding: NavbarBinding(),
    ),
    GetPage(
      name: _Paths.EXPLORE,
      page: () => ExploreView(),
      binding: ExploreBinding(),
    ),
    GetPage(
      name: _Paths.MY_LIST,
      page: () => MyListView(),
      binding: MyListBinding(),
    ),
    GetPage(
      name: _Paths.DOWNLOAD,
      page: () => DownloadView(),
      binding: DownloadBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.TOP_10,
      page: () => Top10View(),
      binding: Top10Binding(),
    ),
    GetPage(
      name: _Paths.NEW_RELEASE,
      page: () => NewReleaseView(),
      binding: NewReleaseBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.SERIES_DETAIL,
      page: () => SeriesDetailView(),
      binding: SeriesDetailBinding(),
    ),
    GetPage(
      name: _Paths.MOVIE_DETAIL,
      page: () => MovieDetailView(),
      binding: MovieDetailBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO_PLAY,
      page: () => VideoPlayView(),
      binding: VideoPlayBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_SETTING,
      page: () => NotificationSettingView(),
      binding: NotificationSettingBinding(),
    ),
    GetPage(
      name: _Paths.SECURITY,
      page: () => SecurityView(),
      binding: SecurityBinding(),
    ),
    GetPage(
      name: _Paths.SUBSCRIBE,
      page: () => SubscribeView(),
      binding: SubscribeBinding(),
    ),
    GetPage(
      name: _Paths.DOWNLOAD_SETTING,
      page: () => DownloadSettingView(),
      binding: DownloadSettingBinding(),
    ),
    GetPage(
      name: _Paths.INTERSECTION,
      page: () => IntersectionView(),
      binding: IntersectionBinding(),
    ),
    GetPage(
      name: _Paths.MOVIE_COMMENT,
      page: () => MovieCommentView(),
      binding: MovieCommentBinding(),
    ),
    GetPage(
      name: _Paths.SERIES_COMMENT,
      page: () => SeriesCommentView(),
      binding: SeriesCommentBinding(),
    ),
    GetPage(
      name: _Paths.SUBSCRIPTION,
      page: () => const SubscriptionView(),
      binding: SubscriptionBinding(),
    ),
  ];
}
