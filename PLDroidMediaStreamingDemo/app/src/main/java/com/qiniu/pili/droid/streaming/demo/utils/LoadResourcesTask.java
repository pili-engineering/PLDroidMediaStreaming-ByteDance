package com.qiniu.pili.droid.streaming.demo.utils;

import android.content.Context;
import android.os.AsyncTask;

import java.io.File;
import java.io.IOException;
import java.lang.ref.WeakReference;

public class LoadResourcesTask extends AsyncTask<String, Void, Boolean> {

    public interface ILoadResourcesCallback {
        Context getContext();
        void onStartTask();
        void onEndTask(boolean result);
    }

    private WeakReference<ILoadResourcesCallback> mCallback;

    public LoadResourcesTask(ILoadResourcesCallback callback) {
        mCallback = new WeakReference<>(callback);
    }

    @Override
    protected Boolean doInBackground(String... strings) {
        String path = strings[0];
        File dstFile = mCallback.get().getContext().getExternalFilesDir("assets");
        FileUtils.clearDir(new File(dstFile, path));
        try {
            FileUtils.copyAssets(mCallback.get().getContext().getAssets(), path, dstFile.getAbsolutePath());
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    protected void onPreExecute() {
        mCallback.get().onStartTask();
        super.onPreExecute();
    }

    @Override
    protected void onPostExecute(Boolean result) {
        super.onPostExecute(result);
        mCallback.get().onEndTask(result);
    }
}
