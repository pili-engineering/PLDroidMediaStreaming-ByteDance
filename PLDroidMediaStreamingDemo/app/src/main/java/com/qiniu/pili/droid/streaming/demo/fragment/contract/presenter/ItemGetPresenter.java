package com.qiniu.pili.droid.streaming.demo.fragment.contract.presenter;

import android.util.SparseArray;

import com.qiniu.bytedanceplugin.ByteDancePlugin;
import com.qiniu.bytedanceplugin.model.ComposerModel;
import com.qiniu.bytedanceplugin.model.ComposerType;
import com.qiniu.bytedanceplugin.model.MakeupModel;
import com.qiniu.pili.droid.streaming.demo.fragment.contract.ItemGetContract;
import com.qiniu.pili.droid.streaming.demo.model.ButtonItem;
import com.qiniu.pili.droid.streaming.demo.model.ComposerNode;

import java.util.ArrayList;
import java.util.List;

import static com.qiniu.pili.droid.streaming.demo.fragment.contract.ItemGetContract.*;

public class ItemGetPresenter extends ItemGetContract.Presenter {
    private static int mMakeupHairId;
    private static SparseArray<String> mMakeupTypeArray;

    @Override
    public List<ButtonItem> getItems(int type) {
        List<ButtonItem> items = new ArrayList<>();
        items.add(new ButtonItem(null, "清除", 0d, new ComposerNode(TYPE_CLOSE)));
        List<ComposerModel> composerModels;
        switch (type & MASK) {
            case TYPE_BEAUTY_FACE:
                composerModels = ByteDancePlugin.getComposerList(ComposerType.BEAUTY);
                break;
            case TYPE_BEAUTY_RESHAPE:
                composerModels = ByteDancePlugin.getComposerList(ComposerType.RESHAPE);
                break;
            case TYPE_BEAUTY_BODY:
                composerModels = ByteDancePlugin.getComposerList(ComposerType.BODY);
                break;
            default:
                composerModels = new ArrayList<>();
                break;
        }
        if ((type & MASK) == TYPE_MAKEUP) {
            List<MakeupModel> makeupModels = ByteDancePlugin.getMakeupList();
            mMakeupTypeArray = new SparseArray<>();
            int i = 1;
            for (MakeupModel makeupModel : makeupModels) {
                int id = TYPE_MAKEUP_OPTION + (i << SUB_OFFSET);
                items.add(new ButtonItem(makeupModel.getIconPath(), makeupModel.getDisplayName(), 0,
                        new ComposerNode(id)));
                mMakeupTypeArray.put(id, makeupModel.getEffectType());
                if ("hair".equals(makeupModel.getEffectType())) {
                    mMakeupHairId = id;
                }
                i++;
            }
        } else {
            if ((type & MASK)==TYPE_MAKEUP_OPTION){
                fillMakeupOptionItems(type,items);
            }else {
                int i = 1;
                for (ComposerModel composerModel : composerModels) {
                    items.add(new ButtonItem(composerModel.getIconPath(), composerModel.getDisplayName(), composerModel.getDefaultIntensity(),
                            new ComposerNode((type & MASK) + (i << SUB_OFFSET), composerModel.getFilePath(), composerModel.getKey())));
                    i++;
                }
            }
        }
        return items;
    }

    private void fillMakeupOptionItems(int id, List<ButtonItem> items) {
        List<MakeupModel> makeupModels = ByteDancePlugin.getMakeupList();
        String type = mMakeupTypeArray.get(id);
        for (int i = 0; i < makeupModels.size(); i++) {
            if (makeupModels.get(i).getEffectType().equals(type)) {
                List<ComposerModel> composerModels = makeupModels.get(i).getEffects();
                for (ComposerModel composerModel : composerModels) {
                    items.add(new ButtonItem(composerModel.getIconPath(), composerModel.getDisplayName(), composerModel.getDefaultIntensity(),
                            new ComposerNode(TYPE_MAKEUP_OPTION + ((i+1) << SUB_OFFSET), composerModel.getFilePath(), composerModel.getKey())));

                }
            }
        }

    }

    @Override
    public boolean isHairType(int id) {
        return id == mMakeupHairId;
    }
}
