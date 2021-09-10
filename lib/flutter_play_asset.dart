import 'package:flutter/services.dart';

class FlutterPlayAsset {
  final methodDownloadProgressUpdate = "playasset_download_progress_update";
  final methodGetAsset = "get_asset";
  final methodGetError = "get_error";
  final methodCheckAssetFolderPath = "check_asset_folder_path";
  final methodPlayAssetStart = "playasset_start";
  final methodPlayAssetFail = "playasset_fail";
  final methodPlayAssetNull = "playasset_null";
  final methodPlayAssetCompleted = "playasset_completed";
  final methodPlayAssetSize = "playasset_size";
  static const platform = MethodChannel('basictomodular/downloadservice');
  late ViewPlayAsset view;

  Future<void> init(ViewPlayAsset vw) async {
    view = vw;
    platform.setMethodCallHandler((call) async {
      print('platform channel method call ${call.method} ${call.arguments}');
      if (call.method == methodCheckAssetFolderPath) {
        view.onCheckAssetFolderPath(call.arguments.toString());
      } else if (call.method == methodPlayAssetStart) {
        view.onAssetStart(call.arguments.toString());
      } else if (call.method == methodPlayAssetFail) {
        view.onAssetFail(call.arguments.toString());
      } else if (call.method == methodPlayAssetNull) {
        view.onAssetNull(call.arguments.toString());
      } else if (call.method == methodPlayAssetCompleted) {
        view.onAssetCompleted(call.arguments.toString());
      } else if (call.method == methodDownloadProgressUpdate) {
        view.onProgressDownload(call.arguments);
      } else if (call.method == methodGetError) {
        view.errorMessage(call.arguments.toString());
      } else if (call.method == methodPlayAssetSize) {
        view.totalSize(call.arguments);
      }
    });
  }

  getAssetPath(String name) async {
    await platform.invokeMethod<String>(methodGetAsset, name);
  }
}

class ViewPlayAsset {
  void errorMessage(String error) {}

  void totalSize(int size) {}

  void onProgressDownload(int percentage) {}

  void onCheckAssetFolderPath(String path) {}

  void onAssetStart(String message) {}

  void onAssetFail(String message) {}

  void onAssetNull(String message) {}

  void onAssetCompleted(String message) {}
}
