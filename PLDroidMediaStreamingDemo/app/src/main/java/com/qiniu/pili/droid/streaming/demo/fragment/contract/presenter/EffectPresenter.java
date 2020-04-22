package com.qiniu.pili.droid.streaming.demo.fragment.contract.presenter;

import android.util.SparseArray;

import com.qiniu.pili.droid.streaming.demo.fragment.contract.EffectContract;
import com.qiniu.pili.droid.streaming.demo.fragment.contract.ItemGetContract;
import com.qiniu.pili.droid.streaming.demo.model.ButtonItem;
import com.qiniu.pili.droid.streaming.demo.model.ComposerNode;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import static com.qiniu.pili.droid.streaming.demo.fragment.contract.ItemGetContract.*;


public class EffectPresenter extends EffectContract.Presenter {

    private ItemGetContract.Presenter mItemGet;

    @Override
    public void removeNodesOfType(SparseArray<ComposerNode> composerNodeMap, int type) {
        removeNodesWithMakAndType(composerNodeMap, MASK, type & MASK);
    }

    @Override
    public void removeProgressInMap(SparseArray<Float> map, int type) {
        List<Integer> nodeToRemove = new ArrayList<>(map.size());
        for (int i = 0; i < map.size(); i++) {
            int key = map.keyAt(i);
            if ((key & MASK) == type) {
                nodeToRemove.add(key);
            }
        }
        for (Integer i : nodeToRemove) {
            map.remove(i);
        }
    }

    private void removeNodesWithMakAndType(SparseArray<ComposerNode> map, int mask, int type) {
        int i = 0;
        ComposerNode node;
        while (i < map.size() && (node = map.valueAt(i)) != null) {
            if ((node.getId() & mask) == type) {
                map.removeAt(i);
            } else {
                i++;
            }
        }
    }

    @Override
    public String[] generateComposerNodes(SparseArray<ComposerNode> composerNodeMap) {
        List<String> list = new ArrayList<>();
        Set<String> set = new HashSet<>();
        for (int i = 0; i < composerNodeMap.size(); i++) {
            ComposerNode node = composerNodeMap.valueAt(i);
            if (set.contains(node.getNode())) {
                continue;
            } else {
                set.add(node.getNode());
            }
            if (isAhead(node)) {
                list.add(0, node.getNode());
            } else {
                list.add(node.getNode());
            }
        }
        return list.toArray(new String[0]);
    }

    @Override
    public void generateDefaultBeautyNodes(SparseArray<ComposerNode> composerNodeMap) {
        if (mItemGet == null) {
            mItemGet = new ItemGetPresenter();
            mItemGet.attachView(getView());
        }
        List<ButtonItem> beautyItems = new ArrayList<>();
        beautyItems.addAll(mItemGet.getItems(TYPE_BEAUTY_FACE));
        beautyItems.addAll(mItemGet.getItems(TYPE_BEAUTY_RESHAPE));

        for (ButtonItem item : beautyItems) {
            if (item.getNode().getId() == TYPE_CLOSE) {
                continue;
            }
            item.getNode().setValue((float) item.getDefaultIntensity());
            composerNodeMap.put(item.getNode().getId(), item.getNode());
        }
    }

    @Override
    public boolean hasIntensity(int type) {
        int parent = type & MASK;
        return parent == TYPE_BEAUTY_FACE || parent == TYPE_BEAUTY_RESHAPE
                || parent == TYPE_MAKEUP || parent == TYPE_MAKEUP_OPTION;
    }

    private boolean isAhead(ComposerNode node) {
        return (node.getId() & MASK) == TYPE_MAKEUP_OPTION;
    }
}
