import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';
import 'package:touch_counter_app/ads/admob_service.dart';

abstract class ListItem {
  Widget buildOrigin(BuildContext context);
  Widget buildAdNative(BuildContext context, NativeAdmobController _adController);
}

class NativeAdsItem implements ListItem {
  final int index;
  final bool isMedia;

  NativeAdsItem(this.index, {this.isMedia = true});

  Widget buildOrigin(BuildContext context) => null;
  Widget buildAdNative(BuildContext context, NativeAdmobController _adController) {
    _adController.setTestDeviceIds(AdmobService.instance.adUnitTestDevices);

    return Container(
      height: isMedia ? 300 : 160,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 20.0),
      child: NativeAdmob(
        adUnitID: AdmobService.instance.adUnitIdNatives[index],
        controller: _adController,
        loading: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
        options: NativeAdmobOptions(showMediaContent: isMedia),
      ),
    );
  }
}
