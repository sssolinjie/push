package com.example.bdpush;

import androidx.annotation.NonNull;
import android.content.Context;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import com.baidu.techain.ac.Callback;
import com.baidu.techain.ac.TH;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import android.util.Log;

/** BdpushPlugin */
public class BdpushPlugin implements FlutterPlugin, MethodCallHandler {

  private MethodChannel channel;
  private Context context;


  private Result initresult;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    context = flutterPluginBinding.getApplicationContext();
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "bdpush");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if (call.method.equals("initSdk")) {
      initresult = result;
      Map<String, String> params = call.arguments();
      initSDK(params);
    }
    else {
      result.notImplemented();
    }
  }
  void initSDK(Map<String, String> params){
    android.util.Log.d("TAG", params.get("appkey"));
    TH.init(context, params.get("appkey"), params.get("SecKey"));
//    initresult.success(true);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
