import 'package:flutter/services.dart';

class FlutterPlayAsset {
  final methodPlayasset = "playasset";
  final methodDownloadProgressUpdate = "playasset_download_progress_update";
  final methodGetAsset = "get_asset";
  static const platform = MethodChannel('basictomodular/downloadservice');
  late ViewPlayAsset view;

  Future<void> init(ViewPlayAsset vw) async {
    view = vw;
    platform.setMethodCallHandler((call) async {
      print('platform channel method call ${call.method} ${call.arguments}');
      if (call.method == methodPlayasset) {
        if (!call.arguments.toString().contains("...")) {
          view.onAssetPathFound(call.arguments.toString());
        } else {
          view.onProcessLoadingAssetPath(call.arguments.toString());
        }
      } else {
        if (call.method == methodDownloadProgressUpdate) {
          view.onProgressDownload(call.arguments);
        }
      }
    });
  }

  getAssetPath(String name) async {
    await platform.invokeMethod<String>(methodGetAsset, name);
  }
}

class ViewPlayAsset {
  void onProgressDownload(int percentage) {}

  void onAssetPathFound(String path) {}

  void onProcessLoadingAssetPath(String path) {}
}
