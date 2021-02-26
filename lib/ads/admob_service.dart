import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:touch_counter_app/config/app_config.dart';
import 'package:touch_counter_app/config/app_permission.dart';

class AdmobService {
  static final AdmobService instance = AdmobService._internal();
  factory AdmobService() => instance;

  static const String appId_android = "ca-app-pub-8126362785815437~5741192322";
  static const String androidBanner = "ca-app-pub-8126362785815437/6998433679";
  static const String androidScreen = "ca-app-pub-8126362785815437/9760328389";
  static const String androidNative1 = "ca-app-pub-8126362785815437/4508001703";

  static const String appId_Ios = "ca-app-pub-8126362785815437~8091328965";
  static const String iosBanner = "ca-app-pub-8126362785815437/7133809820";
  static const String iosScreen = "ca-app-pub-8126362785815437/9155291329";
  static const String iosNative1 = "ca-app-pub-8126362785815437/6478346466";

  static const List<String> adTestDevices = [
    '2D159629EE19847C31CA346220064982',
    'c436c35d91946bdb614e712ae37a306e',
    '1A18D049E53EC12E5B033AB23483F1C8',
  ];

  String appId;
  String adUnitIdBanner;
  String adUnitIdScreen;
  List<String> adUnitIdNatives = [];
  List<String> adUnitTestDevices = [];

  int adNativeIndex = 0;

  BannerAd _banner;
  NativeAd _native;

  AdmobService._internal() {
    if (Platform.isAndroid) {
      this.appId = appId_android;
      this.adUnitIdBanner = androidBanner;
      this.adUnitIdScreen = androidScreen;
      this.adUnitIdNatives = [androidNative1];
    } else if (Platform.isIOS) {
      this.appId = appId_Ios;
      this.adUnitIdBanner = iosBanner;
      this.adUnitIdScreen = iosScreen;
      this.adUnitIdNatives = [iosNative1];
    }
    this.adUnitTestDevices = adTestDevices;
  }

  static MobileAdTargetingInfo get targetingInfo {
    return MobileAdTargetingInfo(
      keywords: <String>['Utils', 'useful app'],
      contentUrl: 'https://flutter.io',
      childDirected: true,
      testDevices: adTestDevices,
      nonPersonalizedAds: true,
    );
  }

  void admobNativeInit() {
    _native = NativeAd(
      adUnitId: adUnitIdNatives[adNativeIndex],
      factoryId: 'adFactoryExample',
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("$NativeAd event $event");
      },
    );
  }

  void admobNativeLoad() async {
    print('admobNativeLoad');
    if (AppConfig.admobView == false || AppConfig.permission != Permission.FREE) return;
    if (_native == null) admobNativeInit();

    await _native.load();
  }

  void admobNativeShow() {
    print('admobNativeShow');
    if (AppConfig.admobView == false || AppConfig.permission != Permission.FREE) return;
    if (_native == null) admobNativeInit();

    _native
      ..load()
      ..show(
        anchorOffset: 0,
        horizontalCenterOffset: 0,
        anchorType: AnchorType.bottom,
      );
  }

  void admobNativeHide() {
    if (_native != null) {
      _native.dispose();
      _native = null;
    }
    AdmobService.instance.admobNativeLoad();
  }

  void admobBannerInit() {
    _banner = BannerAd(
      adUnitId: adUnitIdBanner,
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {},
    );
  }

  void admobBannerShow() {
    print('admobBannerShow');
    if (AppConfig.admobView == false || AppConfig.permission != Permission.FREE) return;
    if (_banner == null) admobBannerInit();
    _banner
      ..load()
      ..show(
        anchorOffset: 0.0,
        horizontalCenterOffset: 0.0,
        anchorType: AnchorType.bottom,
      );
  }

  void admobBannerHide() {
    if (_banner != null) {
      _banner.dispose();
      _banner = null;
    }
  }
}
