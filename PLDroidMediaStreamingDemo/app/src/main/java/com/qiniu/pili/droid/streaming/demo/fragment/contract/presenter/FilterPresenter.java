package com.qiniu.pili.droid.streaming.demo.fragment.contract.presenter;

import com.qiniu.bytedanceplugin.ByteDancePlugin;
import com.qiniu.bytedanceplugin.model.FilterItem;
import com.qiniu.pili.droid.streaming.demo.fragment.contract.FilterContract;

import java.util.ArrayList;
import java.util.List;

public class FilterPresenter extends FilterContract.Presenter {
    private List<FilterItem> mItems = new ArrayList<>();

    @Override
    public List<FilterItem> getItems() {
        if (mItems.size() == 0) {
            mItems.add(new FilterItem().setFilterName("正常"));
            mItems.addAll(ByteDancePlugin.getFilterList());
        }
        return mItems;
    }
}
