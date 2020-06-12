package com.qiniu.pili.droid.streaming.demo.adapter;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.qiniu.bytedanceplugin.model.StickerModel;
import com.qiniu.pili.droid.streaming.demo.R;

import java.util.List;

public class StickerRVAdapter extends SelectRVAdapter<StickerRVAdapter.ViewHolder> {
    private List<StickerModel> mStickerList;
    private OnItemClickListener mListener;

    public StickerRVAdapter(List<StickerModel> stickers, OnItemClickListener listener) {
        mStickerList = stickers;
        mListener = listener;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        return new ViewHolder(LayoutInflater.from(parent.getContext())
                .inflate(R.layout.item_sticker, parent, false));
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, final int position) {
        final StickerModel item = mStickerList.get(position);

        if (mSelect == position) {
            holder.ll.setBackgroundResource(R.drawable.bg_item_select_selector);
        } else {
            holder.ll.setBackgroundResource(R.drawable.bg_item_unselect_selector);
        }

        if (item.getIconPath() != null) {
            Bitmap bitmap = BitmapFactory.decodeFile(item.getIconPath());
            holder.iv.setImageBitmap(bitmap);
            holder.tv.setText(item.getDisplayName());
        } else {
            holder.iv.setImageResource(R.drawable.clear);
            holder.tv.setText("清除");
        }

        holder.ll.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mSelect != position) {
                    mListener.onItemClick(item);
                    setSelect(position);
                }
            }
        });
    }

    @Override
    public int getItemCount() {
        return mStickerList.size();
    }

    public interface OnItemClickListener {
        void onItemClick(StickerModel item);
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        LinearLayout ll;
        ImageView iv;
        TextView tv;

        ViewHolder(View itemView) {
            super(itemView);
            ll = itemView.findViewById(R.id.ll_item_sticker);
            iv = itemView.findViewById(R.id.iv_item_sticker);
            tv = itemView.findViewById(R.id.tv_item_sticker);
        }
    }
}
