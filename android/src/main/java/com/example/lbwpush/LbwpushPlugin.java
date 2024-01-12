package com.example.lbwpush;
import android.content.Context;
import android.content.Intent;
import androidx.annotation.NonNull;

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
import android.util.Pair;
import java.util.List;
import android.provider.Settings;
import android.content.IntentFilter;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.IntentFilter;



/** LbwpushPlugin */
public class LbwpushPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  public MethodChannel channel;
  private Context context;
  private Result pushUidResult;
  private Result aliasResult;
  private Result havetagResult;
  private Result tagResult;
  private Result areNotificationsEnabledResult;
  private Result myresult;


  public static LbwpushPlugin instance;


  public LbwpushPlugin() {
        instance = this;
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    context = flutterPluginBinding.getApplicationContext();
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "lbwpush");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    myresult = result;
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
      
    } 
    else if(call.method.equals("initsdk")){
        Map<String, String> params = call.arguments();
        initsdk(params);
    }
    else if(call.method.equals("startPushService")){
      startPushService();
    }
    else if (call.method.equals("getPushUid")) {
      pushUidResult = result;
      getPushUid();
    } 
    else if (call.method.equals("setAlias")) {
      String alias = call.arguments();
      setAlias(alias);
    } 
    else if (call.method.equals("getAlias")) {
      aliasResult = result;
      getAlias();
    } 
    else if (call.method.equals("deleteAlias")) {
      
      deleteAlias();
    } 
    else if (call.method.equals("addTags")) {
      ArrayList<String> tags = call.arguments();
      addTags(tags);
    } 
    else if (call.method.equals("deleteTags")) {
      ArrayList<String> tags = call.arguments();
      deleteTags(tags);
    } 
    else if (call.method.equals("updateTags")) {
      ArrayList<String> tags = call.arguments();
      updateTags(tags);
    } 
    else if (call.method.equals("cleanTags")) {
      
      cleanTags();
    } 
    else if (call.method.equals("isTagBinding")) {
      havetagResult = result;
      String tag = call.arguments();
      isTagBinding(tag);
    } 
    else if (call.method.equals("getAllTags")) {
      tagResult = result;
      getAllTags();
    } 
    else if (call.method.equals("areNotificationsEnabled")) {
      areNotificationsEnabledResult = result;
      areNotificationsEnabled();
    } 
    else if (call.method.equals("showNotificationGuide")) {
      showNotificationGuide();
    } 
    
    else {
      result.notImplemented();
    }
  }

 
  ///初始化sdk
  public void initsdk(Map<String, String> params){
    TH.setAgreePolicy(context, true);
    TH.init(context, params.get("appkey"), params.get("SecKey"));
  }

  ///开启服务
  public void startPushService(){
    TH.tinvoke(100019, "setNotificationEnableInForeground",new Class[]  { boolean.class },  false);
    TH.startPushService();
  }

  ///获取uid
  public void getPushUid(){
    TH.tinvoke(100019, "getPushUid", new Callback() {
                        @Override
                        public Object onEnd(Object... arg0) {
                            final String uid = (String) arg0[0];
                            pushUidResult.success(uid);
                            return null;
                        }
                        @Override
                        public Object onError(Object... arg0) {
                          android.util.Log.d("获取PushId异常，错误码为:" + arg0[0].toString(), "0");
                          pushUidResult.success("");
                            return null;
                        }
                    });
  }

  ///设置别名
  public void setAlias(String alias){
    TH.tinvoke(100019, "setAlias", new Callback() {
                    @Override
                    public Object onEnd(Object... arg0) {
                        android.util.Log.d("setAlias onEnd::" + arg0[0].toString(), "0");
                         android.util.Log.d("" + arg0[0].toString(), "");
                         if((Integer)arg0[0] == 0){
                            myresult.success(true);
                          }else{
                            myresult.success(false);
                         }
                        return null;
                    }

                    @Override
                    public Object onError(Object... arg0) {
                      android.util.Log.d("setAlias onError::" + arg0[0].toString(), "0");
                        myresult.success(false);
                        return null;
                    }
                }, new Class[]{String.class}, alias);
  }

  ///获取别名
  public void getAlias(){
    TH.tinvoke(100019, "getAlias", new Callback() {
                    @Override
                    public Object onEnd(Object... arg0) {
                        Pair<Integer, String> pair = (Pair<Integer, String>) arg0[0];
                        android.util.Log.d("getAlias onEnd " + pair.first + ", " + pair.second, "");
                        

                        aliasResult.success(pair.second);
                          
                        return null;
                    }

                    @Override
                    public Object onError(Object... arg0) {
                        android.util.Log.d("getAlias", "onError" + arg0[0].toString()); 
                        aliasResult.success(""); 
                        return null;
                    }
                });
  }

  ///删除别名
  public void deleteAlias(){
    TH.tinvoke(100019, "deleteAlias", new Callback() {
                    @Override
                    public Object onEnd(Object... arg0) {
                        android.util.Log.d("deleteAlias", "onEnd：" + arg0[0].toString()); 
                        if((Integer)arg0[0] == 0){
                            myresult.success(true);
                          }else{
                            myresult.success(false);
                         } 
                        return null;
                    }

                    @Override
                    public Object onError(Object... arg0) {
                     android.util.Log.d("deleteAlias", "onError" + arg0[0].toString());  
                     myresult.success(false);
                      return null;
                    }
                });
  }

  //添加标签
  public void addTags(ArrayList<String> value){
   
    String[] tags = value.toArray(new String[value.size()]);
    TH.tinvoke(100019, "addTags", new Callback() {
                    @Override
                    public Object onEnd(Object... arg0) {
                        android.util.Log.d("addTags", "onEnd：" + arg0[0].toString()); 
                        if((Integer)arg0[0] == 0){
                            myresult.success(true);
                          }else{
                            myresult.success(false);
                         }
                        return null;
                    }

                    @Override
                    public Object onError(Object... arg0) {
                        android.util.Log.d("addTags", "onError" + arg0[0].toString());
                        myresult.success(false);  
                        return null;
                    }
                }, new Class[]{String[].class}, new Object[]{tags});
  }

  ///删除标签
  public void deleteTags(ArrayList<String> value){
    String[] tags = value.toArray(new String[value.size()]);
    TH.tinvoke(100019, "deleteTags", new Callback() {
                    @Override
                    public Object onEnd(Object... arg0) {
                        android.util.Log.d("deleteTags", "onEnd：" + arg0[0].toString());
                        if((Integer)arg0[0] == 0){
                            myresult.success(true);
                          }else{
                            myresult.success(false);
                         }
                        return null;
                    }

                    @Override
                    public Object onError(Object... arg0) {
                        android.util.Log.d("deleteTags", "onError" + arg0[0].toString());
                        myresult.success(false);
                        return null;
                    }
                }, new Class[]{String[].class}, new Object[]{tags});
  }
  ///更新标签
  public void updateTags(ArrayList<String> value){
    String[] tags = value.toArray(new String[value.size()]);
    TH.tinvoke(100019, "updateTags", new Callback() {
                    @Override
                    public Object onEnd(Object... arg0) {
                        android.util.Log.d("updateTags", "onEnd：" + arg0[0].toString());
                        if((Integer)arg0[0] == 0){
                            myresult.success(true);
                          }else{
                            myresult.success(false);
                         }
                        return null;
                    }

                    @Override
                    public Object onError(Object... arg0) {
                        android.util.Log.d("updateTags", "onError" + arg0[0].toString());
                        myresult.success(false);
                        return null;
                    }
                }, new Class[]{String[].class}, new Object[]{tags});
  }

  ///清空标签
  public void cleanTags(){
    TH.tinvoke(100019, "cleanTags", new Callback() {
                    @Override
                    public Object onEnd(Object... arg0) {
                         android.util.Log.d("cleanTags", "onEnd：" + arg0[0].toString());
                         if((Integer)arg0[0] == 0){
                            myresult.success(true);
                          }else{
                            myresult.success(false);
                         }
                        return null;
                    }

                    @Override
                    public Object onError(Object... arg0) {
                         android.util.Log.d("cleanTags", "onError" + arg0[0].toString());
                         myresult.success(false);
                        return null;
                    }
                });
  }
  ///查询单个标签
  public void isTagBinding(String tag){
    TH.tinvoke(100019, "isTagBinding", new Callback() {
                    @Override
                    public Object onEnd(Object... arg0) {
                        android.util.Log.d("isTagBinding", "onEnd：" + arg0[0].toString());
                        if((Integer)arg0[0] == 0){
                          havetagResult.success(true);
                        }else{
                          havetagResult.success(false);
                        }
                        
                        return null;
                    }

                    @Override
                    public Object onError(Object... arg0) {
                        android.util.Log.d("isTagBinding", "onError" + arg0[0].toString());
                        havetagResult.success(false);
                        return null;
                    }
                }, new Class[]{String.class}, tag);
  }

  ///获取所有的标签
  public void getAllTags(){
    TH.tinvoke(100019, "getAllTags", new Callback() {
                    @Override
                    public Object onEnd(Object... arg0) {
                        if (arg0 != null) {
                            Pair<Integer, List<String>> pair = (Pair<Integer, List<String>>) arg0[0];
                            android.util.Log.d("getAllTags onEnd " + pair.first + ", " + pair.second, "");
                          if(pair.first == 0){
                            String res = "";
                            for (String i : pair.second) {
                                res += i + ",";
                            }
                            int length = res.length(); // 获取字符串长度
                            res = res.substring(0, length - 1);
                            tagResult.success(res);
                          }else{
                            tagResult.success("");
                          }
                        }

                        return null;
                    }
                    @Override
                    public Object onError(Object... arg0) {
                        android.util.Log.d("getAllTags", "onError" + arg0[0].toString());
                        tagResult.success("");
                        return null;
                    }
                });
  }


  ///是否有通知栏权限
  public void areNotificationsEnabled(){
    TH.tinvoke(100019, "areNotificationsEnabled", new Callback() {
                    @Override
                    public Object onEnd(Object... arg0) {
                        android.util.Log.d("areNotificationsEnabled", "onEnd" + arg0[0].toString());
                        if(arg0[0].toString() == "true"){
                          areNotificationsEnabledResult.success(true);
                        }else{
                          areNotificationsEnabledResult.success(false);
                        }
                        return null;
                    }

                    @Override
                    public Object onError(Object... arg0) {
                        android.util.Log.d("areNotificationsEnabled", "onError" + arg0[0].toString());
                        areNotificationsEnabledResult.success(false);
                        return null;
                    }
                });
  }

  ///通知引导
  public void showNotificationGuide(){
    TH.tinvoke(100019, "showNotificationGuide", new Callback() {
                    @Override
                    public Object onEnd(Object... arg0) {
                        android.util.Log.d("showNotificationGuide", "onEnd" + arg0[0].toString());
                        if((Integer)arg0[0] == 1){
                          myresult.success(true);
                        }else{
                          myresult.success(false);
                        }
                        return null;
                    }
                    @Override
                    public Object onError(Object... arg0) {
                        android.util.Log.d("showNotificationGuide", "onError" + arg0[0].toString());
                        myresult.success(false);
                        return null;
                    }
                });
  }



  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
 