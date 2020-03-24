package com.qiniu.pili.droid.streaming.demo.fragment.contract.presenter;

import com.qiniu.bytedanceplugin.ByteDancePlugin;
import com.qiniu.bytedanceplugin.model.StickerItem;
import com.qiniu.pili.droid.streaming.demo.fragment.contract.StickerContract;

import java.util.ArrayList;
import java.util.List;

public class StickerPresenter extends StickerContract.Presenter {
    private List<StickerItem> mStickerItems = new ArrayList<>();
    @Override
    public List<StickerItem> getStickersItems() {
        if (mStickerItems.size() == 0) {
            mStickerItems.add(0,new StickerItem());
            mStickerItems.addAll(ByteDancePlugin.getStickerList());
        }
        return mStickerItems;
    }

}
