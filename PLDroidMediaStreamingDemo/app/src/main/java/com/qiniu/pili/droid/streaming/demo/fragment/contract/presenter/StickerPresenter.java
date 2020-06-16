package com.qiniu.pili.droid.streaming.demo.fragment.contract.presenter;

import com.qiniu.bytedanceplugin.ByteDancePlugin;
import com.qiniu.bytedanceplugin.model.StickerModel;
import com.qiniu.pili.droid.streaming.demo.fragment.contract.StickerContract;

import java.util.ArrayList;
import java.util.List;

public class StickerPresenter extends StickerContract.Presenter {
    private List<StickerModel> mStickerItems = new ArrayList<>();
    @Override
    public List<StickerModel> getStickersItems() {
        if (mStickerItems.size() == 0) {
            mStickerItems.add(0,new StickerModel());
            mStickerItems.addAll(ByteDancePlugin.getStickerList());
        }
        return mStickerItems;
    }
}
