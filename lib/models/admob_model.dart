import 'package:firebase_admob/firebase_admob.dart';
import 'dart:io' show Platform;

class AdmobCounter {
  static const String appId_android = "ca-app-pub-8126362785815437~5741192322";
  static const String adUnitId_android = "ca-app-pub-8126362785815437/6998433679";
  static const String appId_Ios = "ca-app-pub-8126362785815437~8091328965";
  static const String adUnitId_Ios = "ca-app-pub-8126362785815437/7133809820";

  String appId;
  String adUnitId;

  BannerAd myBanner;

  AdmobCounter() {
    if (Platform.isAndroid) {
      this.appId = appId_android;
      this.adUnitId = adUnitId_android;
    } else if (Platform.isIOS) {
      this.appId = appId_Ios;
      this.adUnitId = adUnitId_Ios;
    }
  }

  void admobCounterInit() {
    MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['Utils', 'useful app'],
      contentUrl: 'https://flutter.io',
      childDirected: false,
      testDevices: <String>[], // Android emulators are considered test devices
    );

    myBanner = BannerAd(
      adUnitId: adUnitId,
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );
  }

  void admobBannerShow() {
    myBanner
      ..load()
      ..show(
        anchorOffset: 0.0,
        horizontalCenterOffset: 0.0,
        anchorType: AnchorType.bottom,
      );
  }
}
