class AppConstants {
  static const String baseUrlProd = "http://test.znhsolutions.com/api/";

  static const String noImageFound = "https://www.ncenet.com/wp-content/uploads/2020/04/No-image-found.jpg";

  static const String currentUrl = "https://www.infolinkbd.com/";

  static const String assetsPath = "assets/icon/";

// Introduction Screen configuration

  static const bool introScreenOnOff = false;

// First Page Introduction Screen

  static const String firstIntroImage = "intro_1.png";
  static const String firstIntroTitle = "Website Convert Into Flutter App";
  static const String firstIntroDescription = "Website Convert into flutter App & get well documentation with admin panel code";

// Second Page Introduction Screen

  static const String secondIntroImage = "intro_2.png";
  static const String secondIntroTitle = "OTT Plateform Convert into App";
  static const String secondIntroDescription = "Convert your ott plateform into app and free config";

// Third Page Introduction Screen

  static const String thirdIntroImage = "intro_3.png";
  static const String thirdIntroTitle = "News And  Blogs Convert into App";
  static const String thirdIntroDescription = "Convert your news & Blogs into app and freesvg config";

// Appbar configuration

  static const bool appBarHideShow = true;

  static const String appName = "Universal Web";

// Bottom Menu configuration

  static const bool bottomMenuHideShow = false;

// First Menu
  static const String firstMenu = "Home";
  static const String firsticon = "m1.svg";
  static const bool firstMenuOpt = true;
  static const String firstURL = "https://www.infolinkbd.com/";

// Second Menu
  static const String secondMenu = "Search";
  static const String secondicon = "m2.svg";
  static const bool secondMenuOpt = true;
  static const String secondURL = "https://www.divinetechs.com/";
  static const String storageKeyDeviceType = 'key_device_type';
  static const String storageKeyFcmToken = 'key_fcm_token';
// Third Menu
  static const String thirdMenu = "Setting";
  static const String thirdicon = "m3.svg";
  static const bool thirdMenuOpt = true;
  static const String thirdURL = "https://www.amazon.in/";

// Fourth Menu
  static const String fourthMenu = "Profile";
  static const String fourthicon = "m4.svg";
  static const bool fourthMenuOpt = true;
  static const String forthURL = "https://www.divinetechs.com/";

// Floating Menu configuration

  static const bool floatingMenuHideShow = false;

  static const String floatingMenuIcon = "floating menu icon.svg";

// First Menu
  static const String ffirstMenu = "Info";
  static const String ffirsticon = "fm1.svg";
  static const bool ffirstMenuOpt = true;
  static const String ffirstURL = "https://www.netflix.com/";

// Second Menu
  static const String fsecondMenu = "Manage";
  static const String fsecondicon = "fm2.svg";
  static const bool fsecondMenuOpt = true;
  static const String fsecondURL = "https://www.divinetechs.com/";

// Third Menu
  static const String fthirdMenu = "Apps";
  static const String fthirdicon = "fm3.svg";
  static const bool fthirdMenuOpt = true;
  static const String fthirdURL = "https://www.apple.com/in/app-store/";

// Fourth Menu
  static const String ffourthMenu = "Theme";
  static const String ffourthicon = "fm4.svg";
  static const bool ffourthMenuOpt = true;
  static const String fforthURL = "https://www.apple.com/in/app-store/";

  static const bool hideHeader = false;
  static const bool hideFooter = false;

// Google Ads configuration

// Android keys

  static const bool bannerAdIs = true;
  String bannerAdId = "ca-app-pub-3940256099942544/6300978111";

  static const bool interstialAdIs = true;
  String interstialAdId = "ca-app-pub-3940256099942544/1033173712";
  int? maxInterstitialAdclick = 2;

  static const bool rewardAdIs = true;
  String rewardAdId = "ca-app-pub-3940256099942544/5224354917";
  int maxRewardAdclick = 2;

//  iOS Keys

  static const bool iosBannerAdIs = true;
  String iosBannerAdId = "ca-app-pub-3940256099942544/2934735716";

  static const bool iosinterstialAdIs = true;
  String iosinterstialAdId = "ca-app-pub-3940256099942544/4411468910";

  static const bool iosrewardAdIs = true;
  String iosrewardAdId = "ca-app-pub-3940256099942544/1712485313";

  String oneSignalAppId = "0a4a70fe-c922-4b2a-979d-21188ae1e916";
}

enum DeviceType { mobile, smallTablet, largeTablet }
