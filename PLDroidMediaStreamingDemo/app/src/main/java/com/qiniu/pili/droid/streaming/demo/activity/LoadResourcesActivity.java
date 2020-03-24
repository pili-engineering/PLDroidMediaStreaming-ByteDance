package com.qiniu.pili.droid.streaming.demo.activity;

import android.content.Context;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.ProgressBar;
import android.widget.Toast;

import com.qiniu.pili.droid.streaming.demo.R;
import com.qiniu.pili.droid.streaming.demo.utils.LoadResourcesTask;
import com.qiniu.pili.droid.streaming.demo.utils.SharedPreferencesUtils;


public class LoadResourcesActivity extends AppCompatActivity implements LoadResourcesTask.ILoadResourcesCallback {

    private static final String DST_FOLDER = "resource";
    private Button mBtStart;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_load_resources);
        initView();
        startTask();
    }

    private void initView() {
        mBtStart = findViewById(R.id.bt_start);
    }

    public void startTask() {
        LoadResourcesTask mTask = new LoadResourcesTask(this);
        mTask.execute(DST_FOLDER);
    }

    @Override
    public void onStartTask() {
        mBtStart.setEnabled(false);
        mBtStart.setText("资源准备中");
    }

    @Override
    public void onEndTask(boolean result) {
        if (result) {
            SharedPreferencesUtils.setResourceReady(this, result);
            Toast.makeText(LoadResourcesActivity.this,"资源准备就绪",Toast.LENGTH_SHORT).show();
            mBtStart.setText("开始");
            mBtStart.setEnabled(true);
            finish();
        } else {
            Toast.makeText(LoadResourcesActivity.this,"资源处理失败",Toast.LENGTH_SHORT).show();
        }
    }

    @Override
    public Context getContext() {
        return getApplicationContext();
    }

}
