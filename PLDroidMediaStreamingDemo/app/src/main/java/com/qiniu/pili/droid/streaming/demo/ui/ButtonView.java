package com.qiniu.pili.droid.streaming.demo.ui;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.Drawable;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.ActivityCompat;
import android.support.v4.graphics.drawable.DrawableCompat;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.qiniu.pili.droid.streaming.demo.R;

public class ButtonView extends FrameLayout {
    public static final float WH_RATIO = 1F;

    private int colorOn;
    private int colorOff;

    private LinearLayout llContent;
    private ImageView iv;
    private TextView tvTitle;
    private TextView tvDesc;
    private View vPoint;

    private boolean isOn = false;

    public ButtonView(@NonNull Context context) {
        super(context);
        init(context);
    }

    public ButtonView(@NonNull Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
        init(context);
        initAttr(context, attrs);
    }

    public ButtonView(@NonNull Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        init(context);
        initAttr(context, attrs);
    }

    @Override
    public void setOnClickListener(@Nullable final OnClickListener l) {
        llContent.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                if (l != null) {
                    l.onClick(ButtonView.this);
                }
            }
        });
    }

    private void init(Context context) {
        llContent = (LinearLayout) LayoutInflater
                .from(context).inflate(R.layout.view_face_options, this, false);
        addView(llContent);

        llContent.post(new Runnable() {
            @Override
            public void run() {
                int height = llContent.getHeight();
                LayoutParams lp = (LayoutParams) llContent.getLayoutParams();
                lp.width = (int) (height * WH_RATIO);
                llContent.setLayoutParams(lp);
            }
        });

        iv = findViewById(R.id.iv_face_options);
        tvTitle = findViewById(R.id.tv_title_face_options);
        tvDesc = findViewById(R.id.tv_desc_face_options);
        vPoint = findViewById(R.id.v_face_options);

        colorOn = ActivityCompat.getColor(context, R.color.white);
        colorOff = ActivityCompat.getColor(context, R.color.grey);
    }

    private void initAttr(Context context, AttributeSet attr) {
        TypedArray arr = context.obtainStyledAttributes(attr, R.styleable.ButtonView);

        int resource = arr.getResourceId(R.styleable.ButtonView_src, 0);
        String title = arr.getString(R.styleable.ButtonView_title);
        String desc = arr.getString(R.styleable.ButtonView_desc);
        iv.setImageResource(resource);
        tvTitle.setText(title);
        if (desc == null || desc.isEmpty()) {
            tvDesc.setVisibility(GONE);
        } else {
            tvDesc.setVisibility(VISIBLE);
            tvDesc.setText(desc);
        }

        arr.recycle();
    }

    public void setIconPath(String iconPath) {
        if (iconPath!=null){
            Bitmap bitmap = BitmapFactory.decodeFile(iconPath);
            iv.setImageBitmap(bitmap);
        }else {
            iv.setImageResource(R.drawable.clear);
        }
    }

    public void setTitle(String title) {
        if (title.isEmpty()) {
            tvTitle.setVisibility(GONE);
        } else {
            tvTitle.setVisibility(VISIBLE);
            tvTitle.setText(title);
        }
    }

    public void setDesc(String desc) {
        if (desc == null || desc.isEmpty()) {
            tvDesc.setVisibility(GONE);
        } else {
            tvDesc.setVisibility(VISIBLE);
            tvDesc.setText(desc);
        }
    }

    public void on() {
        isOn = true;
        setColor(colorOn);
    }

    public void off() {
        isOn = false;
        setColor(colorOff);
    }

    public void pointChange(boolean on) {
        if (on) {
            vPoint.setBackgroundResource(R.drawable.bg_face_options_point);
        } else {
            vPoint.setBackgroundResource(0);
        }
    }

    public boolean isOn() {
        return isOn;
    }

    private void setColor(int color) {
        Drawable drawable = iv.getDrawable();
        DrawableCompat.setTint(drawable, color);
        iv.setImageDrawable(drawable);

        tvTitle.setTextColor(color);
        tvDesc.setTextColor(color);
    }
}
