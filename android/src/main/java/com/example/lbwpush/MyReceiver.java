package com.example.lbwpush;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;


public class MyReceiver extends BroadcastReceiver {
    private static final String PUSH_ACTION = "com.baidu.techain.push.action.PUSH_EVENT";
    private static final int TYPE_REGISTRATION = 1;
    private static final int TYPE_NOTIFICATION_OPENED = 5;
    @Override
    public void onReceive(Context arg0, Intent arg1) {
        String action = arg1.getAction();
        if (!PUSH_ACTION.equals(action)) {
            return;
        }
        Bundle bundle = arg1.getExtras();
        int type = bundle.getInt("event_type", -1);
        Log.d("321", "123");
        switch (type) {
            case TYPE_REGISTRATION:
                LbwpushPlugin.instance.channel.invokeMethod("initsucces", "");
                break;
            case TYPE_NOTIFICATION_OPENED:
                String extra2 = bundle.getString("extra");
                if (!TextUtils.isEmpty(extra2)) {
                    Log.d("Push_Demo", "TYPE_NOTIFICATION_RECEIVED extra=" + extra2);
                    LbwpushPlugin.instance.channel.invokeMethod("onNotification",  extra2);
                }
                break;
        }
    }
}