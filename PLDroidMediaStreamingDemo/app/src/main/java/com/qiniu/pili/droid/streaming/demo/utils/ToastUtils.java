package com.qiniu.pili.droid.streaming.demo.utils;

import android.content.Context;
import android.widget.Toast;

public class ToastUtils {

    private static Context mAppContext = null;

    public static void init(Context context) {
        mAppContext = context;
    }

    public static void showShortMessage(String msg) {
        if (mAppContext != null) {
            Toast.makeText(mAppContext, msg, Toast.LENGTH_SHORT).show();
        }
    }

    public static void showLongMessage(String msg) {
        if (mAppContext != null) {
            Toast.makeText(mAppContext, msg, Toast.LENGTH_LONG).show();
        }
    }
}
