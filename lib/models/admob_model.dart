import 'package:firebase_admob/firebase_admob.dart';

class AdmobCounter {
  static const String appId = "ca-app-pub-8126362785815437~5741192322";
  static const String adUnitId = "ca-app-pub-8126362785815437/6998433679";

  BannerAd myBanner;

  void admobCounterInit() {
    MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['Utils', 'useful app'],
      contentUrl: 'https://flutter.io',
      childDirected: false,
      testDevices: <String>[], // Android emulators are considered test devices
    );

    myBanner = BannerAd(
      adUnitId: AdmobCounter.adUnitId,
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
